import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {required this.text, this.isLoading = false, this.onPressed, super.key});

  final bool? isLoading;
  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: isLoading! ? Colors.grey.shade300 : primaryColor,
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2)),
        onPressed: onPressed,
        child: Text("$text"));
  }
}
