import 'package:flutter/material.dart';
import 'package:jp_study_app/core/theme/theme.dart';

/// 微點呼吸 Loader
///
/// 極簡的 loading 指示器,僅顯示單一圓點的淡入淡出動畫。
/// 符合「無干擾」、「隱形」的禪意設計原則。
///
/// 設計理念:
/// - 單一圓點 (8dp 直徑)
/// - 緩慢呼吸動畫 (1800ms 週期)
/// - 極淡色彩,幾乎隱形
class ZenDotLoader extends StatefulWidget {
  const ZenDotLoader({super.key});

  @override
  State<ZenDotLoader> createState() => _ZenDotLoaderState();
}

class _ZenDotLoaderState extends State<ZenDotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800), // 緩慢呼吸
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(
      begin: 0.15, // 最淡
      end: 0.4, // 最明顯 (依然很淡)
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

    return Center(
      child: AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: zen.textSecondary.withValues(
                alpha: _opacityAnimation.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
