
import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';

class NetworkErrorMessage extends StatefulWidget {
  const NetworkErrorMessage({super.key});

  @override
  State<NetworkErrorMessage> createState() => _NetworkErrorMessageState();
}

class _NetworkErrorMessageState extends State<NetworkErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment:MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30.0.hp,),
        Padding(
          padding:  EdgeInsets.all(8.0.wp),
          child: const Text("Can't connect to the internet. Please check your network or wi-fi sttings"),
        ),
        SizedBox(height: 7.0.hp,),
        // CustomButton(
        //   text:'Try again', width: 40.0.wp, height: 6.0.hp, onTapHandler: (){}, fontSize: 17.0, backgroundColor:AppStyles.bgBlue,borderRadius: 20,fontWeight: FontWeight.normal, fontColor: AppStyles.bgWhite,)
        
      ],
    );
  }
}