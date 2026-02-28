import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opassage/core/constants/constants.dart';
import 'package:opassage/models/reservation_model.dart';

class ReservationService {
  static Future<Map<String, dynamic>> createReservation({
    required int userId,
    required int roomId,
    required String start,
    required String end,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrls.postReservationCreate),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'room_id': roomId,
        'start_date': start,
        'end_date': end,
        'promo_code': "",
      }),
    );

    return {'status': response.statusCode, 'body': jsonDecode(response.body)};
  }

  Future<List<ReservationModel>> fetchReservations(int userId) async {
    final response = await http.get(
      Uri.parse('${ApiUrls.getReservation}$userId'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      if (body['success'] == true) {
        final List<dynamic> data = body['data'];
        print(data);
        return data.map((e) => ReservationModel.fromJson(e)).toList();
      }
      throw Exception('Réponse API invalide');
    }
    throw Exception('Erreur HTTP ${response.statusCode}');
  }
}
