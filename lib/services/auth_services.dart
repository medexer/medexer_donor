// ignore_for_file: library_prefixes, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_null_comparison
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/database/user_repository.dart';

class AuthServices extends GetxController {
  final authStorage = GetStorage();
  final UserRepository userRepository = Get.find();


}
