import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/features/kana/data/repositories/kana_repository_impl.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana_type.dart';

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
      expect(first.type, KanaType.hiragana);
      expect(first.row, 0);
      expect(first.col, 0);

      // 驗證總數量 (含促音、長音、外來語等擴充分類)
      expect(result.length, 110);
    });

    test('getKatakana returns correct list of Katakana', () async {
      final result = await repository.getKatakana();

      expect(result, isA<List<Kana>>());
      expect(result.isNotEmpty, true);

      // 驗證第一項 (ア)
      final first = result.first;
      expect(first.text, 'ア');
      expect(first.type, KanaType.katakana);

      // 驗證總數量 (片假名包含現代外來語組合，數量較平假名多)
      expect(result.length, 134);
    });
  });
}
