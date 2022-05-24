import 'dart:typed_data';

import 'package:admin_dashbord/api/cafe_api.dart';
import 'package:admin_dashbord/models/user.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  Usuario? user;

  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }) {
    user = new Usuario(
      rol: rol ?? this.user!.rol,
      estado: estado ?? this.user!.estado,
      google: google ?? this.user!.google,
      nombre: nombre ?? this.user!.nombre,
      correo: correo ?? this.user!.correo,
      uid: uid ?? this.user!.uid,
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future<bool> updateUser() async {
    if (!this._validForm()) return false;

    final data = {
      'nombre': user!.nombre,
      'correo': user!.correo,
    };
    try {
      final resp = await CafeApi.httpPut('/usuarios/${user!.uid}', data);
      print(resp);
      return true;
    } catch (e) {
      print("ERROR EN UPDATE USER: $e");
      return false;
    }
  }

  Future<Usuario> uploadImage(String path, Uint8List bytes) async {
    try {
      final resp = await CafeApi.uploadFile(path, bytes);
      user = Usuario.fromMap(resp);
      notifyListeners();
      return user!;
    } catch (e) {
      print(e);
      throw "Error en userFormProvider";
    }
  }
}
