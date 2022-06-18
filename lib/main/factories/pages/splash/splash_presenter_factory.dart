import 'package:flutter_clean_architecture/ui/pages/pages.dart';

import '../../../../presentation/presenters/presenters.dart';

import '../../factories.dart';

SplashPresenter makeGetxSplashPresenter() =>
    GetxSplashPresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());
