abstract class CustomValidators {

  /// Email Validation
  static String? validateEmail(String? value){
    if(value==null || value.isEmpty){
      return "Email is required";
    }
    const emailRegex =
        r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  //phone verification
  static String? validatePhone(String? value){
    if(value?.length!=10){
      return"Invalid Mobile No.";
    }
  }

  /// Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must have at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must have at least one lowercase letter';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must have at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must have at least one special character';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, {String? password}) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value != password){
        return 'Password not match';
      }
      return null;

    }
    static String? validateRequired(String? value,) {
      if (value == null || value.isEmpty) {
        return 'This field is required';
      }
      return null;

    }

}
