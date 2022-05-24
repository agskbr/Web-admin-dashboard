import 'package:admin_dashbord/providers/auth_provider.dart';
import 'package:admin_dashbord/ui/cards/white_card.dart';
import 'package:admin_dashbord/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Dashboard View",
            style: CustomLabels.h1,
          ),
          SizedBox(height: 10),
          WhiteCard(
            title: authProvider.user!.nombre,
            child: Text(authProvider.user!.correo),
          ),
        ],
      ),
    );
  }
}
