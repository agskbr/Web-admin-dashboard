import 'package:admin_dashbord/providers/sidemenu_provider.dart';
import 'package:admin_dashbord/ui/shared/widgets/navbar_avatar.dart';
import 'package:admin_dashbord/ui/shared/widgets/notification_indicator.dart';
import 'package:admin_dashbord/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 50,
      decoration: builBoxDecoration(),
      child: Stack(
        children: [
          Row(
            children: [
              //To Do: Icono del menu
              if (size.width <= 700)
                IconButton(
                  onPressed: () {
                    SideMenuProvider.openMenu();
                  },
                  icon: Icon(Icons.menu_outlined),
                ),
              SizedBox(width: 5),

              //Search input
              if (size.width > 390)
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: SearchText(),
                ),
              Spacer(),

              NotificationIndicator(),
              SizedBox(width: 10),
              NavbarAvatar(),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration builBoxDecoration() => BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
