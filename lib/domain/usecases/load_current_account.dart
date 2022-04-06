import 'package:flutter_clean_architecture/domain/entities/account_entity.dart';

abstract class LoadCurrentAccount {
  Future<AccountEntity> load();
}
