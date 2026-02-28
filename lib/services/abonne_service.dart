import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:opassage/core/constants/constants.dart';

import '../models/abonnement_model.dart';

class SubscriptionApi {
  static Future<List<AbonnementModel>> fetchSubscriptions() async {
    HttpClient().badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    final response = await http.get(
      Uri.parse(ApiUrls.getSubscriptionsAll),
      headers: {'Content-Type': 'application/json'},
    );

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200 && decoded['success'] == true) {
      return (decoded['data'] as List)
          .map((e) => AbonnementModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Erreur chargement abonnements");
    }
  }
}
