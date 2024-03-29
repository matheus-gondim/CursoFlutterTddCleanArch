import 'package:flutter_clean_architecture/domain/helpers/domain_error.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

import '../http/http.dart';

class LocalSurveyModel {
  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

  LocalSurveyModel({
    @required this.id,
    @required this.question,
    @required this.date,
    @required this.didAnswer,
  });

  factory LocalSurveyModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'date', 'question', 'didAnswer']))
      throw DomainError.unexpected;

    return LocalSurveyModel(
      id: json['id'],
      question: json['question'],
      date: DateTime.parse(json['date']),
      didAnswer: json['didAnswer'].toString().toLowerCase() == 'true',
    );
  }

  SurveyEntity toEntity() => SurveyEntity(
        id: id,
        question: question,
        didAnswer: didAnswer,
        dateTime: date,
      );
}
