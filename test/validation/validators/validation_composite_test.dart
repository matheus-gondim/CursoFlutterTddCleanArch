import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_architecture/presentation/protocols/protocols.dart';

import 'package:flutter_clean_architecture/valitation/protocols/protocols.dart';
import 'package:flutter_clean_architecture/valitation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;
  ValidationComposite sut;

  void mockValidation(FieldValidationSpy validation, ValidationError error) =>
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
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Should return the first error', () {
    mockValidation(validation1, ValidationError.requiredField);
    mockValidation(validation2, ValidationError.requiredField);
    mockValidation(validation3, ValidationError.invalidField);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, ValidationError.requiredField);
  });
}
