class Strings {
  static String emailValidator =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static String passValidator =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static String phoneValidator =
      r'^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$';
  static String dobValidator = r"^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$";
  static String nameValidator = r"^[a-zA-Z]+$";
  static String pincodeValidator = r"^[1-9][0-9]{5}$";
  static String signup = "Sign Up";
  static String signupdes =
      "Sign Up with your Name, Email and Password to Continue";
  static String signIn = "Sign In";
  static String signIndes = "Sign In with your Email and Password to Continue";
  static String alreadyhaveaccount = "Already have an account?";
  static String donthaveaccount = "Don't have any account?";
  static String forgotpass = "Forgot Password?";
  static String recoverypass = "Recovery Password";
  static String resetpass = "Reset Password";
  static String otpdidnotmatch = "Entered OTP Didn't Match";
  static String story1heading = "Shop your daily needs";
  static String story1desc =
      "You won't find it cheaper anywhere else than Shopist";
  static String add = "Add";
  static String checkout = "Checkout >>";
  static String logout = "Logout";
  static String editprofile = "Edit Profile";
  static String track = "Track";
  static String cancel = "Cancel";
  static String invoice = "Invoice";
}
