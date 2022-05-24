import 'package:admin_dashbord/providers/auth_provider.dart';
import 'package:admin_dashbord/providers/sidemenu_provider.dart';
import 'package:admin_dashbord/router/router.dart';
import 'package:admin_dashbord/services/navigation-service.dart';
import 'package:admin_dashbord/ui/shared/widgets/logo.dart';
import 'package:admin_dashbord/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashbord/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Logo(),
          SizedBox(height: 50),
          TextSeparator(text: 'main'),
          ItemMenu(
            text: 'Dashboard',
            isActive:
                sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute),
          ),
          ItemMenu(
            text: 'Orders',
            icon: Icons.shopping_cart_outlined,
            onPressed: () {},
          ),
          ItemMenu(
            text: 'Analytic',
            icon: Icons.show_chart_outlined,
            onPressed: () {},
          ),
          ItemMenu(
            text: 'Categories',
            icon: Icons.layers_outlined,
            onPressed: () => navigateTo(Flurorouter.categoriesRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
          ),
          ItemMenu(
            text: 'Products',
            icon: Icons.dashboard_outlined,
            onPressed: () {},
          ),
          ItemMenu(
            text: 'Discount',
            icon: Icons.attach_money_outlined,
            onPressed: () {},
          ),
          ItemMenu(
            text: 'Users',
            icon: Icons.people_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.usersRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.usersRoute,
          ),
          SizedBox(height: 30),
          TextSeparator(text: 'UI Elements'),
          ItemMenu(
            text: 'Icons',
            isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
            icon: Icons.list_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.iconsRoute),
          ),
          ItemMenu(
            text: 'Marketing',
            icon: Icons.mark_email_read_outlined,
            onPressed: () {},
          ),
          ItemMenu(
            text: 'Campaign',
            icon: Icons.note_add_outlined,
            onPressed: () {},
          ),
          ItemMenu(
            text: 'Blank Page',
            icon: Icons.post_add_outlined,
            onPressed: () => navigateTo(Flurorouter.blankRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
          ),
          SizedBox(height: 50),
          TextSeparator(text: 'Exit'),
          ItemMenu(
            text: 'LogOut',
            icon: Icons.exit_to_app_outlined,
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff092044), Color(0xff092042)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      );
}
