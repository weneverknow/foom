import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/core/validator/string_validator.dart';

class SignInValidation {
  // final bool isEmailValid;
  // final bool isPasswordValid;
  // final bool isEmailFormatValid;
  final String email;
  final String password;

  SignInValidation({
    required this.email,
    required this.password,
  });

  StringValidator emailValidator = NonEmptyStrinValidation();
  StringValidator passwordValidator = NonEmptyStrinValidation();

  StringValidator emailFormatValidator = EmailFormatValidation();

  bool get isEmailValid => emailValidator.isValid(email);
  bool get isEmailFormatValid => emailFormatValidator.isValid(email);
  bool get isPasswordValid => passwordValidator.isValid(password);
}

class SignInValidationCubit extends Cubit<SignInValidation?> {
  SignInValidationCubit() : super(null);

  validate(String email, String password, {String? confirmationPassword}) {
    // var validation = EmailPasswordValidation(
    //   email: email, password: password,
    // );
    // bool emailValid = validation.emailValidator.isValid(email);
    // bool passwordValid = validation.passwordValidator.isValid(password);
    // bool emailFormatValid = validation.emailFormatValidator.isValid(email);

    emit(SignInValidation(
      email: email,
      password: password,
    ));
  }
}
//class EmailPasswordValidationCubit