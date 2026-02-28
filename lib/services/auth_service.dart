import 'package:http/http.dart' as http;
import 'package:opassage/core/constants/constants.dart';

class AuthApi {
  static Future<http.Response> registerOne(String body) async {
    return http.post(
      Uri.parse(ApiUrls.postAuthRegisterOne),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  static Future<http.Response> verifyOtp(String body) async {
    return http.post(
      Uri.parse(ApiUrls.postAuthVerifOtp),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  static Future<http.Response> resendOtp(String body) async {
    return http.post(
      Uri.parse(ApiUrls.postAuthResend),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }
}
