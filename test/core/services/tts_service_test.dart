import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/services/tts_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TtsService ttsService;
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    log.clear();
    // 模擬 flutter_tts 的 method channel
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
    // 模擬必要的回傳值，避免 _init 卡住
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), (
          MethodCall methodCall,
        ) async {
          log.add(methodCall);
          if (methodCall.method == 'isLanguageAvailable') {
            return true;
          }
          return 1;
        });

    // 重新初始化 service 以觸發 init logic
    ttsService = TtsService();

    await ttsService.speak('あ');

    // 驗證 speak 方法是否在 platform channel 上被呼叫
    expect(log.any((call) => call.method == 'speak'), isTrue);

    final speakCall = log.firstWhere((call) => call.method == 'speak');
    expect(speakCall.arguments, 'あ');
  });

  test('TtsService initializes with correct settings', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), (
          MethodCall methodCall,
        ) async {
          log.add(methodCall);
          if (methodCall.method == 'isLanguageAvailable') {
            return true;
          }
          return 1;
        });

    ttsService = TtsService();

    // 呼叫 speak 以確保 _init 完成 (因為 speak 會 await _initCompleter)
    await ttsService.speak('test');

    expect(
      log.any(
        (call) => call.method == 'setLanguage' && call.arguments == 'ja-JP',
      ),
      isTrue,
    );
    expect(
      log.any(
        (call) => call.method == 'setSpeechRate' && call.arguments == 0.5,
      ),
      isTrue,
    );
    // awaitSpeakCompletion 應該也要被呼叫
    expect(log.any((call) => call.method == 'awaitSpeakCompletion'), isTrue);

    // isLanguageAvailable 應該被呼叫
    expect(log.any((call) => call.method == 'isLanguageAvailable'), isTrue);
  });
}
