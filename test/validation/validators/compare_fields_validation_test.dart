import 'package:test/test.dart';

import 'package:flutter_clean_architecture/valitation/validators/validators.dart';

import 'package:flutter_clean_architecture/presentation/protocols/protocols.dart';

void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(
      field: 'any_field',
      fieldToCompare: 'other_field',
    );
  });

  test('Should return error if values are not equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'other_value'};
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'any_value'};
    expect(sut.validate(formData), null);
  });
}
