import 'package:admin_dashbord/ui/cards/white_card.dart';
import 'package:admin_dashbord/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class BlankView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Blank View",
            style: CustomLabels.h1,
          ),
          SizedBox(height: 10),
          WhiteCard(
            title: 'Sales statistics',
            child: Text("Hola mundo"),
          ),
        ],
      ),
    );
  }
}
