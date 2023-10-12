import '../core/strings.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  int toInt() {
    return int.parse(this);
  }

  double toDouble() {
    return double.parse(this);
  }

  num toNum() {
    return num.parse(this);
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(Strings.emailValidator);
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(Strings.nameValidator);
    return nameRegExp.hasMatch(this);
  }

  bool get isValidDOB {
    final dobRegExp = RegExp(Strings.dobValidator);
    return dobRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(Strings.passValidator);
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return isNotEmpty;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(Strings.phoneValidator);
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidPincode {
    final pincodeRegExp = RegExp(Strings.pincodeValidator);
    return pincodeRegExp.hasMatch(this);
  }
}
