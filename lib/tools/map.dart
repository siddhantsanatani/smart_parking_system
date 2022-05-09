import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'mapstate.dart';

class AppMap extends StatefulWidget {
  const AppMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppMap();
}

class _AppMap extends State<AppMap> {
  // final appState = AppState();
  final destination = TextFieldBloc();
  // late GoogleMapController mapController;
  // late CameraPosition lastPosition;
  // final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    // lastPosition = appState.lastPosition;
    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: appState.lastPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        compassEnabled: true,
        minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
        onMapCreated: (GoogleMapController controller) {
          appState.mapController = controller;
        },
        markers: appState.markers,
        onCameraMove: appState.onCameraMove,
        polylines: appState.polyLines,
      ),
    );
  }

  // void markerCreated(GoogleMapController controller) {
  //   setState(() {
  //     mapController = controller;
  //   });
  // }

  // void _onCameraMove(CameraPosition position) {
  //   setState(() {
  //     lastPosition = position;
  //   });
  // }

  // void _onAddMarkerPressed() {
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //           markerId: MarkerId(lastPosition.toString()),
  //           position: LatLng(
  //               lastPosition.target.latitude, lastPosition.target.longitude),
  //           infoWindow:
  //               const InfoWindow(title: 'Your Location', snippet: 'Park'),
  //           icon: BitmapDescriptor.defaultMarker),
  //     );
  //   });
  // }
}
