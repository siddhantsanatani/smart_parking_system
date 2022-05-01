import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocation {
  Future<LatLng> getLocation() async {
    // try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    LatLng currentPosition = LatLng(position.latitude, position.longitude);
    return currentPosition;
    // } catch (e) {
    //   print(e);
    //   return currentPosition = const LatLng(0, 0);
    // }
  }
}
