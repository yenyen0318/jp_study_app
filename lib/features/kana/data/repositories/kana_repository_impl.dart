import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';

class KanaRepositoryImpl implements KanaRepository {
  static const _hiraganaData = [
    // あ行
    Kana(id: 'h_a', text: 'あ', romaji: 'a', type: 'hiragana', row: 0, col: 0),
    Kana(id: 'h_i', text: 'い', romaji: 'i', type: 'hiragana', row: 0, col: 1),
    Kana(id: 'h_u', text: 'う', romaji: 'u', type: 'hiragana', row: 0, col: 2),
    Kana(id: 'h_e', text: 'え', romaji: 'e', type: 'hiragana', row: 0, col: 3),
    Kana(id: 'h_o', text: 'お', romaji: 'o', type: 'hiragana', row: 0, col: 4),
    // か行
    Kana(id: 'h_ka', text: 'か', romaji: 'ka', type: 'hiragana', row: 1, col: 0),
    Kana(id: 'h_ki', text: 'き', romaji: 'ki', type: 'hiragana', row: 1, col: 1),
    Kana(id: 'h_ku', text: 'く', romaji: 'ku', type: 'hiragana', row: 1, col: 2),
    Kana(id: 'h_ke', text: 'け', romaji: 'ke', type: 'hiragana', row: 1, col: 3),
    Kana(id: 'h_ko', text: 'こ', romaji: 'ko', type: 'hiragana', row: 1, col: 4),
    // さ行
    Kana(id: 'h_sa', text: 'さ', romaji: 'sa', type: 'hiragana', row: 2, col: 0),
    Kana(
      id: 'h_shi',
      text: 'し',
      romaji: 'shi',
      type: 'hiragana',
      row: 2,
      col: 1,
    ),
    Kana(id: 'h_su', text: 'す', romaji: 'su', type: 'hiragana', row: 2, col: 2),
    Kana(id: 'h_se', text: 'せ', romaji: 'se', type: 'hiragana', row: 2, col: 3),
    Kana(id: 'h_so', text: 'そ', romaji: 'so', type: 'hiragana', row: 2, col: 4),
    // た行
    Kana(id: 'h_ta', text: 'た', romaji: 'ta', type: 'hiragana', row: 3, col: 0),
    Kana(
      id: 'h_chi',
      text: 'ち',
      romaji: 'chi',
      type: 'hiragana',
      row: 3,
      col: 1,
    ),
    Kana(
      id: 'h_tsu',
      text: 'つ',
      romaji: 'tsu',
      type: 'hiragana',
      row: 3,
      col: 2,
    ),
    Kana(id: 'h_te', text: 'て', romaji: 'te', type: 'hiragana', row: 3, col: 3),
    Kana(id: 'h_to', text: 'と', romaji: 'to', type: 'hiragana', row: 3, col: 4),
    // な行
    Kana(id: 'h_na', text: 'な', romaji: 'na', type: 'hiragana', row: 4, col: 0),
    Kana(id: 'h_ni', text: 'に', romaji: 'ni', type: 'hiragana', row: 4, col: 1),
    Kana(id: 'h_nu', text: 'ぬ', romaji: 'nu', type: 'hiragana', row: 4, col: 2),
    Kana(id: 'h_ne', text: 'ね', romaji: 'ne', type: 'hiragana', row: 4, col: 3),
    Kana(id: 'h_no', text: 'の', romaji: 'no', type: 'hiragana', row: 4, col: 4),
    // は行
    Kana(id: 'h_ha', text: 'は', romaji: 'ha', type: 'hiragana', row: 5, col: 0),
    Kana(id: 'h_hi', text: 'ひ', romaji: 'hi', type: 'hiragana', row: 5, col: 1),
    Kana(id: 'h_fu', text: 'ふ', romaji: 'fu', type: 'hiragana', row: 5, col: 2),
    Kana(id: 'h_he', text: 'へ', romaji: 'he', type: 'hiragana', row: 5, col: 3),
    Kana(id: 'h_ho', text: 'ほ', romaji: 'ho', type: 'hiragana', row: 5, col: 4),
    // ま行
    Kana(id: 'h_ma', text: 'ま', romaji: 'ma', type: 'hiragana', row: 6, col: 0),
    Kana(id: 'h_mi', text: 'み', romaji: 'mi', type: 'hiragana', row: 6, col: 1),
    Kana(id: 'h_mu', text: 'む', romaji: 'mu', type: 'hiragana', row: 6, col: 2),
    Kana(id: 'h_me', text: 'め', romaji: 'me', type: 'hiragana', row: 6, col: 3),
    Kana(id: 'h_mo', text: 'も', romaji: 'mo', type: 'hiragana', row: 6, col: 4),
    // や行
    Kana(id: 'h_ya', text: 'や', romaji: 'ya', type: 'hiragana', row: 7, col: 0),
    Kana(id: 'h_yu', text: 'ゆ', romaji: 'yu', type: 'hiragana', row: 7, col: 2),
    Kana(id: 'h_yo', text: 'よ', romaji: 'yo', type: 'hiragana', row: 7, col: 4),
    // ら行
    Kana(id: 'h_ra', text: 'ら', romaji: 'ra', type: 'hiragana', row: 8, col: 0),
    Kana(id: 'h_ri', text: 'り', romaji: 'ri', type: 'hiragana', row: 8, col: 1),
    Kana(id: 'h_ru', text: 'る', romaji: 'ru', type: 'hiragana', row: 8, col: 2),
    Kana(id: 'h_re', text: 'れ', romaji: 're', type: 'hiragana', row: 8, col: 3),
    Kana(id: 'h_ro', text: 'ろ', romaji: 'ro', type: 'hiragana', row: 8, col: 4),
    // わ行
    Kana(id: 'h_wa', text: 'わ', romaji: 'wa', type: 'hiragana', row: 9, col: 0),
    Kana(id: 'h_wo', text: 'を', romaji: 'wo', type: 'hiragana', row: 9, col: 4),
    // N
    Kana(id: 'h_n', text: 'ん', romaji: 'n', type: 'hiragana', row: 10, col: 0),
  ];

