String? validateEmail(String? email) {
  const emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
  final regex = RegExp(emailPattern);
  if (email == null || email.isEmpty) {
    return 'El correo electrónico es obligatorio';
  } else if (!regex.hasMatch(email)) {
    return 'El correo electrónico no es válido';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'La contraseña es obligatoria';
  } else if (password.length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }
  return null;
}

String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return 'El nombre es obligatorio';
  } else if (name.length < 3) {
    return 'El nombre debe tener al menos 3 caracteres';
  }
  return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'La confirmación de contraseña es obligatoria';
  } else if (password != confirmPassword) {
    return 'Las contraseñas no coinciden';
  }
  return null;
}
