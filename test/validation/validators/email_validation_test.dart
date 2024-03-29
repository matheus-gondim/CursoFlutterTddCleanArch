import 'package:test/test.dart';

import 'package:flutter_clean_architecture/presentation/protocols/protocols.dart';

import 'package:flutter_clean_architecture/valitation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null on invalid case', () {
    expect(sut.validate({}), null);
  });

  test('Should return null if email is empty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate({'any_field': null}), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate({'any_field': 'john.doe@gmail.com'}), null);
  });

  test('Should return error if email is invalid', () {
    expect(
      sut.validate({'any_field': 'john.doe'}),
      ValidationError.invalidField,
    );
  });
}
