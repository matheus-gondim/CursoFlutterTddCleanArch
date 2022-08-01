import 'package:flutter_clean_architecture/domain/usecases/usecases.dart';
import 'package:flutter_clean_architecture/presentation/presenters/presenters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  GetxSurveysPresenter sut;
  LoadSurveys loadSurveys;

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
  });

  test('Should call LoadServeys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });
}
