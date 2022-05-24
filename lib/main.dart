import 'package:admin_dashbord/api/cafe_api.dart';
import 'package:admin_dashbord/providers/providers.dart';

import 'package:admin_dashbord/router/router.dart';
import 'package:admin_dashbord/services/services.dart';

import 'package:admin_dashbord/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashbord/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashbord/ui/layouts/splash/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => SideMenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserFormProvider(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorkey,
      scaffoldMessengerKey: NotificationService.messengerKey,
      theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thickness: MaterialStateProperty.all(5),
          thumbColor: MaterialStateProperty.all(Colors.grey[500]),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.authStatus == AuthStatus.checking)
          return SplashLayout();
        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
    );
  }
}
