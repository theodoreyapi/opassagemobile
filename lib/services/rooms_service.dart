import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opassage/core/constants/constants.dart';
import '../models/rooms_model.dart';

class RoomsService {

  static Future<List<RoomsModel>> fetchRooms() async {
    final response = await http.get(Uri.parse(ApiUrls.getRoomAll));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final List list = body['data']['data']; // pagination Laravel
      return list.map((e) => RoomsModel.fromJson(e)).toList();
    } else {
      throw Exception('Erreur chargement rooms');
    }
  }
}