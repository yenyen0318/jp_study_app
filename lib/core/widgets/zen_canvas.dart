import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    this.strokes = const [],
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
                child: ClipRect(
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
                        // 使用 Theme 定義的語意化顏色，讓 Contrast 邏輯回歸 Theme
                        guideColor: widget.theme.guideOverlay,
                        guideTextStyle: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              color: widget.theme.guideOverlay,
                              fontWeight: FontWeight.w100,
                            ),
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
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
  final TextStyle? guideTextStyle;

  _ZenPainter({
    required this.guideText,
    required this.strokes,
    required this.strokeColor,
    required this.guideColor,
    this.guideTextStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 0. 計算格線數量 (根據字數)
    // 假設 guideText 是 "みょ"，length 為 2 -> 分為 2 格
    final characters = guideText.characters.toList();
    final int cellCount = characters.isNotEmpty ? characters.length : 1;
    final double cellWidth = size.width / cellCount;

    final gridPaint = Paint()
      ..color = guideColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const dashWidth = 5.0;
    const dashSpace = 5.0;

    // 1. 迴圈繪製每個格子的導引線與底字
    for (int i = 0; i < cellCount; i++) {
      // 每個格子的偏移量
      final double offsetX = i * cellWidth;
      final Rect cellRect = Rect.fromLTWH(offsetX, 0, cellWidth, size.height);
      final Offset cellCenter = cellRect.center;

      // 1-1. 繪製十字基準線 (Cross-hair)
      // 水平線 (在格子垂直中心)
      double startX = offsetX;
      while (startX < offsetX + cellWidth) {
        canvas.drawLine(
          Offset(startX, cellCenter.dy),
          Offset(startX + dashWidth, cellCenter.dy),
          gridPaint,
        );
        startX += dashWidth + dashSpace;
      }

      // 垂直線 (在格子水平中心)
      double startY = 0;
      while (startY < size.height) {
        // startY 從 0 到 height
        canvas.drawLine(
          Offset(cellCenter.dx, startY),
          Offset(cellCenter.dx, startY + dashWidth),
          gridPaint,
        );
        startY += dashWidth + dashSpace;
      }

      // 1-2. 繪製分隔線 (Separator) - 僅在格子之間繪製，極淡
      if (i > 0) {
        final separatorPaint = Paint()
          ..color = guideColor
              .withValues(alpha: 0.05) // 非常淡
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5;

        // 畫實線或虛線皆可，這裡使用實線簡單區隔
        canvas.drawLine(
          Offset(offsetX, 16), // 上下留白
          Offset(offsetX, size.height - 16),
          separatorPaint,
        );
      }

      // 1-3. 繪製導引文字
      if (i < characters.length) {
        final char = characters[i];
        final textPainter = TextPainter(
          text: TextSpan(
            text: char,
            style: guideTextStyle?.copyWith(
              // 字體大小需適配格子寬度，避免重疊
              // 對於拗音，因為分格後空間變小，字體自然會依照格子比例調整 (假設 height 為主)
              // 但若維持 size.height * 0.7 可能會撐爆寬度
              // 因此取 min(cellWidth, size.height) * 0.7
              fontSize:
                  (cellWidth < size.height ? cellWidth : size.height) * 0.6,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        final textOffset = Offset(
          cellCenter.dx - (textPainter.width / 2),
          cellCenter.dy - (textPainter.height / 2),
        );
        textPainter.paint(canvas, textOffset);
      }
    }

    // 2. 繪製使用者筆跡 (Overlay on top of everything)
    // 筆跡是跨越整個 Canvas 的，無需分格處理
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
