// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/database/user_repository.dart';
import 'package:medexer_donor/screens/home/donor_profile.dart/edit_profile.dart';
import 'package:medexer_donor/screens/home/sidebar.dart';
import 'package:medexer_donor/services/auth_services.dart';
import 'package:medexer_donor/widgets/page_header.dart';
import 'package:medexer_donor/config/api_config.dart';
import 'package:file_picker/file_picker.dart';
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
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool newAvatar = false;
  late PlatformFile avatar;
  final AuthServices authServices = Get.find();
  final UserRepository userRepository = Get.find();

  @override
  void initState() {
    super.initState();

    setState(() {
      emailController.text = "${userRepository.userData.value.email}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Obx(
          () => SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30.0.hp,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(221, 5, 60, 63),
                        // borderRadius: BorderRadius.only(
                        //   bottomRight: Radius.circular(25),
                        //   bottomLeft: Radius.circular(25),
                        // ),
                      ),
                      child: Column(
                        children: [
                          PageHeader(scaffoldKey: scaffoldKey),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0.wp, top: 14.0.hp),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: CustomTextWidget(
                            text: '${userRepository.userData.value.fullName}',
                            color: Colors.white,
                            size: 20.0.sp,
                            // weight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.0.hp),
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
                                      '${APIConstants.backendServerRootUrl}${userRepository.userData.value.avatar}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 14.0.hp, top: 12.0.hp),
                              child: GestureDetector(
                                onTap: () async {
                                  debugPrint('[UPLOAD-AVATAR]');

                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'jpeg',
                                    ],
                                  );

                                  if (result!.files.isEmpty) return;

                                  debugPrint(
                                      "${result.files[0].path} :: file path ");

                                  setState(() {
                                    newAvatar = true;
                                    avatar = result.files[0];
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: newAvatar
                                      ? AppStyles.bgBlack
                                      : AppStyles.bgBlue,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 12.0.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: userRepository.userData.value.isEmailLogin == true
                      ? Column(children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: AppStyles.bgBlack),
                              icon: Icon(Icons.email, color: AppStyles.bgGray),
                            ),
                          ),
                          SizedBox(height: 2.0.hp),
                          GestureDetector(
                            onTap: () async {
                              if (emailController.text.trim() == '') {
                                Get.snackbar(
                                  'Error',
                                  'Email is required.',
                                  colorText: Colors.white,
                                  backgroundColor:
                                      AppStyles.bgBlue.withOpacity(0.8),
                                );
                              }

                              Map formData = {
                                'email': emailController.text.trim(),
                                'avatar': newAvatar == true ? avatar : ''
                              };

                              // debugPrint('[PAYLOAD] :: $formData');
                              await authServices
                                  .updateProfileWithGoogleSigninController(
                                      formData);
                            },
                            child: Container(
                              height: 45,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: AppStyles.bgBlue,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomTextWidget(
                                      text: "Update Profile",
                                      color: Colors.white,
                                      size: 12.0.sp,
                                    ),
                                  ),
                                  // const Icon(
                                  //   Icons.edit,
                                  //   color: Colors.white,
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ])
                      : Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: AppStyles.bgBlack),
                                icon:
                                    Icon(Icons.email, color: AppStyles.bgGray),
                              ),
                            ),
                            SizedBox(height: 2.0.hp),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Current Password",
                                hintStyle: TextStyle(color: AppStyles.bgBlack),
                                icon: Icon(Icons.lock, color: AppStyles.bgGray),
                              ),
                            ),
                            SizedBox(height: 2.0.hp),
                            TextFormField(
                              obscureText: true,
                              controller: newPasswordController,
                              decoration: InputDecoration(
                                hintText: "New Password",
                                hintStyle: TextStyle(color: AppStyles.bgBlack),
                                icon: Icon(Icons.lock, color: AppStyles.bgGray),
                              ),
                            ),
                            SizedBox(height: 2.0.hp),
                            TextFormField(
                              obscureText: true,
                              controller: confirmNewPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(color: AppStyles.bgBlack),
                                icon: Icon(Icons.lock, color: AppStyles.bgGray),
                              ),
                            ),
                            SizedBox(height: 5.0.hp),
                            GestureDetector(
                              onTap: () async {
                                if (emailController.text.trim() == '') {
                                  Get.snackbar(
                                    'Error',
                                    'Email is required.',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppStyles.bgBlue.withOpacity(0.8),
                                  );
                                }

                                if (passwordController.text.trim() == '') {
                                  Get.snackbar(
                                    'Error',
                                    'Password is required.',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppStyles.bgBlue.withOpacity(0.8),
                                  );
                                }
                                if (newPasswordController.text.trim() != '' &&
                                    confirmNewPasswordController.text.trim() ==
                                        '') {
                                  Get.snackbar(
                                    'Error',
                                    'Passwords do not match.',
                                    colorText: Colors.white,
                                    backgroundColor:
                                        AppStyles.bgBlue.withOpacity(0.8),
                                  );
                                }

                                Map formData = {
                                  'email': emailController.text.trim(),
                                  'password': passwordController.text.trim(),
                                  'new_password':
                                      newPasswordController.text.trim(),
                                  'avatar': newAvatar == true ? avatar : ''
                                };

                                // debugPrint('[PAYLOAD] :: $formData');
                                await authServices
                                    .updateProfileController(formData);
                              },
                              child: Container(
                                height: 45,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: AppStyles.bgBlue,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomTextWidget(
                                        text: "Update Profile",
                                        color: Colors.white,
                                        size: 12.0.sp,
                                      ),
                                    ),
                                    // const Icon(
                                    //   Icons.edit,
                                    //   color: Colors.white,
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
