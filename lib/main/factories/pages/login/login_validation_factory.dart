import '../../../../presentation/protocols/validation.dart';
import '../../../../valitation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite([
    EmailValidation('email'),
    RequiredFieldValidation('email'),
    RequiredFieldValidation('password'),
  ]);
}
