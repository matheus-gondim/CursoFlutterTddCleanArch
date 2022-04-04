import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_architecture/domain/helpers/helpers.dart';
import 'package:flutter_clean_architecture/domain/entities/entities.dart';

import 'package:flutter_clean_architecture/data/cache/cache.dart';
import 'package:flutter_clean_architecture/data/usecases/usecases.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  SaveSecureCacheStorageSpy cacheStorage;
  LocalSaveCurrentAccount sut;
  AccountEntity account;

  void mockError() => when(
        cacheStorage.saveSecure(key: anyNamed('key'), value: anyNamed('value')),
      ).thenThrow(Exception());

  setUp(() {
    cacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: cacheStorage);
    account = AccountEntity(faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(cacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test(
    'Should thorw UnexpectedError if SaveSecureCacheStorage thorws',
    () async {
      mockError();
      final future = sut.save(account);

      expect(future, throwsA(DomainError.unexpected));
    },
  );
}
