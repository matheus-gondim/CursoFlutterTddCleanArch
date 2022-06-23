import '../../../data/usecases/usecases.dart';

import '../../../domain/usecases/add_account.dart';

import '../factories.dart';

AddAccount makeRemoteAddAccount() {
  return RemoteAddAccount(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('login'),
  );
}
