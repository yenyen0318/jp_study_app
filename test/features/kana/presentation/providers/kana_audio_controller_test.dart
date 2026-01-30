import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/errors/exceptions.dart';
import 'package:jp_study_app/core/services/tts_service.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_audio_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockTtsService extends Mock implements TtsService {}

void main() {
  late ProviderContainer container;
  late MockTtsService mockTtsService;

  setUp(() {
    mockTtsService = MockTtsService();
    container = ProviderContainer(
      overrides: [ttsServiceProvider.overrideWithValue(mockTtsService)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'KanaAudioController play sets state to error when TtsService throws',
    () async {
      // Arrange
      final exception = TtsException('Test Error');
      when(() => mockTtsService.speak(any())).thenThrow(exception);

      // Act
      final controller = container.read(kanaAudioControllerProvider.notifier);
      // 監聽狀態變化
      final states = <AsyncValue<void>>[];
      container.listen(
        kanaAudioControllerProvider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      await controller.play('あ');

      // Assert
      // 0: Initial data(null), 1: Loading, 2: Error
      expect(states.length, greaterThanOrEqualTo(2));
      expect(states.last.hasError, isTrue);
      expect(states.last.error, isA<TtsException>());
    },
  );

  test('KanaAudioController play success', () async {
    // Arrange
    when(() => mockTtsService.speak(any())).thenAnswer((_) async {});

    // Act
    final controller = container.read(kanaAudioControllerProvider.notifier);
    final states = <AsyncValue<void>>[];
    container.listen(
      kanaAudioControllerProvider,
      (previous, next) => states.add(next),
      fireImmediately: true,
    );
    await controller.play('あ');

    // Assert
    expect(states.last.hasValue, isTrue);
    verify(() => mockTtsService.speak('あ')).called(1);
  });
}
