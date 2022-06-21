enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Campo obrigatório.';
      case UIError.invalidField:
        return 'Campo inválido.';
      case UIError.invalidCredentials:
        return 'Credencias inválidas.';
      default:
        return 'Algo erro aconteceu. Tente novamente em breve.';
    }
  }
}
