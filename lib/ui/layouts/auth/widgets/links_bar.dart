import 'package:admin_dashbord/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

class LinksBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: (size.width > 1000) ? size.height * 0.07 : null,
      color: Colors.black,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(text: "About", onPressed: () => print("About")),
          LinkText(text: "Help Center"),
          LinkText(text: "Terms of service"),
          LinkText(text: "Privacy policy"),
          LinkText(text: "Cookie policy"),
          LinkText(text: "Ads info"),
          LinkText(text: "Blog"),
          LinkText(text: "Status"),
          LinkText(text: "Careers"),
          LinkText(text: "Brand resources"),
          LinkText(text: "Advertising"),
          LinkText(text: "Marketing"),
        ],
      ),
    );
  }
}
