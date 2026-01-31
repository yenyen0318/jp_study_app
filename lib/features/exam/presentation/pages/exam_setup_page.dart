import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:jp_study_app/core/theme/theme.dart';
import 'package:jp_study_app/core/widgets/zen_button.dart';
import 'package:jp_study_app/core/widgets/zen_multi_selector.dart';
import 'package:jp_study_app/core/widgets/zen_segmented_button.dart';
import 'package:jp_study_app/features/exam/domain/entities/quiz.dart';
import 'package:jp_study_app/features/exam/presentation/providers/exam_controller.dart';

/// 測驗設定頁面
/// 提供整頁式的設定介面，並預留未來單字測驗的擴展性。
class ExamSetupPage extends ConsumerStatefulWidget {
  const ExamSetupPage({super.key});

  @override
  ConsumerState<ExamSetupPage> createState() => _ExamSetupPageState();
}

class _ExamSetupPageState extends ConsumerState<ExamSetupPage> {
  // 目前僅支援五十音，未來可透過路由參數或狀態切換 type
  final String _currentType = 'kana';

  // 五十音設定狀態
  List<int> _selectedRows = [0]; // 預設選中あ行
  String _selectedKanaType = 'hiragana';
  bool _isRandomSampling = false;

  final _kanaRows = [
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
    '濁音',
    '半濁音',
    '拗音',
    '促音',
    '長音',
    '外來語',
  ];

  @override
  Widget build(BuildContext context) {
    final zenTheme = Theme.of(context).extension<ZenTheme>()!;

    return Scaffold(
      backgroundColor: zenTheme.bgPrimary,
      extendBody: true,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: zenTheme.layout.maxContentWidth,
          ),
          child: CustomScrollView(
            slivers: [
              // 標題區域
              SliverSafeArea(
                bottom: false,
                minimum: const EdgeInsets.only(top: 24, left: 24, right: 24),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentType == 'kana' ? '準備驗收' : '單字挑戰',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: zenTheme.textPrimary,
                                letterSpacing:
                                    zenTheme.layout.letterSpacingNormal,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'しけん設定',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: zenTheme.textSecondary.withValues(
                                  alpha: 0.7,
                                ),
                                letterSpacing: 4.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 設定內容
              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(
                  bottom: 100,
                  left: 24,
                  right: 24,
                ), // Add bottom padding to avoid button overlap
                sliver: SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildSectionHeader('假名類型', zenTheme),
                      const SizedBox(height: 16),
                      ZenSegmentedButton<String>(
                        options: const ['hiragana', 'katakana'],
                        selectedValue: _selectedKanaType,
                        onChanged: (value) =>
                            setState(() => _selectedKanaType = value),
                        theme: zenTheme,
                        labelBuilder: (value) =>
                            value == 'hiragana' ? '平假名' : '片假名',
                      ),
                      const SizedBox(height: 48),

                      _buildSectionHeader('範圍選擇', zenTheme),
                      const SizedBox(height: 16),
                      ZenMultiSelector<int>(
                        options: List.generate(_kanaRows.length, (i) => i),
                        selectedValues: _selectedRows,
                        onChanged: (values) =>
                            setState(() => _selectedRows = values),
                        theme: zenTheme,
                        labelBuilder: (index) => _kanaRows[index],
                      ),
                      const SizedBox(height: 48),

                      _buildSectionHeader('驗收模式', zenTheme),
                      const SizedBox(height: 16),
                      ZenSegmentedButton<bool>(
                        options: const [false, true],
                        selectedValue: _isRandomSampling,
                        onChanged: (value) =>
                            setState(() => _isRandomSampling = value),
                        theme: zenTheme,
                        labelBuilder: (value) => value ? '隨機 10 題' : '完整覆蓋',
                      ),
                      const SizedBox(height: 0),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // 固定在底職的開始按鈕
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Padding(
          padding: EdgeInsets.zero,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ZenButton(
              label: '開始驗收',
              onPressed: _onStartExam,
              theme: zenTheme,
              isFullWidth: true,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ZenTheme theme) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: theme.textSecondary,
        letterSpacing: 1.2,
      ),
    );
  }

  void _onStartExam() {
    // 處理行索引映射 (同步自 ExamScopeDialog)
    final Set<int> actualRows = {};
    for (final index in _selectedRows) {
      if (index == 11) {
        actualRows.addAll([11, 12, 13, 14]); // 濁音
      } else if (index == 12) {
        actualRows.add(15); // 半濁音
      } else if (index == 13) {
        actualRows.addAll(List.generate(11, (i) => i + 16)); // 拗音
      } else if (index == 14) {
        actualRows.add(100); // 促音
      } else if (index == 15) {
        actualRows.add(101); // 長音
      } else if (index == 16) {
        actualRows.addAll([110, 111, 112, 113, 114, 115]); // 外來語
      } else {
        actualRows.add(index);
      }
    }

    final scope = ExamScope(
      types: [_selectedKanaType],
      rows: actualRows.toList(),
      isRandomSampling: _isRandomSampling,
    );

    ref.read(examControllerProvider.notifier).startExam(scope);
    context.pushReplacement('/exam');
  }
}
