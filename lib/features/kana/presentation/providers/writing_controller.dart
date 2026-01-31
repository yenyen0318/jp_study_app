import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'writing_state.dart';

part 'writing_controller.g.dart';

@riverpod
class WritingController extends _$WritingController {
  Timer? _fadeTimer;

  @override
  WritingState build() {
    ref.onDispose(() {
      _fadeTimer?.cancel();
    });
    return const WritingState();
  }

  void addPoint(Offset point) {
    _onUserAction();
    final currentStrokes = [...state.currentStrokes];
    if (currentStrokes.isEmpty) {
      currentStrokes.add([point]);
    } else {
      final lastStroke = [...currentStrokes.last, point];
      currentStrokes[currentStrokes.length - 1] = lastStroke;
    }

    state = state.copyWith(currentStrokes: currentStrokes, isFading: false);
    _fadeTimer?.cancel();
  }

  void startNewStroke(Offset point) {
    _onUserAction();
    final currentStrokes = [
      ...state.currentStrokes,
      [point],
    ];
    state = state.copyWith(currentStrokes: currentStrokes);
    _fadeTimer?.cancel();
  }

  // ... (endStroke, clear, _startFadeTimer remained unchanged)

  void endStroke() {
    _startFadeTimer();
  }

  void clear() {
    _onUserAction();
    state = const WritingState();
  }

  void _startFadeTimer() {
    _fadeTimer?.cancel();
    _fadeTimer = Timer(const Duration(seconds: 3), () {
      state = state.copyWith(
        isFading: true,
        currentStrokes: [], // 簡單實作：直接清空
      );
    });
  }

  void _onUserAction() {
    _fadeTimer?.cancel();
  }
}
