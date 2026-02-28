import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opassage/core/constants/constants.dart';
import 'package:opassage/models/rooms_model.dart';

class FavoriteService {
  static Future<Map<String, dynamic>> addFavorite({
    required int userId,
    required int roomId,
    required int hotelId,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrls.postFavoriteCreate),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'room_id': roomId,
        'hotel_id': hotelId,
      }),
    );

    return {'status': response.statusCode, 'body': jsonDecode(response.body)};
  }

  static Future<List<RoomsModel>> getFavorites(int userId) async {
    final response = await http.get(
      Uri.parse('${ApiUrls.getFavorite}$userId'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List data = body['data']['data']; // pagination

      return data.map((e) => RoomsModel.fromJson(e)).toList();
    } else {
      throw Exception('Erreur chargement favoris');
    }
  }

  /// Supprimer un favori
  static Future<bool> deleteFavorite(int userId, int roomId) async {
    final response = await http.delete(
      Uri.parse(ApiUrls.deleteFavorite),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "room_id": roomId}),
    );

    return response.statusCode == 200;
  }
}
