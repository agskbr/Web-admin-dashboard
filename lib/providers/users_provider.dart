import 'package:admin_dashbord/api/cafe_api.dart';
import 'package:admin_dashbord/models/http/users_response.dart';
import 'package:admin_dashbord/models/user.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;
  UsersProvider() {
    this.getPaginatedUsers();
  }

  getPaginatedUsers() async {
    //TO DO: Peticion http
    final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResp = UsersResponse.fromMap(resp);

    this.users = [...usersResp.usuarios];

    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserById(String uid) async {
    try {
      final resp = await CafeApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap(resp);
      return user;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((a, b) {
      final aVal = getField(a);
      final bVal = getField(b);

      return ascending
          ? Comparable.compare(aVal, bVal)
          : Comparable.compare(bVal, aVal);
    });
    ascending = !ascending;
    notifyListeners();
  }

  void refreshUsers(Usuario newUser) {
    this.users = users.map((user) {
      if (user.uid == newUser.uid) {
        user = newUser;
      }
      return user;
    }).toList();

    notifyListeners();
  }
}
