import 'package:admin_dashbord/models/category.dart';
import 'package:admin_dashbord/providers/categories_provider.dart';
import 'package:admin_dashbord/services/notification_service.dart';
import 'package:admin_dashbord/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashbord/ui/inputs/custom_inputs.dart';
import 'package:admin_dashbord/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryModal extends StatefulWidget {
  final Categoria? category;

  const CategoryModal({Key? key, this.category}) : super(key: key);
  @override
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String name = '';
  String? id = '';

  @override
  void initState() {
    super.initState();
    id = widget.category?.id;
    name = widget.category?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      width: 300,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category?.nombre ?? 'Nueva categoria',
                style: CustomLabels.h1.copyWith(color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.3),
          ),
          SizedBox(height: 20),
          TextFormField(
            initialValue: widget.category?.nombre ?? '',
            onChanged: (val) => name = val,
            decoration: CustomInputs.authInputDecoration(
              hint: "Nombre de la categoria",
              label: "Categoria",
              icon: Icons.new_releases_outlined,
            ),
            style: TextStyle(color: Colors.white),
          ),
          Container(
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    //crear
                    await categoriesProvider.newCategory(name);
                    NotificationService.showSnackbarSuccesful("$name Creado");
                  } else {
                    //actualizar
                    categoriesProvider.updateCategory(id!, name);
                    NotificationService.showSnackbarSuccesful(
                        "$name Actualizado");
                  }
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  NotificationService.showSnackbarError(
                      "No se pudo guardar la categoria");
                }
              },
              text: "Guardar",
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: 30),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color(0xff0F2041),
        boxShadow: [
          BoxShadow(color: Colors.black26),
        ],
      );
}
