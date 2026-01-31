import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/widgets/zen_canvas.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/presentation/providers/writing_controller.dart';

void main() {
  setUpAll(() async {
    // Load fonts for golden tests
    await loadAppFonts();
  });

  Widget buidTestApp({required Widget child, List<Override>? overrides}) {
    return ProviderScope(
      overrides: overrides ?? [],
      child: MaterialApp(
        theme: ThemeData(
          extensions: [ZenTheme.light],
          fontFamily: GoogleFonts.notoSansTc().fontFamily,
        ),
        home: Scaffold(
          body: Center(child: SizedBox(width: 300, height: 300, child: child)),
        ),
      ),
    );
  }

  group('ZenCanvas Interaction Tests', () {
    testWidgets('ZenCanvas captures vertical drag in ListView', (tester) async {
      await tester.pumpWidget(
        buidTestApp(
          child: ListView(
            children: [
              SizedBox(
                height: 300,
                child: ZenCanvas(
                  height: 300,
                  guideText: 'あ',
                  strokes: const [],
                  theme: ZenTheme.light,
                ),
              ),
              Container(height: 1000, color: Colors.blue),
            ],
          ),
        ),
      );

      final stateBefore = ProviderScope.containerOf(
        tester.element(find.byType(ZenCanvas)),
      ).read(writingControllerProvider);
      expect(stateBefore.currentStrokes, isEmpty);

      // Act: Drag vertically on the canvas
      final canvasFinder = find.byType(ZenCanvas);
      await tester.drag(canvasFinder, const Offset(0, 100));
      await tester.pump();

      // Assert: Canvas should have strokes
      final stateAfter = ProviderScope.containerOf(
        tester.element(find.byType(ZenCanvas)),
      ).read(writingControllerProvider);
      expect(
        stateAfter.currentStrokes,
        isNotEmpty,
        reason: "Canvas should capture the drag",
      );

      // Cleanup timer
      await tester.pump(const Duration(seconds: 4));
    });
  });

  group('ZenCanvas Golden Tests', () {
    testGoldens('Single character renders single cross-hair', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'Single Character',
          widget: buidTestApp(
            child: ZenCanvas(
              height: 300,
              guideText: 'あ',
              strokes: const [],
              theme: ZenTheme.light,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'zen_canvas_single');
    });

    testGoldens('Multi character (Youon) renders split cross-hairs', (
      tester,
    ) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'Multi Character (Youon)',
          widget: buidTestApp(
            child: ZenCanvas(
              height: 300,
              guideText: 'みょ',
              strokes: const [],
              theme: ZenTheme.light,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'zen_canvas_youon');
    });
  });
}
