import 'package:meta/meta.dart';

import 'package:flutter_clean_architecture/domain/entities/entities.dart';

class RemoteSurveyModel {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  RemoteSurveyModel({
    @required this.id,
    @required this.question,
    @required this.date,
    @required this.didAnswer,
  });

  factory RemoteSurveyModel.fromJson(Map json) {
    return RemoteSurveyModel(
      id: json['id'],
      date: json['date'],
      question: json['question'],
      didAnswer: json['didAnswer'],
    );
  }

  SurveyEntity toEntity() => SurveyEntity(
      id: id,
      question: question,
      didAnswer: didAnswer,
      dateTime: DateTime.parse(date));
}
