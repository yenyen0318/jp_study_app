import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/features/kana/presentation/providers/writing_controller.dart';

void main() {
  group('WritingController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is correct', () {
      final state = container.read(writingControllerProvider);
      expect(state.currentStrokes, isEmpty);
      expect(state.isFading, isFalse);
    });

    test('addPoint adds point to current stroke', () {
      final controller = container.read(writingControllerProvider.notifier);
      const point = Offset(10, 10);

      controller.addPoint(point);

      final state = container.read(writingControllerProvider);
      expect(state.currentStrokes.length, 1);
      expect(state.currentStrokes.first, [point]);
    });

    test('startNewStroke creates a new stroke list', () {
      final controller = container.read(writingControllerProvider.notifier);

      controller.addPoint(const Offset(0, 0));
      controller.startNewStroke(const Offset(10, 10));

      final state = container.read(writingControllerProvider);
      expect(state.currentStrokes.length, 2);
      expect(state.currentStrokes[0], [const Offset(0, 0)]);
      expect(state.currentStrokes[1], [const Offset(10, 10)]);
    });

    test('clear resets state', () {
      final controller = container.read(writingControllerProvider.notifier);
      controller.addPoint(const Offset(5, 5));

      controller.clear();

      final state = container.read(writingControllerProvider);
      expect(state.currentStrokes, isEmpty);
    });
  });
}
