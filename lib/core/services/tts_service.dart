import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/core/errors/exceptions.dart';

/// 提供 TtsService 的 Provider
final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});

/// 處理文字轉語音 (TTS) 操作的服務
class TtsService {
  late final FlutterTts _flutterTts;
  final Completer<void> _initCompleter = Completer<void>();

  TtsService() {
    _flutterTts = FlutterTts();
    _init();
  }

  Future<void> _init() async {
    try {
      // 等待 native binding 初始化
      await _flutterTts.awaitSpeakCompletion(true);

      // 設定語言 - 加入錯誤檢查
      final isLanguageAvailable = await _flutterTts.isLanguageAvailable(
        "ja-JP",
      );
      if (isLanguageAvailable == true) {
        // isLanguageAvailable can return null
        await _flutterTts.setLanguage("ja-JP");
      } else {
        debugPrint("Error: ja-JP language is not available on this device.");
        // 嘗試 fallback 到系統預設，或維持現狀
      }

      await _flutterTts.setSpeechRate(0.5); // 語速較慢，適合學習
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      if (!_initCompleter.isCompleted) {
        _initCompleter.complete();
      }
    } catch (e) {
      // 即使失敗也要 complete，避免永久卡住
      if (!_initCompleter.isCompleted) {
        _initCompleter.complete();
      }
      throw TtsException('初始化失敗', e);
    }
  }

  /// 朗讀指定的文字
  Future<void> speak(String text) async {
    try {
      // 確保初始化完成後才發聲
      if (!_initCompleter.isCompleted) {
        await _initCompleter.future;
      }
      await _flutterTts.speak(text);
    } catch (e) {
      throw TtsException('發音失敗', e);
    }
  }

  /// 停止朗讀
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
