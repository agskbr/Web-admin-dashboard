import 'package:admin_dashbord/datatables/users_datasource.dart';
import 'package:admin_dashbord/providers/users_provider.dart';
import 'package:admin_dashbord/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final userDataSource = new UsersDatasource(usersProvider.users, context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Users View",
            style: CustomLabels.h1,
          ),
          SizedBox(height: 10),
          PaginatedDataTable(
            onPageChanged: (page) {
              print(page);
            },
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumnIndex,
            columns: [
              DataColumn(
                label: Text("Avatar"),
              ),
              DataColumn(
                label: Text("Nombre"),
                onSort: (colIndex, _) {
                  usersProvider.sortColumnIndex = colIndex;
                  usersProvider.sort<String>((user) => user.nombre);
                },
              ),
              DataColumn(
                label: Text("Email"),
                onSort: (colIndex, _) {
                  usersProvider.sortColumnIndex = colIndex;
                  usersProvider.sort<String>((user) => user.correo);
                },
              ),
              DataColumn(
                label: Text("UID"),
              ),
              DataColumn(
                label: Text("Acciones"),
              ),
            ],
            source: userDataSource,
          )
        ],
      ),
    );
  }
}
