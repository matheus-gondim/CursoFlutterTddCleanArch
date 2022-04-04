import '../../../../presentation/protocols/validation.dart';
import '../../../../valitation/validators/validators.dart';
import '../../../../valitation/protocols/protocols.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    EmailValidation('email'),
    RequiredFieldValidation('email'),
    RequiredFieldValidation('password'),
  ];
}
