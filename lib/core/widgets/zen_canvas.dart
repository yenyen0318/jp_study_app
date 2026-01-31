import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/presentation/providers/writing_controller.dart';

class ZenCanvas extends ConsumerStatefulWidget {
  final double height;
  final String guideText;
  final List<List<List<double>>> strokes; // 舊的筆順資料，目前保留以相容
  final ZenTheme theme;

  const ZenCanvas({
    super.key,
    required this.height,
    required this.guideText,
    required this.strokes,
    required this.theme,
  });

  @override
  ConsumerState<ZenCanvas> createState() => _ZenCanvasState();
}

class _ZenCanvasState extends ConsumerState<ZenCanvas> {
  void _onPanStart(DragStartDetails details) {
    ref
        .read(writingControllerProvider.notifier)
        .startNewStroke(details.localPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    ref
        .read(writingControllerProvider.notifier)
        .addPoint(details.localPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    ref.read(writingControllerProvider.notifier).endStroke();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(writingControllerProvider);

    return Column(
      children: [
        Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.theme.bgSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.theme.textPrimary.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
          child: Stack(
            children: [
              // 繪製層 (包含字體底稿、背景基準線、使用者筆跡)
              Positioned.fill(
                child: RawGestureDetector(
                  gestures: {
                    _ImmediatePanGestureRecognizer:
                        GestureRecognizerFactoryWithHandlers<
                          _ImmediatePanGestureRecognizer
                        >(() => _ImmediatePanGestureRecognizer(), (
                          _ImmediatePanGestureRecognizer instance,
                        ) {
                          instance.onStart = _onPanStart;
                          instance.onUpdate = _onPanUpdate;
                          instance.onEnd = _onPanEnd;
                        }),
                  },
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: _ZenPainter(
                      guideText: widget.guideText,
                      strokes: state.currentStrokes,
                      strokeColor: widget.theme.textPrimary.withValues(
                        alpha: 0.6,
                      ),
                      guideColor: widget.theme.textPrimary.withValues(
                        alpha: 0.05,
                      ),
                    ),
                  ),
                ),
              ),

              // 工具按鈕 (左下角：清除)
              Positioned(
                bottom: 12,
                left: 16,
                child: InkWell(
                  onTap: () =>
                      ref.read(writingControllerProvider.notifier).clear(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 16,
                        color: widget.theme.textPrimary.withValues(alpha: 0.4),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '清除',
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.theme.textPrimary.withValues(
                            alpha: 0.4,
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
      ],
    );
  }
}

class _ZenPainter extends CustomPainter {
  final String guideText;
  final List<List<Offset>> strokes;
  final Color strokeColor;
  final Color guideColor;

  _ZenPainter({
    required this.guideText,
    required this.strokes,
    required this.strokeColor,
    required this.guideColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. 繪製背景基準線 (Cross-hair Grid)
    final gridPaint = Paint()
      ..color = guideColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const dashWidth = 5.0;
    const dashSpace = 5.0;

    // 水平線
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        gridPaint,
      );
      startX += dashWidth + dashSpace;
    }

    // 垂直線
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashWidth),
        gridPaint,
      );
      startY += dashWidth + dashSpace;
    }

    // 2. 準備字體繪製器 (Ghost Guide) - 仍保留極淡的底字供參考
    final textPainter = TextPainter(
      text: TextSpan(
        text: guideText,
        style: GoogleFonts.notoSansJp(
          fontSize: size.height * 0.7,
          color: guideColor.withValues(alpha: 0.03),
          fontWeight: FontWeight.w100,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);

    // 3. 繪製使用者筆跡
    final userStrokePaint = Paint()
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.5
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      if (stroke.isEmpty) continue;
      final path = Path();
      path.moveTo(stroke.first.dx, stroke.first.dy);
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, userStrokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ZenPainter oldDelegate) => true;
}

class _ImmediatePanGestureRecognizer extends PanGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }

  @override
  String get debugDescription => 'ImmediatePan';
}
