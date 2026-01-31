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
    final zen = context.zen;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(zen.radius.md),
      child: Container(
        padding: EdgeInsets.all(zen.spacing.md),
        decoration: BoxDecoration(
          color: zen.bgSurface,
          borderRadius: BorderRadius.circular(zen.radius.md),
          border: Border.all(color: zen.borderSubtle),
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
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: zen.textPrimary,
                            height: 1.6,
                          ),
                          rubyStyle: textTheme.labelMedium?.copyWith(
                            color: zen.textSecondary,
                          ),
                        ),
                      )
                      .toList(),
                ),
                GestureDetector(
                  onTap: () => _speak(vocabulary.text),
                  child: Text(
                    '發音',
                    style: textTheme.labelLarge?.copyWith(
                      color: zen.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: zen.spacing.sm),
            Text(
              vocabulary.romaji,
              style: textTheme.bodyMedium?.copyWith(
                color: zen.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
            Divider(height: zen.spacing.lg),
            Text(
              vocabulary.meaning,
              style: textTheme.bodyLarge?.copyWith(
                color: zen.textPrimary,
                fontSize: 18,
              ),
            ),
            if (vocabulary.tags.isNotEmpty) ...[
              SizedBox(height: zen.spacing.md),
              Wrap(
                spacing: zen.spacing.sm,
                children: vocabulary.tags
                    .map(
                      (tag) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: zen.spacing.sm,
                          vertical: zen.spacing.xs / 2,
                        ),
                        decoration: BoxDecoration(
                          color: zen.bgPrimary.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(
                            zen.radius.sm / 2,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: textTheme.labelSmall?.copyWith(
                            color: zen.textSecondary,
                            fontSize: 10,
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
