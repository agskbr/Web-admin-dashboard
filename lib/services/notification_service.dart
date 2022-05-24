import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static showSnackbarError(String message) {
    final SnackBar snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Colors.red.withOpacity(0.9),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbarSuccesful(String message) {
    final SnackBar snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showImageLoading(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      content: Container(
        height: 100,
        width: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(context: context, builder: (_) => dialog);
  }
}
