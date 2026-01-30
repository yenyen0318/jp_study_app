import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/services/tts_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TtsService ttsService;
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    log.clear();
    // Mock the flutter_tts method channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), (
          MethodCall methodCall,
        ) async {
          log.add(methodCall);
          return 1;
        });

    ttsService = TtsService();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), null);
  });

  test('TtsService calls speak on flutter_tts', () async {
    await ttsService.speak('あ');

    // Verify that the speak method was called on the platform channel
    // Note: Initialization calls (setLanguage, etc.) might also be in the log depending on timing
    // We check if "speak" is in the log
    expect(log.any((call) => call.method == 'speak'), isTrue);

    final speakCall = log.firstWhere((call) => call.method == 'speak');
    expect(speakCall.arguments, 'あ');
  });

  test('TtsService initializes with correct settings', () async {
    // We expect calls to setLanguage, setSpeechRate, setVolume, setPitch
    // Since _init is called in constructor and is async, wait a bit or just check log
    // In a real unit test for async constructor, we might need a way to await init.
    // However, for this simple case, we just check if the calls are dispatched eventually.

    // Let's call a method to ensure microtasks run?
    await ttsService.speak('test');

    expect(
      log.any(
        (call) => call.method == 'setLanguage' && call.arguments == 'ja-JP',
      ),
      isTrue,
    );
    expect(log.any((call) => call.method == 'setSpeechRate'), isTrue);
  });
}
