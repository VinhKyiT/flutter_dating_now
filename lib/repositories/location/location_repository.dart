import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../models/models.dart';
import 'base_location_repository.dart';

class LocationRepository extends BaseLocationRepository {
  final String key = 'AIzaSyCOpv8L34cuVxiiZgIpNGoqbdON_1Xb6Fs';
  final String types = 'geocode';

  @override
  Future<Location> getLocation(String location) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=place_id%2Cname%2Cgeometry&input=$location&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['candidates'][0] as Map<String, dynamic>;
    return Location.fromJson(results);
  }
}
