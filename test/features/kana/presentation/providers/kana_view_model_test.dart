import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';

// 模擬 Repository
class MockKanaRepository extends Mock implements KanaRepository {}

void main() {
  late MockKanaRepository mockRepository;

  setUp(() {
    mockRepository = MockKanaRepository();
  });

  test('KanaListViewModel returns data from repository', () async {
    // 準備 (Arrange)
    final mockData = [
      const Kana(
        id: '1',
        text: 'あ',
        romaji: 'a',
        type: 'hiragana',
        row: 0,
        col: 0,
      ),
    ];
    when(() => mockRepository.getHiragana()).thenAnswer((_) async => mockData);

    final container = ProviderContainer(
      overrides: [kanaRepositoryProvider.overrideWithValue(mockRepository)],
    );
    addTearDown(container.dispose);

    // 操作 (Act)
    // 監聽 provider 以觸發 build
    container.listen(kanaListViewModelProvider, (_, _) {});
    final result = await container.read(kanaListViewModelProvider.future);

    // 驗證 (Assert)
    expect(result, mockData);
    verify(() => mockRepository.getHiragana()).called(1);
  });
}
