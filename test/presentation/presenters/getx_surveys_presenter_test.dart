import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_architecture/domain/entities/entities.dart';
import 'package:flutter_clean_architecture/domain/helpers/helpers.dart';
import 'package:flutter_clean_architecture/domain/usecases/usecases.dart';

import 'package:flutter_clean_architecture/ui/pages/pages.dart';
import 'package:flutter_clean_architecture/ui/helpers/helpers.dart';

import 'package:flutter_clean_architecture/presentation/presenters/presenters.dart';

class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  GetxSurveysPresenter sut;
  LoadSurveys loadSurveys;
  List<SurveyEntity> mockSurveys;

  List<SurveyEntity> mockValidData() => [
        SurveyEntity(
          id: faker.guid.guid(),
          question: faker.lorem.sentence(),
          dateTime: DateTime(2020, 2, 20),
          didAnswer: true,
        ),
        SurveyEntity(
          id: faker.guid.guid(),
          question: faker.lorem.sentence(),
          dateTime: DateTime(2018, 10, 3),
          didAnswer: true,
        ),
      ];

  PostExpectation mockLoadSurveyCall() => when(loadSurveys.load());

  void mockLoadSurveys(List<SurveyEntity> data) {
    mockSurveys = data;
    mockLoadSurveyCall().thenAnswer((_) async => data);
  }

  mockLoadSurveysError() =>
      mockLoadSurveyCall().thenThrow(DomainError.unexpected);

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
    mockLoadSurveys(mockValidData());
  });

  test('Should call LoadServeys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.surveysStream.listen(expectAsync1((surveys) => expect(surveys, [
          SurveyViewModel(
            id: mockSurveys[0].id,
            question: mockSurveys[0].question,
            date: '20 Fev 2020',
            didAnswer: mockSurveys[0].didAnswer,
          ),
          SurveyViewModel(
            id: mockSurveys[1].id,
            question: mockSurveys[1].question,
            date: '03 Out 2018',
            didAnswer: mockSurveys[1].didAnswer,
          ),
        ])));
    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    mockLoadSurveysError();

    sut.surveysStream.listen(null,
        onError: expectAsync1(
          (error) => expect(error, UIError.unexpected.description),
        ));
    await sut.loadData();
  });
}
