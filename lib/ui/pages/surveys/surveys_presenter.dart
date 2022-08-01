import 'package:flutter_clean_architecture/ui/pages/surveys/survey_viewmodel.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewModel>> get surveysStream;
  Future<void> loadData();
}
