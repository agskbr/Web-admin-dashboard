import 'package:admin_dashbord/datatables/categories_datasource.dart';
import 'package:admin_dashbord/providers/categories_provider.dart';
import 'package:admin_dashbord/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashbord/ui/labels/custom_labels.dart';
import 'package:admin_dashbord/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatefulWidget {
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Categories View",
            style: CustomLabels.h1,
          ),
          SizedBox(height: 10),
          PaginatedDataTable(
            columns: [
              DataColumn(
                label: Text("ID"),
              ),
              DataColumn(
                label: Text("Categoria"),
              ),
              DataColumn(
                label: Text("Creado por"),
              ),
              DataColumn(
                label: Text("Acciones"),
              ),
            ],
            source: CategoriesDatatableSource(
                categoriesProvider.categories, context),
            header: Text("Este es el listado de categorías", maxLines: 2),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            actions: [
              CustomIconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => CategoryModal(category: null),
                  );
                },
                text: "Crear",
                icon: Icons.add_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
