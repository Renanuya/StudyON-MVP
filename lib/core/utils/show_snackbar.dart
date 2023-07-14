import 'package:flutter/material.dart';

final class ShowSnackbar {
  ShowSnackbar._init();
  static final ShowSnackbar instance = ShowSnackbar._init();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  Future<void> showSnackBar(String? text) async {
    if (text == null) return;

    final snackBar = await SnackBar(
      content: Text(
        text,
      ),
      showCloseIcon: true,
    );

    messengerKey.currentState?.showSnackBar(snackBar);
  }

  Future<void> errorSnackBar(String? text, {String? title}) async {
    if (text == null) return;

    final snackBar = await SnackBar(
      showCloseIcon: true,
      closeIconColor: Colors.red,
      content: ListTile(
        leading: const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        title: Text(
          title ?? '',
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
        subtitle: Text(
          text,
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );

    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
