// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';

class PageHeader extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const PageHeader({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 2.0.hp,
        left: 2.5.wp,
        right: 2.5.wp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 1,
                  spreadRadius: 1,
                )
              ],
            ),
            child: IconButton(
              onPressed: () {
                // Scaffold.of(context).openDrawer();
                // SideBar();
                scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: AppStyles.bgBlack,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            child: Image.asset('assets/images/logo__1.png'),
          )
        ],
      ),
    );
  }
}
