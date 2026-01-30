import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:jp_study_app/core/services/tts_service.dart';

part 'kana_audio_controller.g.dart';

@riverpod
class KanaAudioController extends _$KanaAudioController {
  @override
  FutureOr<void> build() {
    // 初始狀態為 null
    return null;
  }

  Future<void> play(String text) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(ttsServiceProvider).speak(text);
    });
  }
}
