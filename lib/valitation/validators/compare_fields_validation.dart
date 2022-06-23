import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  final String field;
  final String valueToCompare;

  List get props => [field];

  CompareFieldsValidation({
    @required this.field,
    @required this.valueToCompare,
  });

  ValidationError validate(String value) {
    return valueToCompare == value ? null : ValidationError.invalidField;
  }
}
