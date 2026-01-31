import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/presentation/widgets/kana_detail_sheet.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('KanaDetailSheet Widget Test', () {
    testWidgets('renders kana details correctly', (WidgetTester tester) async {
      final kana = const Kana(
        id: 'h_a',
        text: 'あ',
        romaji: 'a',
        type: 'hiragana',
        row: 0,
        col: 0,
        mnemonic: 'Apple description',
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light,
            home: Scaffold(
              body: KanaDetailSheet(kana: kana, onPlayAudio: () {}),
            ),
          ),
        ),
      );

      expect(find.text('あ'), findsOneWidget);
      expect(find.text('a'), findsOneWidget);
      expect(find.text('記憶小撇步'), findsOneWidget);
      expect(find.text('Apple description'), findsOneWidget);
    });

    testWidgets('renders similar kana characters', (WidgetTester tester) async {
      final kana = const Kana(
        id: 'h_nu',
        text: 'ぬ',
        romaji: 'nu',
        type: 'hiragana',
        row: 4,
        col: 2,
        similarKanaIds: ['h_me'],
      );
      final similar = [
        const Kana(
          id: 'h_me',
          text: 'め',
          romaji: 'me',
          type: 'hiragana',
          row: 6,
          col: 3,
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light,
            home: Scaffold(
              body: KanaDetailSheet(
                kana: kana,
                similarKana: similar,
                onPlayAudio: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('容易混淆'), findsOneWidget);
      expect(find.text('め'), findsOneWidget);
      expect(find.text('me'), findsOneWidget);
    });
  });
}
