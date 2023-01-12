import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foom/core/constants/constants.dart';
import 'package:foom/core/cubit/button_pressed_cubit.dart';
import 'package:foom/core/messages/messages.dart';
import 'package:foom/core/widgets/dialog_widget.dart';
import 'package:foom/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:foom/features/authentication/presentation/bloc/registration_bloc.dart';
import 'package:foom/features/authentication/presentation/cubit/create_account_validation_cubit.dart';
import 'package:foom/features/authentication/presentation/cubit/sign_in_validation_cubit.dart';
import 'package:foom/features/authentication/presentation/cubit/password_visibility_cubit.dart';
import 'package:foom/features/authentication/presentation/login_screen.dart';

import 'cubit/page_selected_cubit.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    Fluttertoast.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
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
        BlocListener<CreateAccountValidationCubit, CreateAccountValidation?>(
          listener: (context, state) async {
            if (state != null) {
              if (state.isEmailFormatValid &&
                  state.isConfirmationPasswordValid &&
                  state.isEmailValid &&
                  state.isPasswordValid &&
                  state.isPasswordMatch) {
                print("sign up executed");
                context.read<ButtonPressedCubit>().update();
                await Future.delayed(Duration(seconds: 2));
                context.read<AuthenticationBloc>().add(
                    await AuthenticationCreateAccount(
                        _emailController.text, _passwordController.text));
                context.read<ButtonPressedCubit>().update();
                //Navigator.pop(context);
                //Navigator.pop(context);

                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => ), (route) => false)
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Registration",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.black),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              Image.asset(
                "assets/images/register.jpg",
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              BlocBuilder<CreateAccountValidationCubit,
                  CreateAccountValidation?>(
                builder: (context, state) {
                  return buildInput(
                      controller: _emailController,
                      hintText: "Enter your email address",
                      prefixIcon: Icon(Icons.email),
                      inputType: TextInputType.emailAddress,
                      errorText: state == null
                          ? null
                          : (state.isEmailValid
                              ? (state.isEmailFormatValid
                                  ? null
                                  : errorEmailFormat)
                              : errorEmailEmpty));
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              BlocProvider(
                create: (context) => PasswordVisibilityCubit(),
                child: BlocBuilder<CreateAccountValidationCubit,
                    CreateAccountValidation?>(
                  builder: (context, validationState) {
                    return BlocBuilder<PasswordVisibilityCubit, bool>(
                      builder: (context, state) {
                        return buildInput(
                            controller: _passwordController,
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
                            obscureText: !state,
                            errorText: validationState == null
                                ? null
                                : (validationState.isPasswordValid
                                    ? (validationState.isPasswordMatch
                                        ? null
                                        : errorPasswordUnMatch)
                                    : errorPasswordEmpty));
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              BlocProvider(
                create: (context) => PasswordVisibilityCubit(),
                child: BlocBuilder<CreateAccountValidationCubit,
                    CreateAccountValidation?>(
                  builder: (context, validationState) {
                    return BlocBuilder<PasswordVisibilityCubit, bool>(
                      builder: (context, state) {
                        return buildInput(
                            controller: _confirmPasswordController,
                            hintText: "Enter your confirmation password",
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
                            obscureText: !state,
                            errorText: validationState == null
                                ? null
                                : (validationState.isConfirmationPasswordValid
                                    ? (validationState.isPasswordMatch
                                        ? null
                                        : errorPasswordUnMatch)
                                    : errorPasswordEmpty));
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              BlocBuilder<ButtonPressedCubit, bool>(
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
                              context
                                  .read<CreateAccountValidationCubit>()
                                  .validate(
                                    _emailController.text,
                                    _passwordController.text,
                                    _confirmPasswordController.text,
                                  );
                              // context.read<ButtonPressedCubit>().update();

                              // context.read<ButtonPressedCubit>().update();
                            },
                      child: Text(
                        state ? "PLEASE WAIT..." : "CREATE ACCOUNT",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ));
                },
              )
            ],
          ),
        )),
      ),
    );
  }
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
