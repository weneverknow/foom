import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/core/constants/constants.dart';
import 'package:foom/core/cubit/button_pressed_cubit.dart';

import 'package:foom/core/widgets/dialog_widget.dart';

import 'package:foom/features/authentication/presentation/cubit/page_selected_cubit.dart';

import 'package:foom/features/authentication/presentation/cubit/sign_in_validation_cubit.dart';
import '../../../core/messages/messages.dart';
import 'bloc/authentication_bloc.dart';
import 'cubit/password_visibility_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignInValidationCubit, SignInValidation?>(
            listenWhen: ((previous, current) => true),
            listener: (context, state) async {
              //print("[LoginScreen] ${}");
              if (state != null) {
                if (state.isEmailValid &&
                    state.isEmailFormatValid &&
                    state.isPasswordValid) {
                  context.read<ButtonPressedCubit>().update();
                  context.read<AuthenticationBloc>().add(
                      await AuthenticationWithEmail(
                          _emailController.text, _passwordController.text));
                  context.read<ButtonPressedCubit>().update();
                }
              }
            }),
        BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
          if (state is AuthenticationFailed) {
            await showErrorDialog(context,
                title: "Failed", message: state.message);
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationProcessReset());
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 230, 232, 239),
        body: ListView(
          children: [
            const SizedBox(
              height: defaultPadding * 3,
            ),
            Text(
              "Hello Again!",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(
              "Welcome back! you\'ve\nbeen missed",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: BlocBuilder<SignInValidationCubit, SignInValidation?>(
                builder: (context, state) {
                  return buildInput(
                    controller: _emailController,
                    errorText: state == null
                        ? null
                        : (state.isEmailValid
                            ? (state.isEmailFormatValid
                                ? null
                                : errorEmailFormat)
                            : errorEmailEmpty),
                    hintText: "Enter your email address",
                    prefixIcon: Icon(Icons.email),
                    inputType: TextInputType.emailAddress,
                  );
                },
              ),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            BlocProvider(
              create: (context) => PasswordVisibilityCubit(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: BlocBuilder<SignInValidationCubit, SignInValidation?>(
                  builder: (context, validationState) {
                    return BlocBuilder<PasswordVisibilityCubit, bool>(
                      builder: (context, state) {
                        return buildInput(
                          obscureText: !state,
                          controller: _passwordController,
                          errorText: validationState == null
                              ? null
                              : (validationState.isPasswordValid
                                  ? null
                                  : errorPasswordEmpty),
                          hintText: "Enter your password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<PasswordVisibilityCubit>()
                                    .update();
                              },
                              child: !state
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                          inputType: TextInputType.emailAddress,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: BlocBuilder<ButtonPressedCubit, bool>(
                builder: (context, state) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: state
                          ? null
                          : () async {
                              await context
                                  .read<SignInValidationCubit>()
                                  .validate(_emailController.text,
                                      _passwordController.text);
                            },
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ));
                },
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      side: BorderSide(color: primaryColor),
                      foregroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    context.read<PageSelectedCubit>().changeToRegister();
                  },
                  child: Text("CREATE AN ACCOUNT")),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildInput({
    TextEditingController? controller,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? inputType,
    bool obscureText = false,
    String? errorText,
  }) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
          hintText: "$hintText",
          focusColor: primaryColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.black54, width: 0.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.black54, width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.black54, width: 0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.black54, width: 0.5))),
    );
  }
}
