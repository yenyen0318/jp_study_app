import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/features/kana/data/repositories/kana_repository_impl.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';

void main() {
  late KanaRepositoryImpl repository;

  setUp(() {
    repository = KanaRepositoryImpl();
  });

  group('KanaRepositoryImpl', () {
    test('getHiragana returns correct list of Hiragana', () async {
      final result = await repository.getHiragana();

      expect(result, isA<List<Kana>>());
      expect(result.isNotEmpty, true);

      // 驗證第一項 (あ)
      final first = result.first;
      expect(first.text, 'あ');
      expect(first.romaji, 'a');
      expect(first.type, 'hiragana');
      expect(first.row, 0);
      expect(first.col, 0);

      // 驗證總數量 (46基礎 + 25濁/半濁 + 33拗音 + 5重複 = 109)
      expect(result.length, 109);
    });

    test('getKatakana returns correct list of Katakana', () async {
      final result = await repository.getKatakana();

      expect(result, isA<List<Kana>>());
      expect(result.isNotEmpty, true);

      // 驗證第一項 (ア)
      final first = result.first;
      expect(first.text, 'ア');
      expect(first.type, 'katakana');

      // 驗證總數量 (同平假名)
      expect(result.length, 109);
    });
  });
}
