import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/presentation/providers/exam_controller.dart';
import 'package:jp_study_app/core/services/tts_service.dart';
import 'package:go_router/go_router.dart';

class ExamResultPage extends ConsumerWidget {
  const ExamResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(examControllerProvider);
    final theme = Theme.of(context).extension<ZenTheme>()!;

    return Scaffold(
      backgroundColor: theme.bgPrimary,
      body: stateAsync.when(
        data: (state) {
          final result = state.result;
          if (result == null) return const Center(child: Text('查無結果'));

          return CustomScrollView(
            slivers: [
              // 頂部儀式感區域
              SliverSafeArea(
                bottom: false,
                minimum: const EdgeInsets.only(top: 24, left: 24, right: 24),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        _MasteryCircle(score: result.score, theme: theme),
                        const SizedBox(height: 32),
                        _HankoStamp(label: result.hankoLabel, theme: theme),
                        const SizedBox(height: 24),
                        Text(
                          result.feedbackQuote,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: theme.textPrimary,
                                letterSpacing: 1.2,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 錯誤複習標題
              if (result.wrongAnswers.isNotEmpty)
                SliverSafeArea(
                  top: false,
                  bottom: false,
                  minimum: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      '需要精進的字元',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: theme.textSecondary,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

              // 錯誤清單
              SliverSafeArea(
                top: false,
                bottom: false,
                minimum: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final wrong = result.wrongAnswers[index];
                      return _WrongAnswerCard(
                        wrong: wrong,
                        theme: theme,
                        ref: ref,
                      );
                    }, childCount: result.wrongAnswers.length),
                  ),
                ),
              ),

              // 操作按鈕
              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        _ActionBtn(
                          label: '回到列表',
                          onTap: () {
                            ref.read(examControllerProvider.notifier).reset();
                            context.go('/');
                          },
                          theme: theme,
                          isPrimary: true,
                        ),
                        const SizedBox(height: 16),
                        _ActionBtn(
                          label: '重新驗收',
                          onTap: () async {
                            await ref
                                .read(examControllerProvider.notifier)
                                .retry();
                            if (context.mounted) {
                              context.pushReplacement('/exam');
                            }
                          },
                          theme: theme,
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (err, stack) => const SizedBox.shrink(),
      ),
    );
  }
}

class _MasteryCircle extends StatelessWidget {
  final double score;
  final ZenTheme theme;

  const _MasteryCircle({required this.score, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      '掌握度 ${(score * 100).toInt()}%',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w300,
        color: theme.textSecondary,
        letterSpacing: 2.0,
      ),
    );
  }
}

class _HankoStamp extends StatefulWidget {
  final String label;
  final ZenTheme theme;

  const _HankoStamp({required this.label, required this.theme});

  @override
  State<_HankoStamp> createState() => _HankoStampState();
}

class _HankoStampState extends State<_HankoStamp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    _scale = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.theme.error.withValues(alpha: 0.7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: widget.theme.error.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WrongAnswerCard extends StatelessWidget {
  final WrongAnswer wrong;
  final ZenTheme theme;
  final WidgetRef ref;

  const _WrongAnswerCard({
    required this.wrong,
    required this.theme,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final kana = wrong.question.correctKana;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.bgSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.borderSubtle, width: 0.5),
      ),
      child: Row(
        children: [
          Text(
            kana.text,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: theme.textPrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '正確讀音：${kana.romaji}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: theme.textPrimary),
                ),
                Text(
                  '您選擇了：${wrong.selectedOption}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: theme.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => ref.read(ttsServiceProvider).speak(kana.text),
            icon: Icon(
              Icons.volume_up_outlined,
              color: theme.textSecondary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ZenTheme theme;
  final bool isPrimary;

  const _ActionBtn({
    required this.label,
    required this.onTap,
    required this.theme,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isPrimary
              ? theme.textPrimary.withValues(alpha: 0.05)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: theme.borderSubtle, width: 0.5),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: theme.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
