import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/features/kana/domain/entities/kana.dart';
import 'package:jp_study_app/features/kana/domain/repositories/kana_repository.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_view_model.dart';
import 'package:jp_study_app/features/kana/data/repositories/kana_repository_impl.dart';

// Mock Repository
class MockKanaRepository extends Mock implements KanaRepository {}

void main() {
  late MockKanaRepository mockRepository;

  setUp(() {
    mockRepository = MockKanaRepository();
  });

  test('KanaListViewModel returns data from repository', () async {
    // Arrange
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

    // Act
    // Listen to the provider to trigger build
    final subscription = container.listen(
      kanaListViewModelProvider,
      (_, __) {},
    );
    final result = await container.read(kanaListViewModelProvider.future);

    // Assert
    expect(result, mockData);
    verify(() => mockRepository.getHiragana()).called(1);
  });
}
