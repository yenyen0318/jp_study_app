import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// 具備禪意基礎樣式的卡片組件
class ZenCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool useBorder;

  const ZenCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.useBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final zen = context.zen;

    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? zen.bgSurface,
        borderRadius: BorderRadius.circular(borderRadius ?? zen.radius.md),
        border: useBorder
            ? Border.all(color: zen.borderSubtle, width: 0.5)
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? zen.radius.md),
        child: content,
      );
    }

    return content;
  }
}
