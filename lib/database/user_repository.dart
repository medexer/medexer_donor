// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

import '../models/user_model.dart';

class UserRepository extends GetxController {
  var userData = UserModel.fromJson({}).obs;
}
