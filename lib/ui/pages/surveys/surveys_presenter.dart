import 'package:flutter_clean_architecture/ui/pages/surveys/survey_viewmodel.dart';

abstract class SurveysPresenter {
  Stream<bool> isLoadingStream;
  Stream<List<SurveyViewModel>> loadSurveysStream;
  Future<void> loadData();
}
