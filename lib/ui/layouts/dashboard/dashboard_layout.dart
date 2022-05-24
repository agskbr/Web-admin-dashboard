import 'package:admin_dashbord/providers/sidemenu_provider.dart';
import 'package:admin_dashbord/ui/shared/sidebar.dart';
import 'package:admin_dashbord/ui/shared/widgets/navbar.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  _DashboardLayoutState createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SideMenuProvider.menuController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              //To Do: esto depende si tiene mas de 700px
              if (size.width >= 700) Sidebar(),
              Expanded(
                child: Column(
                  children: [
                    //NavBar
                    NavBar(),

                    //View
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  if (SideMenuProvider.isOpen)
                    AnimatedOpacity(
                      opacity: SideMenuProvider.opacity.value,
                      duration: Duration(milliseconds: 200),
                      child: GestureDetector(
                        onTap: SideMenuProvider.closeMenu,
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(SideMenuProvider.movement.value, 0),
                    child: Sidebar(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
