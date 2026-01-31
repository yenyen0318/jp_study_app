import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jp_study_app/features/kana/presentation/providers/kana_filter_provider.dart';

void main() {
  group('KanaCategoryFilter Unit Test', () {
    test('Initial filter should be all', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(kanaCategoryFilterProvider), KanaCategory.all);
    });

    test('Updating filter should change the state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(kanaCategoryFilterProvider.notifier)
          .setFilter(KanaCategory.seion);
      expect(container.read(kanaCategoryFilterProvider), KanaCategory.seion);

      container
          .read(kanaCategoryFilterProvider.notifier)
          .setFilter(KanaCategory.dakuon);
      expect(container.read(kanaCategoryFilterProvider), KanaCategory.dakuon);
    });
  });
}
