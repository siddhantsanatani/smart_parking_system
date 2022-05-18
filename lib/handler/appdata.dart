import 'package:flutter/cupertino.dart';
import 'package:smart_parking_system/dataStorage/user_address.dart';

class AppData extends ChangeNotifier {
  late UserAddress userAddress;
  void updateUserLocation(UserAddress usrAddress) {
    userAddress = usrAddress;
    notifyListeners();
  }
}
