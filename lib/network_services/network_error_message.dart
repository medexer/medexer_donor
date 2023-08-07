import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class NetworkErrorMessage extends StatefulWidget {
  const NetworkErrorMessage({super.key});

  @override
  State<NetworkErrorMessage> createState() => _NetworkErrorMessageState();
}

class _NetworkErrorMessageState extends State<NetworkErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomTextWidget(
              alignment: TextAlign.center,
              text:
                  "Can't connect to the internet. Please check your network or wi-fi settings",
              size: 18,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Lottie.asset('assets/animations/animation__7.json'),
          ),

          // CustomButton(
          //   text:'Try again', width: 40.0.wp, height: 6.0.hp, onTapHandler: (){}, fontSize: 17.0, backgroundColor:AppStyles.bgBlue,borderRadius: 20,fontWeight: FontWeight.normal, fontColor: AppStyles.bgWhite,)
        ],
      ),
    );
  }
}
