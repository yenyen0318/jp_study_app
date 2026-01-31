import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/presentation/providers/exam_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:jp_study_app/core/widgets/zen_button.dart';
import 'package:jp_study_app/core/widgets/zen_segmented_button.dart';
import 'package:jp_study_app/core/widgets/zen_multi_selector.dart';

class ExamScopeDialog extends ConsumerStatefulWidget {
  const ExamScopeDialog({super.key});

  @override
  ConsumerState<ExamScopeDialog> createState() => _ExamScopeDialogState();
}

class _ExamScopeDialogState extends ConsumerState<ExamScopeDialog> {
  List<int> _selectedRows = [0]; // 預設選中あ行
  String _selectedType = 'hiragana'; // 單選:平假名或片假名
  bool _isRandomSampling = false; // 驗收模式:false=完整覆蓋, true=隨機抽樣

  final _rows = [
    'あ行',
    'か行',
    'さ行',
    'た行',
    'な行',
    'は行',
    'ま行',
    'や行',
    'ら行',
    'わ行',
    '鼻音 (ん)',
    '濁音 (が行~ば行)',
    '半濁音 (ぱ行)',
    '拗音 (きゃ~ぴょ)',
    '促音 (っ/ッ)',
    '長音 (ー)',
    '外來語組合 (ヴァ/ティ等)',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<ZenTheme>()!;

    return Dialog(
      backgroundColor: theme.bgSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '選擇驗收範圍',
              style: GoogleFonts.notoSansTc(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: theme.textPrimary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // 類型選擇 (平假名/片假名) - 使用 ZenSegmentedButton
            ZenSegmentedButton<String>(
              options: const ['hiragana', 'katakana'],
              selectedValue: _selectedType,
              onChanged: (value) => setState(() => _selectedType = value),
              theme: theme,
              labelBuilder: (value) => value == 'hiragana' ? '平假名' : '片假名',
            ),

            const SizedBox(height: 20),

            // 行選擇矩陣 - 使用 ZenMultiSelector
            ZenMultiSelector<int>(
              options: List.generate(_rows.length, (i) => i),
              selectedValues: _selectedRows,
              onChanged: (values) => setState(() => _selectedRows = values),
              theme: theme,
              labelBuilder: (index) => _rows[index],
            ),

            const SizedBox(height: 20),

            // 驗收模式選擇 - 使用 ZenSegmentedButton
            ZenSegmentedButton<bool>(
              options: const [false, true],
              selectedValue: _isRandomSampling,
              onChanged: (value) => setState(() => _isRandomSampling = value),
              theme: theme,
              labelBuilder: (value) => value ? '隨機 10 題' : '完整覆蓋',
            ),

            const SizedBox(height: 32),

            // 開始按鈕
            ZenButton(
              label: '開始',
              onPressed: () {
                // 處理行索引映射：將 UI 上的索引轉換為資料庫中實際的 row 索引
                final Set<int> actualRows = {};
                for (final index in _selectedRows) {
                  if (index == 11) {
                    // 濁音包含 が、ざ、だ、ば 行 (11, 12, 13, 14)
                    actualRows.addAll([11, 12, 13, 14]);
                  } else if (index == 12) {
                    // 半濁音包含 ぱ 行 (15)
                    actualRows.add(15);
                  } else if (index == 13) {
                    // 拗音包含 row 16-26
                    actualRows.addAll(List.generate(11, (i) => i + 16));
                  } else if (index == 14) {
                    // 促音 row 100 (需過濾 id)
                    actualRows.add(100);
                  } else if (index == 15) {
                    // 長音 row 101
                    actualRows.add(101);
                  } else if (index == 16) {
                    // 外來語組合 row 110+
                    actualRows.addAll([110, 111, 112, 113, 114, 115]);
                  } else {
                    actualRows.add(index);
                  }
                }

                final scope = ExamScope(
                  types: [_selectedType], // 單選改為列表
                  rows: actualRows.toList(),
                  isRandomSampling: _isRandomSampling,
                );
                ref.read(examControllerProvider.notifier).startExam(scope);
                context.pop();
                context.push('/exam');
              },
              theme: theme,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
