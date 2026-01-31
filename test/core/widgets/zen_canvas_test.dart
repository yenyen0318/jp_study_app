import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/core/widgets/zen_canvas.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/presentation/providers/writing_controller.dart';

void main() {
  testWidgets('ZenCanvas in ListView captures vertical drag', (tester) async {
    // Setup
    final container = ProviderContainer();
    // Assuming default constructor works or we mock it
    // Note: ZenTheme might need a ThemeExtension setup.
    // Let's mock the theme usage or wrap in proper context.

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: ThemeData(extensions: [ZenTheme.light]),
          home: Scaffold(
            body: ListView(
              children: [
                SizedBox(
                  height: 300,
                  child: ZenCanvas(
                    height: 300,
                    guideText: 'あ',
                    strokes: [],
                    theme: ZenTheme.light,
                  ),
                ),
                Container(height: 1000, color: Colors.red),
              ],
            ),
          ),
        ),
      ),
    );

    // Initial check
    var state = container.read(writingControllerProvider);
    expect(state.currentStrokes, isEmpty);

    // Act: Drag vertically on the canvas
    final canvasFinder = find.byType(ZenCanvas);
    await tester.drag(canvasFinder, const Offset(0, 100));
    await tester.pump();

    // Assert: Canvas should have strokes
    state = container.read(writingControllerProvider);
    expect(
      state.currentStrokes,
      isNotEmpty,
      reason: "Canvas should capture the drag. State: $state",
    );
    expect(state.currentStrokes.first.length, greaterThan(1));

    // Cleanup: Flush the 3-second timer started by endStroke
    await tester.pump(const Duration(seconds: 4));
  });
}
