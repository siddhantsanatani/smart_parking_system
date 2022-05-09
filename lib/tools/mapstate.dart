import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_parking_system/services/storage_items.dart';

import '../services/storage.dart';

final SecureStorage secureStorage = SecureStorage();

var apiKey = secureStorage.writeSecureData(api);

class AppState with ChangeNotifier {
  late LatLng _initialPosition;
  late LatLng _lastPosition = _initialPosition;
  bool locationServiceActive = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  // final GoogleMapController _mapController;
  final MapsPolyline _mapsPolylines = MapsPolyline();
  static TextEditingController locationController = TextEditingController();
  static TextEditingController destinationController = TextEditingController();
  CameraPosition get initialPosition =>
      CameraPosition(target: _initialPosition, zoom: 16);
  CameraPosition get lastPosition => initialPosition;
  MapsPolyline get mapsPolylines => _mapsPolylines;
  late GoogleMapController mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;

  AppState() {
    getUserLocation();
  }

// ! TO GET THE USERS LOCATION
  void getUserLocation() async {
    try {
      if (await Permission.location.request().isGranted) {
        print("GET USER METHOD RUNNING =========");
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        _initialPosition = LatLng(position.latitude, position.longitude);
        notifyListeners();
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        _initialPosition = LatLng(position.latitude, position.longitude);
        List<Placemark> placemark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        locationController.text = placemark[0].name!;
        notifyListeners();
      }
    } catch (error) {
      print(error.toString());
    }
  }

  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 10,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.black));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) {
      lList[i] += lList[i - 2];
    }

    print(lList.toString());

    return lList;
  }

  // Send destination request
  void sendDestinationRequest(String destinationLocation) async {
    List<Location> destinationLocations =
        await locationFromAddress(destinationLocation);
    CameraPosition destination = CameraPosition(
        target: LatLng(destinationLocations[0].latitude,
            destinationLocations[0].longitude),
        zoom: 16);
    mapController.animateCamera(CameraUpdate.newCameraPosition(destination));
    notifyListeners();
  }

  // ! SEND Polyline REQUEST
  void sendPolyLineRequest(String intendedLocation) async {
    List<Location> locations = await locationFromAddress(intendedLocation);
    LatLng destination = LatLng(locations[0].latitude, locations[0].longitude);
    _addMarker(destination, intendedLocation);
    String route =
        await _mapsPolylines.getRouteCoordinates(_initialPosition, destination);
    createRoute(route);
    notifyListeners();
  }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    // _mapController.complete(controller);
    mapController = controller;
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(initialPosition));
    notifyListeners();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}

class MapsPolyline {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String urlPolyline =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(Uri.parse(urlPolyline));
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}

class MapsLocationRequest {
  Future<String> getPlaceCoordinates(LatLng l1) async {
    String urlPlace =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${l1.latitude},${l1.longitude}&region=in&key=$apiKey";
    http.Response response = await http.get(Uri.parse(urlPlace));
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}
