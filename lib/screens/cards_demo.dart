import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/card/custom_card.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: CustomCard(
          color: AppStyles.bgPrimary, 
          text: 'click red', 
          text1: 'blue', 
          onTapHandler: (){}, 
          width: 200, 
          height: 200, 
          fontSize: 20, 
          fontColor: Colors.green, 
          borderRadius: 20, 
         backgroundColor: Colors.white,
          fontWeight: FontWeight.bold
          ),
      ),
    );
  }
}