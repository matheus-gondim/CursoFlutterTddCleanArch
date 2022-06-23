import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;

  List get props => [field];

  MinLengthValidation({@required this.field, @required this.size});

  ValidationError validate(String value) {
    return value?.length == this.size ? null : ValidationError.invalidField;
  }
}