  static const _katakanaData = [
    // ア行
    Kana(id: 'k_a', text: 'ア', romaji: 'a', type: 'katakana', row: 0, col: 0),
    Kana(id: 'k_i', text: 'イ', romaji: 'i', type: 'katakana', row: 0, col: 1),
    Kana(id: 'k_u', text: 'ウ', romaji: 'u', type: 'katakana', row: 0, col: 2),
    Kana(id: 'k_e', text: 'エ', romaji: 'e', type: 'katakana', row: 0, col: 3),
    Kana(id: 'k_o', text: 'オ', romaji: 'o', type: 'katakana', row: 0, col: 4),
    // カ行
    Kana(id: 'k_ka', text: 'カ', romaji: 'ka', type: 'katakana', row: 1, col: 0),
    Kana(id: 'k_ki', text: 'キ', romaji: 'ki', type: 'katakana', row: 1, col: 1),
    Kana(id: 'k_ku', text: 'ク', romaji: 'ku', type: 'katakana', row: 1, col: 2),
    Kana(id: 'k_ke', text: 'ケ', romaji: 'ke', type: 'katakana', row: 1, col: 3),
    Kana(id: 'k_ko', text: 'コ', romaji: 'ko', type: 'katakana', row: 1, col: 4),
    // サ行
    Kana(id: 'k_sa', text: 'サ', romaji: 'sa', type: 'katakana', row: 2, col: 0),
    Kana(
      id: 'k_shi',
      text: 'シ',
      romaji: 'shi',
      type: 'katakana',
      row: 2,
      col: 1,
    ),
    Kana(id: 'k_su', text: 'ス', romaji: 'su', type: 'katakana', row: 2, col: 2),
    Kana(id: 'k_se', text: 'セ', romaji: 'se', type: 'katakana', row: 2, col: 3),
    Kana(id: 'k_so', text: 'ソ', romaji: 'so', type: 'katakana', row: 2, col: 4),
    // タ行
    Kana(id: 'k_ta', text: 'タ', romaji: 'ta', type: 'katakana', row: 3, col: 0),
    Kana(
      id: 'k_chi',
      text: 'チ',
      romaji: 'chi',
      type: 'katakana',
      row: 3,
      col: 1,
    ),
    Kana(
      id: 'k_tsu',
      text: 'ツ',
      romaji: 'tsu',
      type: 'katakana',
      row: 3,
      col: 2,
    ),
    Kana(id: 'k_te', text: 'テ', romaji: 'te', type: 'katakana', row: 3, col: 3),
    Kana(id: 'k_to', text: 'ト', romaji: 'to', type: 'katakana', row: 3, col: 4),
    // ナ行
    Kana(id: 'k_na', text: 'ナ', romaji: 'na', type: 'katakana', row: 4, col: 0),
    Kana(id: 'k_ni', text: 'ニ', romaji: 'ni', type: 'katakana', row: 4, col: 1),
    Kana(id: 'k_nu', text: 'ヌ', romaji: 'nu', type: 'katakana', row: 4, col: 2),
    Kana(id: 'k_ne', text: 'ネ', romaji: 'ne', type: 'katakana', row: 4, col: 3),
    Kana(id: 'k_no', text: 'ノ', romaji: 'no', type: 'katakana', row: 4, col: 4),
    // ハ行
    Kana(id: 'k_ha', text: 'ハ', romaji: 'ha', type: 'katakana', row: 5, col: 0),
    Kana(id: 'k_hi', text: 'ヒ', romaji: 'hi', type: 'katakana', row: 5, col: 1),
    Kana(id: 'k_fu', text: 'フ', romaji: 'fu', type: 'katakana', row: 5, col: 2),
    Kana(id: 'k_he', text: 'ヘ', romaji: 'he', type: 'katakana', row: 5, col: 3),
    Kana(id: 'k_ho', text: 'ホ', romaji: 'ho', type: 'katakana', row: 5, col: 4),
    // マ行
    Kana(id: 'k_ma', text: 'マ', romaji: 'ma', type: 'katakana', row: 6, col: 0),
    Kana(id: 'k_mi', text: 'ミ', romaji: 'mi', type: 'katakana', row: 6, col: 1),
    Kana(id: 'k_mu', text: 'ム', romaji: 'mu', type: 'katakana', row: 6, col: 2),
    Kana(id: 'k_me', text: 'メ', romaji: 'me', type: 'katakana', row: 6, col: 3),
    Kana(id: 'k_mo', text: 'モ', romaji: 'mo', type: 'katakana', row: 6, col: 4),
    // ヤ行
    Kana(id: 'k_ya', text: 'ヤ', romaji: 'ya', type: 'katakana', row: 7, col: 0),
    Kana(id: 'k_yu', text: 'ユ', romaji: 'yu', type: 'katakana', row: 7, col: 2),
    Kana(id: 'k_yo', text: 'ヨ', romaji: 'yo', type: 'katakana', row: 7, col: 4),
    // ラ行
    Kana(id: 'k_ra', text: 'ラ', romaji: 'ra', type: 'katakana', row: 8, col: 0),
    Kana(id: 'k_ri', text: 'リ', romaji: 'ri', type: 'katakana', row: 8, col: 1),
    Kana(id: 'k_ru', text: 'ル', romaji: 'ru', type: 'katakana', row: 8, col: 2),
    Kana(id: 'k_re', text: 'レ', romaji: 're', type: 'katakana', row: 8, col: 3),
    Kana(id: 'k_ro', text: 'ロ', romaji: 'ro', type: 'katakana', row: 8, col: 4),
    // ワ行
    Kana(id: 'k_wa', text: 'ワ', romaji: 'wa', type: 'katakana', row: 9, col: 0),
    Kana(id: 'k_wo', text: 'ヲ', romaji: 'wo', type: 'katakana', row: 9, col: 4),
    // N
    Kana(id: 'k_n', text: 'ン', romaji: 'n', type: 'katakana', row: 10, col: 0),
  ];

  @override
  Future<List<Kana>> getHiragana() async {
    // 模擬非同步延遲
    await Future.delayed(const Duration(milliseconds: 10));
    return _hiraganaData;
  }

  @override
  Future<List<Kana>> getKatakana() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return _katakanaData;
  }
}
