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
              padding: EdgeInsets.symmetric(vertical: zenTheme.spacing.lg),
              child: Center(
                child: Container(
                  width: zenTheme.layout.handleWidth,
                  height: zenTheme.layout.handleHeight,
                  decoration: BoxDecoration(
                    color: zenTheme.borderSubtle,
                    borderRadius: BorderRadius.circular(
                      zenTheme.layout.handleHeight / 2,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: zenTheme.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: zenTheme.spacing.lg),
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
                    SizedBox(height: zenTheme.spacing.xxl),

                    // 書寫練習區
                    Text(
                      '手寫練習',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: zenTheme.textSecondary.withValues(alpha: 0.5),
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: zenTheme.spacing.md),
                    ZenCanvas(
                      guideText: vocabulary.text,
                      theme: zenTheme,
                      height: zenTheme.layout.canvasHeightDefault,
                    ),
                    SizedBox(height: zenTheme.spacing.xxl),

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
