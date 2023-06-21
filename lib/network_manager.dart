
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
class NetworkManageController extends GetxController{

  var connectionType = 0.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  
  @override
  void onInit(){
    super.onInit();
    GetConniectionType();
    _streamSubscription=_connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void>GetConniectionType()async{
    var connectivityResult;

    try{
      connectivityResult=await _connectivity.checkConnectivity();
    }on PlatformException catch(e){
      print(e); 

    }
      return _updateState(connectivityResult);
  }
  _updateState(ConnectivityResult result){
    
    switch(result){
      case ConnectivityResult.wifi:
        connectionType.value=1;
        update();
        break;
        
      case ConnectivityResult.mobile:
        connectionType.value=2;
        update();
        break;
      case ConnectivityResult.none:
          connectionType.value=0;
          update();
          break;
          default:Get.snackbar("NETWORK ERROR ", 'OUT OF REACH');
          break;
    }
  }
  @override
  void onClosed(){
    _streamSubscription.cancel();
  }

}