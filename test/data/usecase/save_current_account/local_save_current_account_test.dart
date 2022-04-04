import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/domain/helpers/domain_error.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_architecture/domain/entities/entities.dart';
import 'package:flutter_clean_architecture/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;
  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future<void> save(AccountEntity account) async {
    try {
      await this.saveSecureCacheStorage.saveSecure(
            key: 'token',
            value: account.token,
          );
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
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
