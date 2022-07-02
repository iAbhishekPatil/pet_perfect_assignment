import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static void custom({
    required BuildContext context,
    required String text,
    required IconData icon,
    required Color color,
  }) {
    //? method to show snackbar
    final snackBar = SnackBar(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  //? error
  static void error({
    required BuildContext context,
    required String text,
  }) {
    return custom(
      context: context,
      text: text,
      icon: Icons.error,
      color: Colors.red.shade300,
    );
  }

  //? success
  static void success({
    required BuildContext context,
    required String text,
  }) {
    return custom(
      context: context,
      text: text,
      icon: Icons.check,
      color: Colors.green.shade300,
    );
  }

  //? success
  static void info({
    required BuildContext context,
    required String text,
  }) {
    return custom(
      context: context,
      text: text,
      icon: Icons.air_sharp,
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
    );
  }
}
