import 'package:admin_dashbord/api/cafe_api.dart';
import 'package:admin_dashbord/models/category.dart';
import 'package:admin_dashbord/models/http/categories_response.dart';
import 'package:flutter/cupertino.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Categoria> categories = [];

  Future getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);

    this.categories = [...categoriesResp.categorias];

    print(categories);

    notifyListeners();
  }

  Future newCategory(String name) async {
    final data = {
      'nombre': name,
    };
    try {
      final json = await CafeApi.httpPost('/categorias', data);
      final newCategory = Categoria.fromMap(json);

      categories.add(newCategory);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

  Future updateCategory(String id, String name) async {
    try {
      final data = {
        'nombre': name,
      };

      await CafeApi.httpPut('/categorias/$id', data);
      this.categories = this.categories.map<Categoria>((category) {
        if (category.id != id) return category;
        category.nombre = name;
        return category;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar categoria';
    }
  }

  Future deleteCategory(String id) async {
    try {
      await CafeApi.httpDelete('/categorias/$id');
      categories.removeWhere((category) => category.id == id);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
