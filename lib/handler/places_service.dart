import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:smart_parking_system/handler/search_model.dart';
import '../dataStorage/storage_items.dart';

final apiKeyRead = storageRefresh();

class PlacesService {
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$apiKeyRead';
    http.Response response =
        await http.get(Uri.parse(url)); //await http.get(Uri.parse(urlPolyline))
    var json = convert.jsonDecode(response.body);
    print("respons:$json");
    var jsonResults = json['predictions'] as List;
    print("jsons:$jsonResults");
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKeyRead';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(
      double lat, double lng, String placeType) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$apiKeyRead';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
