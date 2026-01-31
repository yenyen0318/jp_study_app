import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../providers/vocabulary_provider.dart';

class VocabularySearchBar extends ConsumerWidget {
  const VocabularySearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          selectionColor: zenTheme.accent.withValues(alpha: 0.2),
          selectionHandleColor: zenTheme.accent,
        ),
        child: TextField(
          onChanged: (value) {
            ref.read(vocabularySearchQueryProvider.notifier).setQuery(value);
          },
          cursorColor: zenTheme.accent,
          cursorWidth: 1.0,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: zenTheme.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: '搜尋單字、發音或釋義...',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: zenTheme.textSecondary.withValues(alpha: 0.55),
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: zenTheme.borderSubtle.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: zenTheme.textPrimary.withValues(alpha: 0.8),
                width: 0.8,
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
