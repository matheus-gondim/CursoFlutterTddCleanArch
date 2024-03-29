import 'package:meta/meta.dart';

import '../../cache/cache.dart';
import '../../models/models.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/domain_error.dart';

class LocalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({@required this.fetchCacheStorage});

  Future<List<SurveyEntity>> load() async {
    try {
      final data = await fetchCacheStorage.fetch('surveys');
      if (data?.isEmpty != false) throw Exception();
      return data
          .map<SurveyEntity>(
              (json) => LocalSurveyModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
