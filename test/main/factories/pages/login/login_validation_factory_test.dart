import 'package:flutter_clean_architecture/valitation/validators/validators.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_architecture/main/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', size: 3),
    ]);
  });
}
