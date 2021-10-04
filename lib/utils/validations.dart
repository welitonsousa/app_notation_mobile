class Validations {
  static generic({required String value, String error = "campo inválido", int min = 1}) {
    if (value.trim().length < min) return error;
    return null;
  }

  static email(String value) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) return null;
    return 'email inválido';
  }

  static confirmEmail(String email, String confirmEmail) {
    final validate = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(confirmEmail);
    if (validate) {
      if (email != confirmEmail) {
        return 'emails diferentes';
      }
      return null;
    }
    return 'email inválido';
  }

  static password(String value) {
    if (value.length < 8) return 'min 8 caracteres';
    return null;
  }

  static confirmPassword(String pass, String confirmPass) {
    if (confirmPass.isEmpty) {
      return 'min 8 caracteres';
    } else if (pass != confirmPass) {
      return 'senhas diferentes';
    }
    return null;
  }
}
