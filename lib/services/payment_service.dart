import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<Map<String, dynamic>> checkPaymentStatus(int paymentId) async {
    final response = await http.get(
      Uri.parse(
        'https://opassage.sodalite-consulting.com/api/reservations/payments/$paymentId',
      ),
      headers: {'Accept': 'application/json'},
    );

    return jsonDecode(response.body);
  }
}
