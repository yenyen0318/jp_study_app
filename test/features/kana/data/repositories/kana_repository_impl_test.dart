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

      // 驗證基本數量 (46 個基礎音)
      expect(result.length, 46);
    });
  });
}
