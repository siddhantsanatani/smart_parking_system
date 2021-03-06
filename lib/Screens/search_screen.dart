import 'dart:async';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking_system/tools/searchbar.dart';

import '../handler/search_model.dart';
import '../handler/search_moderator.dart';

class SearchScreen extends StatefulWidget {
  static String id = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  late StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation!.stream.listen((place) {
      // ignore: unnecessary_null_comparison
      if (place != null) {
        _locationController.text = place.name!;
        _goToPlace(place);
      } else {
        _locationController.text = "";
      }
    });

    applicationBloc.bounds!.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

  @override
  void dispose() {
    // final applicationBloc =
    //     Provider.of<ApplicationBloc>(context, listen: false);
    // applicationBloc.dispose();
    // _locationController.dispose();
    // locationSubscription.cancel();
    // boundsSubscription.cancel();
    //dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        body: ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              autofocus: true,
            )),
        Stack(
          children: [
            if (applicationBloc.searchResults != null &&
                applicationBloc.searchResults!.isNotEmpty)
              Container(
                  height: 300.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      backgroundBlendMode: BlendMode.darken)),
            if (applicationBloc.searchResults != null)
              SizedBox(
                height: 300.0,
                child: ListView.builder(
                    itemCount: applicationBloc.searchResults!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          applicationBloc.searchResults![index].description!,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          // applicationBloc.setSelectedLocation(
                          //     applicationBloc.searchResults![index].placeId!);
                        },
                      );
                    }),
              ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Find Nearest',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            children: [
              FilterChip(
                label: const Text('Campground'),
                onSelected: (val) =>
                    applicationBloc.togglePlaceType('campground', val),
                selected: applicationBloc.placeType == 'campground',
                selectedColor: Colors.blue,
              ),
              FilterChip(
                  label: const Text('Locksmith'),
                  onSelected: (val) =>
                      applicationBloc.togglePlaceType('locksmith', val),
                  selected: applicationBloc.placeType == 'locksmith',
                  selectedColor: Colors.blue),
              FilterChip(
                  label: const Text('Pharmacy'),
                  onSelected: (val) =>
                      applicationBloc.togglePlaceType('pharmacy', val),
                  selected: applicationBloc.placeType == 'pharmacy',
                  selectedColor: Colors.blue),
              FilterChip(
                  label: const Text('Pet Store'),
                  onSelected: (val) =>
                      applicationBloc.togglePlaceType('pet_store', val),
                  selected: applicationBloc.placeType == 'pet_store',
                  selectedColor: Colors.blue),
              FilterChip(
                  label: const Text('Lawyer'),
                  onSelected: (val) =>
                      applicationBloc.togglePlaceType('lawyer', val),
                  selected: applicationBloc.placeType == 'lawyer',
                  selectedColor: Colors.blue),
              FilterChip(
                  label: const Text('Bank'),
                  onSelected: (val) =>
                      applicationBloc.togglePlaceType('bank', val),
                  selected: applicationBloc.placeType == 'bank',
                  selectedColor: Colors.blue),
            ],
          ),
        )
      ],
    ));
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry!.location.lat, place.geometry!.location.lng),
            zoom: 14.0),
      ),
    );
  }
}
