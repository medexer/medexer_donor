import 'package:get/get.dart';
import 'package:medexer_donor/network_manager.dart';
class NetworkBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NetworkManageController>(() => NetworkManageController());
  }

}