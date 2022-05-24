import 'package:admin_dashbord/providers/auth_provider.dart';
import 'package:admin_dashbord/providers/sidemenu_provider.dart';
import 'package:admin_dashbord/router/router.dart';
import 'package:admin_dashbord/ui/views/blank_view.dart';
import 'package:admin_dashbord/ui/views/categories_view.dart';
import 'package:admin_dashbord/ui/views/dashboard_view.dart';
import 'package:admin_dashbord/ui/views/icons_view.dart';
import 'package:admin_dashbord/ui/views/login_view.dart';
import 'package:admin_dashbord/ui/views/user_view.dart';
import 'package:admin_dashbord/ui/views/users_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {
  static Handler dashboard = new Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.dashboardRoute);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return DashboardView();
      else
        return LoginView();
    },
  );

  static Handler icons = new Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.iconsRoute);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return IconsView();
      else
        return LoginView();
    },
  );
  static Handler blank = new Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.blankRoute);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return BlankView();
      else
        return LoginView();
    },
  );
  static Handler categories = new Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.categoriesRoute);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return CategoriesView();
      else
        return LoginView();
    },
  );
  static Handler users = new Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.usersRoute);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return UsersView();
      else
        return LoginView();
    },
  );
  static Handler user = new Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.userRoute);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        if (params['uid']?.first != null) {
          return UserView(uid: params['uid']!.first);
        } else {
          return UsersView();
        }
      } else {
        return LoginView();
      }
    },
  );
}
