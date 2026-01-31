import 'package:flutter/material.dart';
import 'package:ruby_text/ruby_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/vocabulary.dart';

class VocabularyCard extends StatelessWidget {
  final Vocabulary vocabulary;
  final VoidCallback? onTap;

  const VocabularyCard({super.key, required this.vocabulary, this.onTap});

  Future<void> _speak(String text) async {
    final FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("ja-JP");
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: zenTheme.bgSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: zenTheme.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RubyText(
                  vocabulary.segments
                      .map(
                        (s) => RubyTextData(
                          s.text,
                          ruby: s.reading,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: zenTheme.textPrimary,
                            height: 1.6,
                          ),
                          rubyStyle: TextStyle(
                            fontSize: 12,
                            color: zenTheme.textSecondary,
                          ),
                        ),
                      )
                      .toList(),
                ),
                GestureDetector(
                  onTap: () => _speak(vocabulary.text),
                  child: Text(
                    '發音',
                    style: TextStyle(
                      color: zenTheme.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              vocabulary.romaji,
              style: TextStyle(
                fontSize: 14,
                color: zenTheme.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
            const Divider(height: 24),
            Text(
              vocabulary.meaning,
              style: TextStyle(fontSize: 18, color: zenTheme.textPrimary),
            ),
            if (vocabulary.tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: vocabulary.tags
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: zenTheme.bgPrimary.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 10,
                            color: zenTheme.textSecondary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
