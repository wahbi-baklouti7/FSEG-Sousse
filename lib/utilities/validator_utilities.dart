class ValidatorUtils {
  static String? validateEmail({required String email,String? confirmEmail}) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Enter a valid email address';
    } else if (email.isEmpty) {
      return "Email can't be empty";
    } else if(confirmEmail!=null && confirmEmail!=email){
      return "Confirm email does not match";
    }
    else {
      return null;
    }
  }

  static String? validatePassword(
      {required String password, String? confirmPassword}) {
    if (password.isEmpty) {
      return "Password can't be empty";
    }
    if (confirmPassword != null) {
      if (confirmPassword != password) {
        return "Confirm password does not match";
      }
    } else if (password.length < 6) {
      return 'Password must be more than 6 character';
    }

    return null;
  }
}
