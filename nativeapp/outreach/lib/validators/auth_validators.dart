String userNameValidator(String value) {
  if (value.trim().isEmpty) {
    return "Username is a mandatory field!";
  } else if (value.length < 3) {
    return "Username must be greater than 2 characters!";
  }
  return null;
}

String emailValidator(String value) {
  if (value.trim().isEmpty) {
    return "Email is a mandatory field!";
  } else if (value.length < 5) {
    return "Invalid Email Address!";
  } else if (!value.contains('@')) {
    return "Invalid Email Address!";
  }
  return null;
}

String passwordValidator(String value) {
  if (value.trim().isEmpty) {
    return "Password is a mandatory field!";
  } else if (value.length < 8) {
    return "Password must be greater than 7 characters!";
  }
  return null;
}

String passwordConfirmValidator(String value, String passwordValue) {
  if (value.trim().isEmpty) {
    return "Please Confirm your password!";
  } else if (value != passwordValue) {
    return "Password didn't match!";
  }
  return null;
}
