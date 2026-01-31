import 'package:flutter/material.dart';

import 'package:jp_study_app/core/theme/theme.dart';

class ZenToast extends StatelessWidget {
  final String message;
  final ZenTheme theme;

  const ZenToast({super.key, required this.message, required this.theme});

  /// 顯示 ZenToast 的靜態方法
  static void show(BuildContext context, String message) {
    if (!context.mounted) return;

    final overlay = Overlay.of(context);
    final theme = Theme.of(context).extension<ZenTheme>();

    if (theme == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => _ZenToastAnimation(message: message, theme: theme),
    );

    overlay.insert(overlayEntry);

    // 自動移除
    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: theme.bgSurface,
        borderRadius: BorderRadius.circular(theme.radius.full), // 圓潤的膠囊形狀
        border: Border.all(
          color: theme.error.withValues(alpha: 0.8),
          width: 0.5,
        ), // 使用錯誤色作為邊框，因為主要用於報報，增強透明度提升質感
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 小紅點指示器 (模擬日式印章感)
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: theme.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            message,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: theme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ZenToastAnimation extends StatefulWidget {
  final String message;
  final ZenTheme theme;

  const _ZenToastAnimation({required this.message, required this.theme});

  @override
  State<_ZenToastAnimation> createState() => _ZenToastAnimationState();
}

class _ZenToastAnimationState extends State<_ZenToastAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.5), // 從下方浮現
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    // 提早開始淡出動畫，配合 Overlay 移除時間
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 48, // 距離底部
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: FadeTransition(
            opacity: _opacity,
            child: SlideTransition(
              position: _offset,
              child: ZenToast(message: widget.message, theme: widget.theme),
            ),
          ),
        ),
      ),
    );
  }
}
