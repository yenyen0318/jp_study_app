import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 使用者介面的間隔規範 (Design Tokens)
@immutable
class ZenSpacing {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  const ZenSpacing({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
  });
}

/// 使用者介面的圓角規範 (Design Tokens)
@immutable
class ZenRadius {
  final double sm;
  final double md;
  final double lg;
  final double full;

  const ZenRadius({
    this.sm = 8.0,
    this.md = 12.0,
    this.lg = 24.0,
    this.full = 999.0,
  });
}

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
  final Color accent;
  final Color guideOverlay;

  /// 間隔系統
  final ZenSpacing spacing;

  /// 圓角系統
  final ZenRadius radius;

  const ZenTheme({
    required this.bgPrimary,
    required this.bgSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.error,
    required this.borderSubtle,
    required this.accent,
    required this.guideOverlay,
    this.spacing = const ZenSpacing(),
    this.radius = const ZenRadius(),
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
    Color? accent,
    Color? guideOverlay,
    ZenSpacing? spacing,
    ZenRadius? radius,
  }) {
    return ZenTheme(
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSurface: bgSurface ?? this.bgSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      error: error ?? this.error,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      accent: accent ?? this.accent,
      guideOverlay: guideOverlay ?? this.guideOverlay,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
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
      accent: Color.lerp(accent, other.accent, t)!,
      guideOverlay: Color.lerp(guideOverlay, other.guideOverlay, t)!,
      spacing: spacing, // 間隔不參與 lerp
      radius: radius, // 圓角不參與 lerp
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
    accent: Color(0xFF5D7687), // 縹色 (Hanada-iro / Muted Blue)
    guideOverlay: Color(0x0D2B2B2B), // textPrimary * 0.05
  );

  static const dark = ZenTheme(
    bgPrimary: Color(0xFF121212), // 深炭
    bgSurface: Color(0xFF1E1E1E),
    textPrimary: Color(0xFFE1E1E1), // 銀白
    textSecondary: Color(0xFFA0A0A0),
    success: Color(0xFF4D6B61), // 暗青
    error: Color(0xFF964236), // 深朱
    borderSubtle: Color(0xFF333333),
    accent: Color(0xFF4A5F6D), // 深縹
    guideOverlay: Color(0x26E1E1E1), // textPrimary * 0.15
  );
}

/// 提供便捷存取 ZenTheme 的擴充
extension ZenThemeContext on BuildContext {
  ZenTheme get zen => Theme.of(this).extension<ZenTheme>()!;
}

/// App 核心主題資料
class AppTheme {
  static TextTheme _buildTextTheme(Color textColor) {
    const double height = 1.5;
    return GoogleFonts.notoSansTcTextTheme().copyWith(
      displayMedium: GoogleFonts.notoSansTc(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: height,
      ),
      headlineLarge: GoogleFonts.notoSansTc(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: height,
      ),
      headlineMedium: GoogleFonts.notoSansTc(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: height,
      ),
      headlineSmall: GoogleFonts.notoSansTc(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: height,
      ),
      titleLarge: GoogleFonts.notoSansTc(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: height,
      ),
      titleMedium: GoogleFonts.notoSansTc(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: height,
      ),
      bodyLarge: GoogleFonts.notoSansTc(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: height,
      ),
      bodyMedium: GoogleFonts.notoSansTc(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: height,
      ),
      labelLarge: GoogleFonts.notoSansTc(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: height,
      ),
      labelMedium: GoogleFonts.notoSansTc(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: height,
      ),
      labelSmall: GoogleFonts.notoSansTc(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: height,
      ),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ZenTheme.light.bgPrimary,
      extensions: const [ZenTheme.light],
      textTheme: _buildTextTheme(ZenTheme.light.textPrimary),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ZenTheme.dark.bgPrimary,
      extensions: const [ZenTheme.dark],
      textTheme: _buildTextTheme(ZenTheme.dark.textPrimary),
    );
  }
}
