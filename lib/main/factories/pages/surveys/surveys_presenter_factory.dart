import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/surveys/surveys.dart';
import '../../factories.dart';

SurveysPresenter makeGetxSurveysPresenter() =>
    GetxSurveysPresenter(loadSurveys: makeRemoteLoadSurveys());
