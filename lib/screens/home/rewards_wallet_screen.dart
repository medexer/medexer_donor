// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/widgets/page_header.dart';

class RewardsWalletScreen extends StatefulWidget {
  const RewardsWalletScreen({super.key});

  @override
  State<RewardsWalletScreen> createState() => _RewardsWalletScreenState();
}

class _RewardsWalletScreenState extends State<RewardsWalletScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: SafeArea(
        child: Container(
          height: screenHeight,
          child: Column(
            children: [
              PageHeader(scaffoldKey: scaffoldKey),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text('Rewards'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
