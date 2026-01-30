import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the TtsService
final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});

/// Service to handle Text-to-Speech operations
class TtsService {
  late final FlutterTts _flutterTts;

  TtsService() {
    _flutterTts = FlutterTts();
    _init();
  }

  Future<void> _init() async {
    await _flutterTts.setLanguage("ja-JP");
    await _flutterTts.setSpeechRate(0.5); // Slower rate for learning
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  /// Speak the given text
  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  /// Stop speaking
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
