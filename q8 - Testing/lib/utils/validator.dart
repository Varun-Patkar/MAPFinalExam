class FieldValidator {
  static String? validateEmail(String? value) {
    if (value.toString().isEmpty) return "Enter Email";
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value.toString())) {
      return 'Enter valid Email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value.toString().isEmpty) return "Enter Password";
    if (value.toString().length < 7) {
      return 'Password must be more than 6 characters';
    }
  }
}
