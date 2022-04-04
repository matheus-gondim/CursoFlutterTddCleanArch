import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
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
    await this.saveSecureCacheStorage.saveSecure(
          key: 'token',
          value: account.token,
        );
  }
}

void main() {
  test('Should call SaveCacheStorage with correct values', () async {
    final cacheStorage = SaveSecureCacheStorageSpy();
    final sut = LocalSaveCurrentAccount(saveSecureCacheStorage: cacheStorage);
    final account = AccountEntity(faker.guid.guid());
    await sut.save(account);

    verify(cacheStorage.saveSecure(key: 'token', value: account.token));
  });
}
