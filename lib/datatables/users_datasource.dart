import 'package:admin_dashbord/models/user.dart';
import 'package:admin_dashbord/services/navigation-service.dart';
import 'package:flutter/material.dart';

class UsersDatasource extends DataTableSource {
  final List<Usuario> users;
  final BuildContext context;

  UsersDatasource(this.users, this.context);
  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];
    final image = user.img == null
        ? Image(
            image: AssetImage("no-image.jpg"),
            width: 35,
            height: 35,
          )
        : Image(
            image: NetworkImage(user.img!),
            width: 35,
            height: 35,
          );

    return DataRow.byIndex(
      cells: [
        DataCell(
          ClipOval(child: image),
        ),
        DataCell(
          Text(user.nombre),
        ),
        DataCell(
          Text(user.correo),
        ),
        DataCell(
          Text(user.uid),
        ),
        DataCell(
          IconButton(
            icon: Icon(Icons.edit_outlined),
            splashRadius: 20,
            onPressed: () {
              NavigationService.replaceTo('/dashboard/users/${user.uid}');
            },
          ),
        ),
      ],
      index: index,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
