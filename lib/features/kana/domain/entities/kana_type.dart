/// 假名類型枚舉
enum KanaType {
  hiragana('平假名'),
  katakana('片假名');

  final String label;
  const KanaType(this.label);

  /// 從字串安全轉換（供 Data Layer 使用）
  static KanaType fromString(String value) {
    return KanaType.values.firstWhere(
      (e) => e.name == value.toLowerCase() || e.label == value,
      orElse: () => KanaType.hiragana,
    );
  }
}
