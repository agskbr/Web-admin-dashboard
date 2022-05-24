import 'package:admin_dashbord/ui/cards/white_card.dart';
import 'package:admin_dashbord/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class IconsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Icons View",
            style: CustomLabels.h1,
          ),
          SizedBox(height: 10),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              WhiteCard(
                title: "NAME",
                child: Center(
                  child: Icon(Icons.ac_unit_outlined),
                ),
                width: 170,
              ),
               WhiteCard(
                 title: "NAME",
                child: Center(
                  child: Icon(Icons.access_alarm_outlined),
                ),
                width: 170,
              ),
               WhiteCard(
                 title: "NAME",
                child: Center(
                  child: Icon(Icons.account_balance_wallet_outlined),
                ),
                width: 170,
              ),
               WhiteCard(
                 title: "NAME",
                child: Center(
                  child: Icon(Icons.g_mobiledata_outlined),
                ),
                width: 170,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
