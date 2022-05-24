import 'package:admin_dashbord/models/category.dart';
import 'package:admin_dashbord/providers/categories_provider.dart';
import 'package:admin_dashbord/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesDatatableSource extends DataTableSource {
  final List<Categoria> categories;
  final BuildContext context;

  CategoriesDatatableSource(this.categories, this.context);
  @override
  DataRow getRow(int index) {
    final category = categories[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text(category.id),
        ),
        DataCell(
          Text(category.nombre),
        ),
        DataCell(
          Text(category.usuario.nombre),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CategoryModal(category: category),
                  );
                },
                icon: Icon(Icons.edit_outlined),
                splashRadius: 20,
              ),
              IconButton(
                onPressed: () {
                  final dialog = AlertDialog(
                    title: Text("¿Está seguro?"),
                    content:
                        Text("¿Borrar definitivamente categoria $category?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Provider.of<CategoriesProvider>(context,
                                  listen: false)
                              .deleteCategory(category.id);

                          Navigator.pop(context);
                        },
                        child: Text("Si, borrar"),
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8),
                ),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}
