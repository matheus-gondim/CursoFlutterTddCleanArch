import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  final String field;
  final String fieldToCompare;

  List get props => [field];

  CompareFieldsValidation({
    @required this.field,
    @required this.fieldToCompare,
  });

  ValidationError validate(Map input) {
    return input[fieldToCompare] == input[field]
        ? null
        : ValidationError.invalidField;
  }
}
