import 'package:flutter/material.dart';
import 'package:medexer_donor/config/app_config.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../../widgets/text/custom_text_widget.dart';

class TattoosScreen extends StatefulWidget {
 
  TattoosScreen({super.key});

  @override
  State<TattoosScreen> createState() =>_TattoosScreenState();
}
class _TattoosScreenState extends State<TattoosScreen> {
  final allChecked = CheckModal(title: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(20.0.sp),
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 5.0.hp,),
                    Container(
                      width: 20.0.wp,
                      height: 25.0.hp,
                      child:Image.asset('assets/images/logo__1.png'), 
                    ),
                    
                    Center(
                      child: CustomTextWidget(
                        text: 'We appreciate your efforts to want to embark on this noble journey to become a blood donor!\n\n\tUnfortunate, having a tattoo makes you medically unfit to donate.However, you can spread the good news of blood donation to your family and friends!\n\n\t We wish you all the best in your future endavours!',
                        size: 13.0.sp,

                        ),
                    ),

                    SizedBox(height: 10.0.hp,),
                    CustomButton(
                        text: 'DONE', 
                        width: 50.0.wp,
                        height: 6.0.hp, 
                        fontSize: 15.0.sp, 
                        fontColor: Colors.white, 
                        fontWeight:FontWeight.normal, 
                        borderRadius: 20, 
                        backgroundColor: AppStyles.bgBlue, 
                        onTapHandler: (){},
                    ),
                        
               ],
             ),
        ),    
      ),
    );
  }
}

class CheckModal{
  String title;
  bool value;
  CheckModal({required this.title, this.value=false});

}
