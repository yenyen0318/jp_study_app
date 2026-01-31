import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';

class ZenButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ZenTheme theme;
  final bool isGhost;
  final bool isFullWidth;

  const ZenButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.theme,
    this.isGhost = false, // 幽靈按鈕：無背景，僅文字 (用於次要操作)
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 48, // 標準觸控高度
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: isGhost ? Colors.transparent : theme.bgSurface,
          borderRadius: BorderRadius.circular(24),
          border: isGhost
              ? null
              : Border.all(color: theme.borderSubtle, width: 0.5),
        ),
        child: Center(
          widthFactor: 1.0,
          child: Text(
            label,
            style: GoogleFonts.notoSansTc(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: theme.textPrimary,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: buttonContent);
    }

    return buttonContent;
  }
}
