import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/screens/home/edit_profile.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
            child:Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                     height: 40.0.hp,
                     decoration: const BoxDecoration(
                       color:Color.fromARGB(221, 63, 62, 5),
                       borderRadius:BorderRadius.only(
                          bottomRight: Radius.circular(25), bottomLeft:Radius.circular(25), )
                        ),
                      child: Column(
                       children: [
                        menuWideget(),
                        ]
                      )
                    ),
      
                    Padding(
                      padding:  EdgeInsets.only(left:25.0.wp, top: 18.0.hp ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: CustomTextWidget(
                              text: 'John Doe',
                              color: Colors.white,
                              size: 25.0.sp,
                              weight: FontWeight.bold,
                        ),
                          ), 
                          const SizedBox(
                            height: 20,
                          ),
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
                         ]
                        ),
                      ),  
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                        hintText: "Emails",
                        hintStyle: TextStyle(color: AppStyles.bgBlack),
                        icon:  Icon(Icons.email, color: AppStyles.bgBlack)),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:  InputDecoration(
                          hintText: "password",
                          icon: Icon(Icons.lock, color: AppStyles.bgBlack),
                          ),
                      ), 
                      SizedBox(
                        height: 5.0.hp,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>const EditProfileScreen());
                        },
                        child: Container(
                          height:45,
                          width:150,
                          decoration: BoxDecoration(
                            color:const Color.fromARGB(255, 27, 8, 199),
                            borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomTextWidget(
                                  text: "Edit Profile",
                                  color: Colors.white,
                                  //weight: FontWeight.w200,
                                  size: 15.0.sp,
                                ),
                              ),
                              const Icon(Icons.edit,color: Colors.white,)
                                      ]  
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 3.0. hp,
                        ), 
                        Divider(thickness:1,color: AppStyles.bgBlack,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.logout,color: AppStyles.bgPrimary,),
                              GestureDetector(
                                onTap: () { 
                                },
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
                )
                        
              ],
            )
        ),
      )
    );
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