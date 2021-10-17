class Validations {
  static String? generic({String? value = "", String error = "campo inválido", int min = 1}) {
    if (value!.trim().length < min) return error;
    return null;
  }

  static String? email(String? value) {
    if (value == null) value = ""; 
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) return null;
    return 'email inválido';
  }

  static String? password(String? value) {
    if (value == null) value = ""; 
    
    if (value.length < 8) return 'min 8 caracteres';
    return null;
  }

  static String? confirmPassword(String pass, String? confirmPass) {
    if (confirmPass == null) confirmPass = ""; 
    if (confirmPass.isEmpty) {
      return 'min 8 caracteres';
    } else if (pass != confirmPass) {
      return 'senhas diferentes';
    }
    return null;
  }
}
