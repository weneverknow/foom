abstract class StringValidator {
  bool isValid(String val);
}

class NonEmptyStrinValidation extends StringValidator {
  @override
  bool isValid(String val) {
    return val.isNotEmpty;
  }
}

class EmailFormatValidation extends StringValidator {
  @override
  bool isValid(String val) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(val);
  }
}

class MatchPasswordValidation extends StringValidator {
  final String password;
  MatchPasswordValidation(this.password);
  @override
  bool isValid(String val) {
    return val == password;
  }
}
