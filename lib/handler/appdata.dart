import 'package:flutter/cupertino.dart';
import 'package:smart_parking_system/dataStorage/userAddress.dart';

class AppData extends ChangeNotifier {
  late UserAddress userAddress;
  void updateUserLocation(UserAddress usrAddress) {
    userAddress = usrAddress;
    notifyListeners();
  }
}
