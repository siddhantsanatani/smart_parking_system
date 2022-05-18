import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:smart_parking_system/externals/form_bloc-0.30.0/lib/form_bloc.dart';

import '../externals/form_bloc-0.30.0/form_bloc.dart';
import '../handler/mapfunctions.dart';

class AppMap extends StatefulWidget {
  const AppMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppMap();
}

class _AppMap extends State<AppMap> {
  final destination = TextFieldBloc();
  MapFunctions mapFunction = MapFunctions();
  //final Completer<GoogleMapController> _mapController = Completer();
  // late GoogleMapController mapController;
  // late CameraPosition lastPosition;

  @override
  Widget build(BuildContext context) {
    mapFunction = Provider.of<MapFunctions>(context);
    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: mapFunction.lastPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        compassEnabled: true,
        minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
        onMapCreated: mapFunction.onCreated,
        markers: Set<Marker>.of(mapFunction.markers),
        onCameraMove: mapFunction.onCameraMove,
        polylines: mapFunction.polyLines,
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

}
