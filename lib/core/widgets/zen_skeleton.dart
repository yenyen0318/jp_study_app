import 'package:flutter/material.dart';
import 'package:jp_study_app/core/theme/theme.dart';

/// 禪意骨架屏元件
///
/// 提供「呼吸感」的骨架屏動畫,取代 CircularProgressIndicator。
///
/// 設計理念:
/// - 使用微弱的「呼吸效果」漸變
/// - 動畫週期 2000ms,保持平靜
/// - 極淺的色彩,避免視覺干擾
class ZenSkeleton extends StatefulWidget {
  /// 骨架屏高度
  final double height;

  /// 骨架屏寬度(null 為撐滿)
  final double? width;

  const ZenSkeleton({super.key, this.height = 120.0, this.width});

  /// 列表骨架屏 (3-5 個漸變矩形)
  static Widget list({int count = 4}) {
    return _ZenSkeletonList(count: count);
  }

  /// 單卡骨架屏
  factory ZenSkeleton.card() {
    return const ZenSkeleton(height: 120.0);
  }

  /// 網格骨架屏
  static Widget grid({required int crossAxisCount, int rowCount = 3}) {
    return _ZenSkeletonGrid(crossAxisCount: crossAxisCount, rowCount: rowCount);
  }

  @override
  State<ZenSkeleton> createState() => _ZenSkeletonState();
}

class _ZenSkeletonState extends State<ZenSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500), // 減慢速度,避免镘3爍
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zen = context.zen;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(zen.radius.md),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                zen.borderSubtle.withValues(alpha: 0.3), // 更淺的起始色
                zen.textPrimary.withValues(alpha: 0.015), // 極淡的中間色
                zen.borderSubtle.withValues(alpha: 0.3), // 更淺的結束色
              ],
              stops: [0.0, _animation.value, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// 列表骨架屏實作
class _ZenSkeletonList extends StatelessWidget {
  final int count;

  const _ZenSkeletonList({required this.count});

  @override
  Widget build(BuildContext context) {
    final zen = context.zen;

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      separatorBuilder: (context, index) => SizedBox(height: zen.spacing.md),
      itemBuilder: (context, index) => const ZenSkeleton(height: 100.0),
    );
  }
}

/// 網格骨架屏實作
class _ZenSkeletonGrid extends StatelessWidget {
  final int crossAxisCount;
  final int rowCount;

  const _ZenSkeletonGrid({
    required this.crossAxisCount,
    required this.rowCount,
  });

  @override
  Widget build(BuildContext context) {
    final zen = context.zen;
    final totalItems = crossAxisCount * rowCount;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: zen.spacing.md,
        crossAxisSpacing: zen.spacing.md,
        childAspectRatio: 1.0,
      ),
      itemCount: totalItems,
      itemBuilder: (context, index) => const ZenSkeleton(height: 80.0),
    );
  }
}
