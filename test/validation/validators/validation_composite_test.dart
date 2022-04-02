import 'package:flutter_clean_architecture/valitation/protocols/protocols.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_architecture/valitation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;
  ValidationComposite sut;

  void mockValidation(FieldValidationSpy validation, String error) =>
      when(validation.validate(any)).thenReturn(error);

  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();

    when(validation1.field).thenReturn('other_field');
    when(validation2.field).thenReturn('any_field');
    when(validation3.field).thenReturn('any_field');

    mockValidation(validation1, null);
    mockValidation(validation2, null);
    mockValidation(validation3, null);

    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    mockValidation(validation2, '');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Should return the first error', () {
    mockValidation(validation1, 'error_1');
    mockValidation(validation2, 'error_2');
    mockValidation(validation3, 'error_3');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_2');
  });
}