import 'package:meta/meta.dart';

import '../../domain/usecases/load_surveys.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async {
    await loadSurveys.load();
  }
}
