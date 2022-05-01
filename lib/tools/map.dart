import 'package:flutter/material.dart';
import '/design_system/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'card.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AppMap extends StatefulWidget {
  const AppMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppMap();
}

class _AppMap extends State<AppMap> {
  final destination = TextFieldBloc();
  late GoogleMapController mapController;
  static const _initialPosition = LatLng(22.236151, 84.884857);
  LatLng lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: lastPosition, zoom: 10),
      onMapCreated: markerCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      compassEnabled: true,
      markers: _markers,
      onCameraMove: _onCameraMove,
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
