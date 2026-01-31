import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/presentation/providers/exam_controller.dart';
import 'package:jp_study_app/core/services/tts_service.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'package:jp_study_app/core/widgets/zen_button.dart';

class ExamPage extends ConsumerWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 監聽結果產生，自動導向下一頁
    ref.listen(examControllerProvider, (previous, next) {
      if (next.value?.result != null) {
        context.pushReplacement('/exam_result');
      }
    });

    final stateAsync = ref.watch(examControllerProvider);
    final theme = Theme.of(context).extension<ZenTheme>()!;

    return Scaffold(
      backgroundColor: theme.bgPrimary,
      body: stateAsync.when(
        data: (state) {
          if (state.result != null) {
            // 已有結果，自動跳轉或在此顯示結果 (通常由 controller 觸發跳轉，這裡先暫時顯示進入點)
            return const SizedBox.shrink();
          }
          if (state.questions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '準備題目中...',
                    style: GoogleFonts.notoSansTc(color: theme.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      '取消並返回',
                      style: GoogleFonts.notoSansTc(color: theme.textSecondary),
                    ),
                  ),
                ],
              ),
            );
          }

          final currentQuestion = state.questions[state.currentIndex];
          final double progress =
              (state.currentIndex + 1) / state.questions.length;

          return SafeArea(
            child: Column(
              children: [
                // 進度條
                _ProgressBar(progress: progress, theme: theme),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 題目區
                          _QuestionArea(
                            question: currentQuestion,
                            theme: theme,
                            onPlay: () => ref
                                .read(ttsServiceProvider)
                                .speak(currentQuestion.correctKana.text),
                          ),

                          const SizedBox(height: 64),

                          // 選項區
                          _OptionsArea(
                            options: currentQuestion.options,
                            selectedOption: state.selectedOption,
                            correctOption: (currentQuestion is ReadingQuestion)
                                ? currentQuestion.correctKana.romaji
                                : currentQuestion.correctKana.text,
                            isAnswered: state.isAnswered,
                            theme: theme,
                            onSelect: (opt) => ref
                                .read(examControllerProvider.notifier)
                                .answer(opt),
                          ),

                          // 答錯時的助記提示 (Graceful Failure)
                          if (state.isAnswered && !state.isCorrect)
                            _WrongAnswerHint(
                              mnemonic: currentQuestion.correctKana.mnemonic,
                              theme: theme,
                            ),

                          if (state.isAnswered) const SizedBox(height: 32),

                          // 下一題按鈕
                          if (state.isAnswered)
                            ZenButton(
                              label: '下一題',
                              onPressed: () => ref
                                  .read(examControllerProvider.notifier)
                                  .nextQuestion(),
                              theme: theme,
                              isGhost: true, // 使用幽靈按鈕樣式，更輕量
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('發生錯誤: $err')),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  final ZenTheme theme;

  const _ProgressBar({required this.progress, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: double.infinity,
      color: theme.borderSubtle,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: theme.textPrimary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}

class _QuestionArea extends StatelessWidget {
  final QuizQuestion question;
  final ZenTheme theme;
  final VoidCallback onPlay;

  const _QuestionArea({
    required this.question,
    required this.theme,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    if (question is ListeningQuestion) {
      return Column(
        children: [
          SizedBox(
            height: 120,
            child: Center(
              child: _ZenPlayButton(onTap: onPlay, theme: theme),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '聽音辨字',
            style: GoogleFonts.notoSansTc(
              color: theme.textSecondary,
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 120,
            child: Center(
              child: Text(
                question.correctKana.text,
                style: GoogleFonts.notoSansJp(
                  fontSize: 80,
                  color: theme.textPrimary,
                  fontWeight: FontWeight.w200,
                  height:
                      1.0, // Force line height to 1.0 to behave predictably within the box
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '字元辨識',
            style: GoogleFonts.notoSansTc(
              color: theme.textSecondary,
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      );
    }
  }
}

class _ZenPlayButton extends StatefulWidget {
  final VoidCallback onTap;
  final ZenTheme theme;

  const _ZenPlayButton({required this.onTap, required this.theme});

  @override
  State<_ZenPlayButton> createState() => _ZenPlayButtonState();
}

class _ZenPlayButtonState extends State<_ZenPlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.9).animate(_controller),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.theme.bgSurface,
            border: Border.all(color: widget.theme.borderSubtle, width: 0.5),
          ),
          child: Icon(
            Icons.volume_up_outlined,
            color: widget.theme.textPrimary,
            size: 32,
          ),
        ),
      ),
    );
  }
}

class _OptionsArea extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final String correctOption;
  final bool isAnswered;
  final ZenTheme theme;
  final Function(String) onSelect;

  const _OptionsArea({
    required this.options,
    required this.selectedOption,
    required this.correctOption,
    required this.isAnswered,
    required this.theme,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedOption == option;
        final isCorrect = option == correctOption;

        Color? bgColor;
        if (isAnswered) {
          if (isCorrect) {
            bgColor = theme.success.withValues(alpha: 0.15);
          } else if (isSelected) {
            bgColor = theme.error.withValues(alpha: 0.1);
          }
        }

        return _OptionCard(
          label: option,
          isSelected: isSelected,
          isCorrect: isCorrect,
          isAnswered: isAnswered,
          bgColor: bgColor,
          theme: theme,
          onTap: () => onSelect(option),
        );
      },
    );
  }
}

class _OptionCard extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final Color? bgColor;
  final ZenTheme theme;
  final VoidCallback onTap;

  const _OptionCard({
    required this.label,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    this.bgColor,
    required this.theme,
    required this.onTap,
  });

  @override
  State<_OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<_OptionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.isAnswered && widget.isCorrect && !widget.isSelected) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_OptionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnswered && widget.isCorrect && !widget.isSelected) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isAnswered ? null : widget.onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final pulseValue =
              widget.isCorrect && widget.isAnswered && !widget.isSelected
              ? _pulseController.value
              : 0.0;

          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: widget.bgColor ?? widget.theme.bgSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.isAnswered
                        ? (widget.isCorrect
                              ? widget.theme.success.withValues(
                                  alpha: 0.5 + 0.5 * pulseValue,
                                )
                              : (widget.isSelected
                                    ? widget.theme.error.withValues(alpha: 0.5)
                                    : widget.theme.borderSubtle))
                        : widget.theme.borderSubtle,
                    width: widget.isAnswered && widget.isCorrect ? 1.5 : 0.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.label,
                    style: GoogleFonts.notoSansJp(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: widget.isAnswered
                          ? (widget.isCorrect
                                ? widget.theme.success
                                : (widget.isSelected
                                      ? widget.theme.error
                                      : widget.theme.textSecondary))
                          : widget.theme.textPrimary,
                    ),
                  ),
                ),
              ),
              if (widget.isAnswered && widget.isSelected && widget.isCorrect)
                Positioned.fill(child: _ZenParticles(theme: widget.theme)),
            ],
          );
        },
      ),
    );
  }
}

