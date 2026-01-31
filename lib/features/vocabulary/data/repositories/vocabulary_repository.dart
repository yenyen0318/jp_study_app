import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/vocabulary.dart';

abstract class VocabularyRepository {
  Future<List<Vocabulary>> getN5Vocabularies();
}

class VocabularyRepositoryImpl implements VocabularyRepository {
  @override
  Future<List<Vocabulary>> getN5Vocabularies() async {
    final String response = await rootBundle.loadString(
      'assets/data/vocabulary_n5.json',
    );
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Vocabulary.fromJson(json)).toList();
  }
}
