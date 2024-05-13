import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking/models/parking_lot.dart';

Future<List<ParkingLot>> fetchParkingLots(
    {int? limit, int? offset, Map<String, dynamic>? where}) async {
  String url = 'https://interview-apixx07.dev.park-depot.de/';

  String query = '''
    query ExampleQuery(\$limit: Int, \$offset: Int) {
      getAllParkingLots(limit: \$limit, offset: \$offset) {
        address
        id
        image
        live_date
        name
        size
        status
        type
      }
    }
  ''';

  Map<String, dynamic> variables = {
    'limit': limit,
    'offset': offset,
  };

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode({'query': query, 'variables': variables}),
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    List<ParkingLot> parkingLots =
        (jsonResponse['data']['getAllParkingLots'] as List)
            .map((parkingLotJson) => ParkingLot.fromJson(parkingLotJson))
            .toList();
    return parkingLots;
  } else {
    throw Exception(
        'Failed to fetch data: ${response.statusCode} ${response.body}');
  }
}
