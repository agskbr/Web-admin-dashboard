import 'package:flutter/cupertino.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      print("Form válido... creando cuenta");
      return true;
    } else {
      print("Form no válido");
      return false;
    }
  }
}
