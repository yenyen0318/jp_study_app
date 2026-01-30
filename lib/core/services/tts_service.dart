import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 提供 TtsService 的 Provider
final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});

/// 處理文字轉語音 (TTS) 操作的服務
class TtsService {
  late final FlutterTts _flutterTts;

  TtsService() {
    _flutterTts = FlutterTts();
    _init();
  }

  Future<void> _init() async {
    await _flutterTts.setLanguage("ja-JP");
    await _flutterTts.setSpeechRate(0.5); // 語速較慢，適合學習
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  /// 朗讀指定的文字
  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  /// 停止朗讀
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
