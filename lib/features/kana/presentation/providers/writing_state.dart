import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'writing_state.freezed.dart';

@freezed
class WritingState with _$WritingState {
  const factory WritingState({
    @Default([]) List<List<Offset>> currentStrokes,
    @Default(false) bool isFading,
  }) = _WritingState;
}
