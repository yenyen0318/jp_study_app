import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 語意化顏色的 Zen 主題擴充
@immutable
class ZenTheme extends ThemeExtension<ZenTheme> {
  final Color bgPrimary;
  final Color bgSurface;
  final Color textPrimary;
  final Color textSecondary;
  final Color success;
  final Color error;
  final Color borderSubtle;

  const ZenTheme({
    required this.bgPrimary,
    required this.bgSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.error,
    required this.borderSubtle,
  });

  @override
  ZenTheme copyWith({
    Color? bgPrimary,
    Color? bgSurface,
    Color? textPrimary,
    Color? textSecondary,
    Color? success,
    Color? error,
    Color? borderSubtle,
  }) {
    return ZenTheme(
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSurface: bgSurface ?? this.bgSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      error: error ?? this.error,
      borderSubtle: borderSubtle ?? this.borderSubtle,
    );
  }

  @override
  ZenTheme lerp(ThemeExtension<ZenTheme>? other, double t) {
    if (other is! ZenTheme) {
      return this;
    }
    return ZenTheme(
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
    );
  }

  static const light = ZenTheme(
    bgPrimary: Color(0xFFF5F5F0), // 和紙色
    bgSurface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF2B2B2B), // 墨色
    textSecondary: Color(0xFF757575),
    success: Color(0xFF92B5A9), // 青磁
    error: Color(0xFFD36151), // 朱紅
    borderSubtle: Color(0xFFE0E0E0),
  );

  static const dark = ZenTheme(
    bgPrimary: Color(0xFF121212), // 深炭
    bgSurface: Color(0xFF1E1E1E),
    textPrimary: Color(0xFFE1E1E1), // 銀白
    textSecondary: Color(0xFFA0A0A0),
    success: Color(0xFF4D6B61), // 暗青
    error: Color(0xFF964236), // 深朱
    borderSubtle: Color(0xFF333333),
  );
}

/// App 核心主題資料
class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ZenTheme.light.bgPrimary,
      extensions: const [ZenTheme.light],
      textTheme: GoogleFonts.notoSansTcTextTheme().copyWith(
        bodyMedium: GoogleFonts.notoSansTc(color: ZenTheme.light.textPrimary),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ZenTheme.dark.bgPrimary,
      extensions: const [ZenTheme.dark],
      textTheme: GoogleFonts.notoSansTcTextTheme().copyWith(
        bodyMedium: GoogleFonts.notoSansTc(color: ZenTheme.dark.textPrimary),
      ),
    );
  }
}