class _ZenParticles extends StatefulWidget {
  final ZenTheme theme;

  const _ZenParticles({required this.theme});

  @override
  State<_ZenParticles> createState() => _ZenParticlesState();
}

class _ZenParticlesState extends State<_ZenParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(8, (_) => _Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
        return CustomPaint(
          painter: _ParticlePainter(
            particles: _particles,
            progress: _controller.value,
            theme: widget.theme,
          ),
        );
      },
    );
  }
}

class _Particle {
  final double angle = math.Random().nextDouble() * 2 * math.pi;
  final double speed = 20 + math.Random().nextDouble() * 40;
  final double size = 2 + math.Random().nextDouble() * 3;
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final ZenTheme theme;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress >= 1.0) return;

    final paint = Paint()
      ..color = theme.success.withValues(alpha: 1.0 - progress);
    final center = Offset(size.width / 2, size.height / 2);

    for (var p in particles) {
      final distance = p.speed * progress;
      final offset = Offset(
        center.dx + math.cos(p.angle) * distance,
        center.dy + math.sin(p.angle) * distance,
      );
      canvas.drawCircle(offset, p.size * (1 - progress), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _WrongAnswerHint extends StatelessWidget {
  final String? mnemonic;
  final ZenTheme theme;

  const _WrongAnswerHint({this.mnemonic, required this.theme});

  @override
  Widget build(BuildContext context) {
    if (mnemonic == null) return const SizedBox.shrink();

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text(
                  '💡 記憶小撇步',
                  style: GoogleFonts.notoSansTc(
                    color: theme.accent.withValues(alpha: 0.7 * value),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  mnemonic!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSansTc(
                    color: theme.textSecondary.withValues(alpha: value),
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
