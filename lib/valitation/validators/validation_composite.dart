import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  String validate({@required String field, @required String value}) {
    final error = validations
        .where((elem) => elem.field == field)
        .map((elem) => elem.validate(value))
        .first;

    return error?.isNotEmpty == true ? error : null;
  }
}
