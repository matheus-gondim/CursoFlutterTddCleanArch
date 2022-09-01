import '../factories.dart';
import '../../decorators/decorators.dart';

import '../../../data/http/http.dart';

HttpClient makeAuthorizeHttpClientDecorator() {
  return AuthorizeHttpClientDecorator(
      decoratee: makeHttpAdapter(),
      fetchSecureCacheStorage: makeLocalStorageAdapter());
}
