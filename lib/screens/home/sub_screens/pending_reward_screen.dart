import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class PendingRewardScreen extends StatefulWidget {
  const PendingRewardScreen({super.key});

  @override
  State<PendingRewardScreen> createState() => _PendingRewardScreenState();
}

class _PendingRewardScreenState extends State<PendingRewardScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      key: scaffoldKey,
      backgroundColor: AppStyles.bgWhite,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 2.0.hp),
              PageHeader(scaffoldKey: scaffoldKey),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Lottie.asset('assets/animations/animation__6.json'),
              ),
              SizedBox(height: 4.0.hp),
              CustomTextWidget(text: 'Coming Soon!'),
            ],
          ),
        ),
      ),
    );
  }
}
