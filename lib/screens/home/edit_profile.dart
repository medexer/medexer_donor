import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';
import '../../widgets/buttons/custom_button.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back,
            color: AppStyles.bgBlack,
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(top: 15.0.hp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CustomTextWidget(
                        text: 'Edit Profile',
                        color: AppStyles.bgBlue,
                        size: 20.0.sp,
                        weight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 2.0.hp),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 70,
                                child: ClipOval(
                                  child: SizedBox(
                                      width: 40.0.hp,
                                      height: 40.0.hp,
                                      child: Image.network(
                                        'https://lh3.googleusercontent.com/ogw/AAEL6shLVXko6DVVYDFXg_ko3zpbav1U79fdVJNSyENJfQ=s32-c-mo',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left:16.0.hp, top: 13.0.hp),
                              child: GestureDetector(
                                onTap: () async {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Icon(Icons.add_a_photo, size: 3.0.hp, color: AppStyles.bgBlack,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Padding(
                          padding: EdgeInsets.all(3.0.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: 'John Doe',
                                size: 18.0.sp,
                                weight: FontWeight.w500,
                                ),
                              CustomTextWidget(
                                text: 'johndoe@gmail.com',
                                size: 12.0.sp,
                                weight: FontWeight.w500,
                                ),
                            ],
                          ),
                        )
                      ],
                    )
                  ]),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "johndoe@gmail.com",
                          hintStyle: TextStyle(color: AppStyles.bgBlack),
                          icon: Icon(Icons.email, color: AppStyles.bgBlack)),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "*********",
                        icon: Icon(Icons.lock, color: AppStyles.bgBlack),
                      ),
                    ),
                    SizedBox(
                      height: 5.0.hp,
                    ),

                    CustomButton(
                      text: 'Submit',
                       width: 120.0, 
                       height: 45.0, 
                       onTapHandler: (){}, 
                       fontSize: 15.0.sp, 
                       fontColor: Colors.white, 
                       fontWeight: FontWeight.w200, 
                       borderRadius: 20.0, 
                       backgroundColor: AppStyles.bgBlue,
                    ),
                    SizedBox(
                      height: 3.0.hp,
                    ),
                    Divider(
                      thickness: 1,
                      color: AppStyles.bgBlack,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppStyles.bgPrimary,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: CustomTextWidget(
                              text: 'LogOut',
                              size: 12.0.sp,
                              color: AppStyles.bgPrimary,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  Container menuWideget() {
    return Container(
      margin: EdgeInsets.only(
        top: 1.0.hp,
        left: 2.0.wp,
        right: 2.0.wp,
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
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppStyles.bgBlack,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/images/logo__1.png'),
          )
        ],
      ),
    );
  }
}
