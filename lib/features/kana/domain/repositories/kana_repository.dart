import 'package:jp_study_app/features/kana/domain/entities/kana.dart';

abstract class KanaRepository {
  Future<List<Kana>> getHiragana();
  Future<List<Kana>> getKatakana();
}
