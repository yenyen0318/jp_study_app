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
    await ttsService.speak('あ');

    // 驗證 speak 方法是否在 platform channel 上被呼叫
    // 注意：初始化呼叫 (setLanguage 等) 也可能出現在日誌中，視時機而定
    // 我們檢查 "speak" 是否存在於日誌中
    expect(log.any((call) => call.method == 'speak'), isTrue);

    final speakCall = log.firstWhere((call) => call.method == 'speak');
    expect(speakCall.arguments, 'あ');
  });

  test('TtsService initializes with correct settings', () async {
    // 我們預期 setLanguage, setSpeechRate, setVolume, setPitch 會被呼叫
    // 由於 _init 是在建構函式中呼叫且為非同步，等待一下或直接檢查日誌
    // 在真實的非同步建構函式單元測試中，我們可能需要等待 init 完成的方法
    // 但在此簡單案例中，我們只需檢查呼叫是否最終被發送

    // 呼叫一個方法以確保 microtasks 執行
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
