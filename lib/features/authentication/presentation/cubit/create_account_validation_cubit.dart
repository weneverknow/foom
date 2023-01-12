import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/core/validator/string_validator.dart';

class CreateAccountValidation {
  final String email;
  final String password;
  final String confirmationPassword;

  CreateAccountValidation({
    required this.email,
    required this.password,
    required this.confirmationPassword,
  });

  StringValidator emailValidator = NonEmptyStrinValidation();
  StringValidator passwordValidator = NonEmptyStrinValidation();
  StringValidator confirmationPasswordValidator = NonEmptyStrinValidation();
  StringValidator emailFormatValidator = EmailFormatValidation();

  bool get isEmailValid => emailValidator.isValid(email);
  bool get isEmailFormatValid => emailFormatValidator.isValid(email);
  bool get isPasswordValid => passwordValidator.isValid(password);
  bool get isConfirmationPasswordValid => passwordValidator.isValid(password);

  bool get isPasswordMatch => password == confirmationPassword;
}

class CreateAccountValidationCubit extends Cubit<CreateAccountValidation?> {
  CreateAccountValidationCubit() : super(null);

  validate(String email, String password, String confirmationPassword) {
    // var validation = EmailPasswordValidation(
    //   email: email, password: password,
    // );
    // bool emailValid = validation.emailValidator.isValid(email);
    // bool passwordValid = validation.passwordValidator.isValid(password);
    // bool emailFormatValid = validation.emailFormatValidator.isValid(email);

    emit(CreateAccountValidation(
      email: email,
      password: password,
      confirmationPassword: confirmationPassword,
    ));
  }
}
//class EmailPasswordValidationCubit