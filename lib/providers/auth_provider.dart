import 'package:admin_dashbord/api/cafe_api.dart';
import 'package:admin_dashbord/models/http/auth_response.dart';
import 'package:admin_dashbord/models/user.dart';
import 'package:admin_dashbord/router/router.dart';
import 'package:admin_dashbord/services/local_storage.dart';
import 'package:admin_dashbord/services/navigation-service.dart';
import 'package:admin_dashbord/services/notification_service.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    this.isAuthenticated();
  }

  register(String name, String email, String password) {
    final data = {
      'nombre': name,
      'correo': email,
      'password': password,
    };

    CafeApi.httpPost('/usuarios', data).then((json) {
      print(json);

      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      CafeApi.configureDio();
      notifyListeners();
    }).catchError((e) {
      print('Error en $e');
      NotificationService.showSnackbarError("Credenciales no válidas");
    });
  }

  login(String email, String password) {
    final data = {
      'correo': email,
      'password': password,
    };
    CafeApi.httpPost('/auth/login', data).then(
      (json) {
        final authResponse = AuthResponse.fromMap(json);
        this.user = authResponse.usuario;
        this._token = "asdasdafasd.asdasdasdq.asdqwd";
        LocalStorage.prefs.setString('token', authResponse.token);

        authStatus = AuthStatus.authenticated;
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
        CafeApi.configureDio();
        notifyListeners();
      },
    ).catchError((e) {
      print('Error en $e');
      NotificationService.showSnackbarError('Error en la credenciales');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.get('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await CafeApi.httpGet('/auth');

      final authResponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authResponse.token);
      this.user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logOut() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
