import 'dart:async';
import 'dart:convert';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:opassage/core/utils/utils.dart';
import 'package:opassage/models/reservation_model.dart';
import 'package:opassage/services/payment_service.dart';

// ✅ Import du navigatorKey global — NE PAS le redéclarer ici
import 'package:opassage/main.dart' show navigatorKey;

class PaymentWaitingScreen extends StatefulWidget {
  final int paymentId;

  const PaymentWaitingScreen({super.key, required this.paymentId});

  @override
  State<PaymentWaitingScreen> createState() => _PaymentWaitingScreenState();
}

class _PaymentWaitingScreenState extends State<PaymentWaitingScreen> {
  Timer? _timer;
  StreamSubscription? _linkSub;

  @override
  void initState() {
    super.initState();
    _listenDeepLink(); // ✅ Écoute le deep link EN PRIORITÉ
    _startPolling();   // ✅ Polling en backup
  }

  /// Écoute le deep link opassage://payment/success ou /error
  /// C'est la voie principale de retour depuis la page web
  void _listenDeepLink() {
    _linkSub = AppLinks().uriLinkStream.listen((Uri uri) {
      debugPrint('DeepLink sur PaymentWaiting: $uri');
      if (!mounted) return;

      if (uri.host == 'payment') {
        _timer?.cancel();

        if (uri.path == '/success') {
          _navigateToSuccess();
        } else if (uri.path == '/error') {
          Navigator.pushReplacementNamed(context, '/payment-error');
        }
      }
    });
  }

  /// Polling en backup si le deep link n'arrive pas (ex: Android WebView)
  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final result = await PaymentService.checkPaymentStatus(widget.paymentId);
        final status = result['data']['status'];

        debugPrint('Polling status: $status');

        if (status == 'success') {
          // ✅ 'paid' correspond à ce que tu mets en BDD
          timer.cancel();
          if (mounted) _navigateToSuccess();
        } else if (status == 'failed') {
          timer.cancel();
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/payment-error');
          }
        }
        // Si 'pending' → on continue à attendre
      } catch (e) {
        debugPrint('Polling error: $e');
        // On ne redirige pas en erreur, on réessaie au prochain tick
      }
    });
  }

  void _navigateToSuccess() {
    final amount = SharedPreferencesHelper().getDouble('amount');
    final promoCode = SharedPreferencesHelper().getString('promoCode');
    final residenceJson = SharedPreferencesHelper().getString('residence');

    if (residenceJson == null) {
      // Fallback si pas de données en cache
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/reservation-confirmed',
            (route) => false,
      );
      return;
    }

    final residence = ReservationModel.fromJson(jsonDecode(residenceJson));

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/payment-success',
          (route) => false,
      arguments: {
        'amount': amount,
        'promoCode': promoCode,
        'residence': residence,
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text(
              "Vérification du paiement…",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              "Veuillez patienter",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),
            // ✅ Bouton de secours si l'utilisateur est bloqué
            TextButton(
              onPressed: () {
                _timer?.cancel();
                Navigator.pushReplacementNamed(context, '/payment-error');
              },
              child: Text(
                "Annuler",
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}