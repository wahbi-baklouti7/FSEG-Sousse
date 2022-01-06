class ValidatorHelper {
  static String? validateEmail({required String email}) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email))
      return 'Enter a valid email address';
    else if (email.isEmpty) {
      return "Email can\'t be empty";
    } else
      return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return "Password can\'t be empty";
    } else if (password.length < 6) {
      return "Password must be more than 6 character";
    } else
      return null;
  }
}
