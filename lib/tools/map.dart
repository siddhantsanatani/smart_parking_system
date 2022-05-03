import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '/design_system/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'card.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'mapstate.dart';

class AppMap extends StatefulWidget {
  const AppMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppMap();
}

class _AppMap extends State<AppMap> {
  final appState = AppState();
  final destination = TextFieldBloc();
  late GoogleMapController mapController;
  late LatLng lastPosition;
  final Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    lastPosition = appState.lastPosition;
    return SafeArea(
      child: appState.initialPosition == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SpinKitRotatingCircle(
                      color: Colors.black,
                      size: 50.0,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: appState.locationServiceActive == false,
                  child: const Text(
                    "Please enable location services!",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                )
              ],
            )
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: lastPosition, zoom: 10),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              compassEnabled: true,
              onMapCreated: appState.onCreated,
              markers: appState.markers,
              onCameraMove: appState.onCameraMove,
              polylines: appState.polyLines,
            ),
    );
  }

  void markerCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      lastPosition = position.target;
    });
  }

  void _onAddMarkerPressed() {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(lastPosition.toString()),
            position: lastPosition,
            infoWindow:
                const InfoWindow(title: 'Your Location', snippet: 'Park'),
            icon: BitmapDescriptor.defaultMarker),
      );
    });
  }
}
