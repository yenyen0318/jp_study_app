import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/core/widgets/zen_dot_loader.dart';
import 'package:jp_study_app/core/widgets/zen_empty_state.dart';
import 'package:jp_study_app/core/widgets/zen_error_state.dart';

/// 禪意非同步狀態建構器
///
/// 統一處理 AsyncValue 的 loading/data/error/empty 四種狀態,
/// 提供一致的禪意體驗。
///
/// 使用範例:
/// ```dart
/// ZenAsyncBuilder<List<Item>>(
///   value: asyncValue,
///   data: (items) => ListView.builder(...),
///   emptyMessage: '沒有找到相關的內容',
///   emptySubtitle: '試試調整篩選條件吧',
/// )
/// ```
class ZenAsyncBuilder<T> extends StatefulWidget {
  /// AsyncValue 狀態
  final AsyncValue<T> value;

  /// 資料狀態的建構器
  final Widget Function(T data) data;

  /// 自訂 loading 元件(可選,預設使用 ZenDotLoader())
  final Widget? skeleton;

  /// 自訂空白狀態主要訊息(可選)
  final String? emptyMessage;

  /// 自訂空白狀態次要訊息(可選)
  final String? emptySubtitle;

  /// 自訂錯誤狀態主要訊息(可選)
  final String? errorMessage;

  /// 自訂錯誤狀態次要訊息(可選)
  final String? errorSubtitle;

  /// 判斷資料是否為空的函數(可選,預設檢查 List/Iterable 是否為空)
  final bool Function(T data)? emptyChecker;

  const ZenAsyncBuilder({
    super.key,
    required this.value,
    required this.data,
    this.skeleton,
    this.emptyMessage,
    this.emptySubtitle,
    this.errorMessage,
    this.errorSubtitle,
    this.emptyChecker,
  });

  @override
  State<ZenAsyncBuilder<T>> createState() => _ZenAsyncBuilderState<T>();
}

class _ZenAsyncBuilderState<T> extends State<ZenAsyncBuilder<T>> {
  DateTime? _loadingStartTime;
  bool _isMinimumLoadingTimeElapsed = false;

  @override
  void didUpdateWidget(ZenAsyncBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 檢測從非 loading 進入 loading 狀態
    final wasLoading = oldWidget.value.isLoading;
    final isLoading = widget.value.isLoading;

    if (!wasLoading && isLoading) {
      // 開始 loading,記錄時間
      _loadingStartTime = DateTime.now();
      _isMinimumLoadingTimeElapsed = false;

      // 600ms 後標記為可切換
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() {
            _isMinimumLoadingTimeElapsed = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 如果正在 loading 且未達最小時間,強制顯示 loading
    final shouldShowLoading =
        widget.value.isLoading ||
        (_loadingStartTime != null && !_isMinimumLoadingTimeElapsed);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450), // 稍微加長過渡時間
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: shouldShowLoading
          ? KeyedSubtree(
              key: const ValueKey('loading'),
              child: widget.skeleton ?? const ZenDotLoader(),
            )
          : widget.value.when(
              data: (d) {
                // 檢查是否為空
                final isEmpty = _checkIfEmpty(d);
                if (isEmpty) {
                  return ZenEmptyState(
                    key: const ValueKey('empty'),
                    message: widget.emptyMessage ?? '目前沒有內容',
                    subtitle: widget.emptySubtitle,
                  );
                }
                return KeyedSubtree(
                  key: const ValueKey('data'),
                  child: widget.data(d),
                );
              },
              loading: () => KeyedSubtree(
                key: const ValueKey('loading'),
                child: widget.skeleton ?? const ZenDotLoader(),
              ),
              error: (error, stack) => ZenErrorState(
                key: const ValueKey('error'),
                message: widget.errorMessage ?? '嗯...好像遇到了一點小問題',
                subtitle: widget.errorSubtitle ?? '休息一下,等等再試試吧',
              ),
            ),
    );
  }

  /// 檢查資料是否為空
  bool _checkIfEmpty(T d) {
    // 使用自訂的檢查函數
    if (widget.emptyChecker != null) {
      return widget.emptyChecker!(d);
    }

    // 預設檢查邏輯:List 或 Iterable
    if (d is List) {
      return d.isEmpty;
    }
    if (d is Iterable) {
      return d.isEmpty;
    }

    // 其他類型預設不為空
    return false;
  }
}

/// Sliver 版本的禪意非同步狀態建構器
///
/// 適用於 CustomScrollView 中的 Sliver 元件。
class SliverZenAsyncBuilder<T> extends StatelessWidget {
  /// AsyncValue 狀態
  final AsyncValue<T> value;

  /// 資料狀態的建構器(必須返回 Sliver)
  final Widget Function(T data) data;

  /// 自訂骨架屏(可選)
  final Widget? skeleton;

  /// 自訂空白狀態主要訊息(可選)
  final String? emptyMessage;

  /// 自訂空白狀態次要訊息(可選)
  final String? emptySubtitle;

  /// 自訂錯誤狀態主要訊息(可選)
  final String? errorMessage;

  /// 自訂錯誤狀態次要訊息(可選)
  final String? errorSubtitle;

  /// 判斷資料是否為空的函數(可選)
  final bool Function(T data)? emptyChecker;

  const SliverZenAsyncBuilder({
    super.key,
    required this.value,
    required this.data,
    this.skeleton,
    this.emptyMessage,
    this.emptySubtitle,
    this.errorMessage,
    this.errorSubtitle,
    this.emptyChecker,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (d) {
        // 檢查是否為空
        final isEmpty = _checkIfEmpty(d);
        if (isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 400, // 固定高度避免 intrinsic dimensions 計算
              child: ZenEmptyState(
                message: emptyMessage ?? '目前沒有內容',
                subtitle: emptySubtitle,
              ),
            ),
          );
        }
        return data(d);
      },
      loading: () => SliverToBoxAdapter(
        child: SizedBox(height: 400, child: skeleton ?? const ZenDotLoader()),
      ),
      error: (error, stack) => SliverToBoxAdapter(
        child: SizedBox(
          height: 400,
          child: ZenErrorState(
            message: errorMessage ?? '嗯...好像遇到了一點小問題',
            subtitle: errorSubtitle ?? '休息一下,等等再試試吧',
          ),
        ),
      ),
    );
  }

  /// 檢查資料是否為空
  bool _checkIfEmpty(T d) {
    if (emptyChecker != null) {
      return emptyChecker!(d);
    }

    if (d is List) {
      return d.isEmpty;
    }
    if (d is Iterable) {
      return d.isEmpty;
    }

    return false;
  }
}
