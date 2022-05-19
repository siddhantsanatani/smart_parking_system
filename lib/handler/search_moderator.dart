import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_parking_system/handler/mapfunctions.dart';
import 'package:smart_parking_system/handler/markers.dart';
import 'package:smart_parking_system/handler/places_service.dart';
import 'package:smart_parking_system/handler/search_model.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = MapFunctions();
  final placesService = PlacesService();
  final markerService = MarkerService();

  //Variables
  late LatLng location;
  late Position? currentLocation;
  late List<PlaceSearch>? searchResults = [];
  late StreamController<Place>? selectedLocation =
      StreamController<Place>.broadcast();
  late StreamController<LatLngBounds>? bounds =
      StreamController<LatLngBounds>.broadcast();
  late Place selectedLocationStatic;
  late String? placeType = '';
  late List<Place> placeResults = [];
  late List<Marker> markers = [];

  // ApplicationBloc() {
  //   setCurrentLocation();
  // }

  // setCurrentLocation() async {
  //   location = await geoLocatorService.getCurrentLocation();
  //   currentLocation = geoLocatorService.position;
  //   selectedLocationStatic = Place(
  //     name: '',
  //     vicinity: "",
  //     geometry: Geometry(
  //       location: Location(lat: location.latitude, lng: location.longitude),
  //     ),
  //   );
  //   notifyListeners();
  // }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  // setSelectedLocation(String placeId) async {
  //   var sLocation = await placesService.getPlace(placeId);
  //   selectedLocation!.add(sLocation);
  //   selectedLocationStatic = sLocation;
  //   searchResults = null;
  //   notifyListeners();
  // }

  // clearSelectedLocation() {
  //   //selectedLocation!.add(null);
  //   //selectedLocationStatic= null;
  //   searchResults = null;
  //   placeType = null;
  //   notifyListeners();
  // }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }

    if (placeType != null) {
      var places = await placesService.getPlaces(
          selectedLocationStatic.geometry!.location.lat,
          selectedLocationStatic.geometry!.location.lng,
          placeType!);
      markers = [];
      if (places.isNotEmpty) {
        var newMarker = markerService.createMarkerFromPlace(places[0], false);
        markers.add(newMarker);
      }

      var locationMarker =
          markerService.createMarkerFromPlace(selectedLocationStatic, true);
      markers.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds!.add(_bounds!);

      notifyListeners();
    }
  }

  @override
  void dispose() {
    selectedLocation!.close();
    bounds!.close();
    super.dispose();
  }
}
