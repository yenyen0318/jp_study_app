import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/zen_canvas.dart';
import '../../domain/entities/vocabulary.dart';

class VocabularyPracticePage extends ConsumerWidget {
  final Vocabulary vocabulary;

  const VocabularyPracticePage({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;

    return Scaffold(
      backgroundColor: zenTheme.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // 頂部手勢提示 (取代返回鍵)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: zenTheme.borderSubtle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      vocabulary.text,
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(color: zenTheme.textPrimary),
                    ),
                    Text(
                      vocabulary.meaning,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: zenTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // 書寫練習區
                    Text(
                      '手寫練習',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: zenTheme.textSecondary.withValues(alpha: 0.5),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ZenCanvas(
                      guideText: vocabulary.text,
                      theme: zenTheme,
                      height: 300,
                    ),
                    const SizedBox(height: 48),

                    // 引導訊息
                    Center(
                      child: Text(
                        '下拉或向右滑動以返回',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: zenTheme.textSecondary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
