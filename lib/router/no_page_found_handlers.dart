import 'package:admin_dashbord/providers/sidemenu_provider.dart';
import 'package:admin_dashbord/ui/views/no_page_found_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class NoPageFoundHandler {
  static Handler noPageFound = new Handler(
    handlerFunc: (context, params) {
      Provider.of<SideMenuProvider>(context!, listen: false)
          .setCurrentPageUrl('/404');

      return NoPageFoundView();
    },
  );
}
