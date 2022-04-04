import '../../../../presentation/protocols/validation.dart';
import '../../../../valitation/validators/validators.dart';
import '../../../../valitation/protocols/protocols.dart';

import '../../../builders/validation_builder.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() => [
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('password').required().build()
    ];
