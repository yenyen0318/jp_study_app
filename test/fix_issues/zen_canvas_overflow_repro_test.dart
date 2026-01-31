import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/core/widgets/zen_canvas.dart';
import 'package:jp_study_app/core/theme/theme.dart';

void main() {
  testWidgets('ZenCanvas should apply clipping to prevent overflow', (
    tester,
  ) async {
    final container = ProviderContainer();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData(extensions: [ZenTheme.light]),
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: ZenCanvas(
                  height: 300,
                  guideText: 'あ',
                  strokes: [],
                  theme: ZenTheme.light,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Verify that a ClipRect or similar clipping mechanism is present
    // This looks for a ClipRect that is an ancestor of the CustomPaint but descendant of ZenCanvas
    final canvasFinder = find.byType(ZenCanvas);
    final customPaintFinder = find.descendant(
      of: canvasFinder,
      matching: find.byType(CustomPaint),
    );
    final clipRectFinder = find.descendant(
      of: canvasFinder,
      matching: find.byType(ClipRect),
    );

    expect(customPaintFinder, findsOneWidget);
    // This assertion should fail if the bug exists (missing ClipRect) for this specific issue
    expect(
      clipRectFinder,
      findsOneWidget,
      reason:
          'ZenCanvas content should be clipped to prevent drawing outside bounds',
    );
  });
}
