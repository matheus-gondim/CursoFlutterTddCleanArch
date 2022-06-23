import '../../../../presentation/protocols/validation.dart';
import '../../../../valitation/validators/validators.dart';
import '../../../../valitation/protocols/protocols.dart';

import '../../../builders/validation_builder.dart';

Validation makeSignUpValidation() =>
    ValidationComposite(makeSignUpValidations());

List<FieldValidation> makeSignUpValidations() => [
      ...ValidationBuilder.field('name').required().min(3).build(),
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('password').required().min(3).build(),
      ...ValidationBuilder.field('passwordConfirmation')
          .required()
          .sameAs('password')
          .build()
    ];
