import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opassage/core/constants/constants.dart';
import 'package:opassage/core/utils/utils.dart';
import 'package:opassage/features/reservation/pages/summary_page.dart';
import 'package:opassage/features/reservation/reservation.dart';
import 'package:opassage/models/reservation_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentMethodScreen extends StatefulWidget {
  double? amount;
  String? promoCode;
  ReservationModel? residence;

  PaymentMethodScreen({super.key, this.amount, this.promoCode, this.residence});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Paiement",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              "Moyen de paiement",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Je choisi comment je désire\npayer ma réservation",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.2,
              ),
            ),
            SizedBox(height: 30),

            // Liste des moyens de paiement
            _buildPaymentOption(
              logo: 'assets/images/wave.png', // Remplacez par vos assets
              title: "Wave",
              subtitle: "Paiement rapide",
              onTap: payWithWave,
            ),
            SizedBox(height: 15),
            _buildPaymentOption(
              logo: 'assets/images/djamo.jpg', // Remplacez par vos assets
              title: "Djamo",
              subtitle: "Paiement Mobile Money",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationSummaryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String logo,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC), // Fond très légèrement teinté
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: ClipOval(
          // Utilisez Image.asset ou Icon selon vos ressources
          child: Image.asset(logo),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }

  Future<void> payWithWave() async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.postReservationPaymentInitial),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'reservation_id': widget.residence!.idReservation,
          'deposit_amount': widget.amount,
          'payment_method': 'wave',
        }),
      );

      final data = jsonDecode(response.body);

      print(response.statusCode);
      debugPrint(data);

      if (response.statusCode == 200 && data['success'] == true) {
        final url = data['payment_url'];
        final paymentId = data['payment_id'];

        await SharedPreferencesHelper().saveDouble('amount', widget.amount!);
        await SharedPreferencesHelper().saveString(
          'promoCode',
          widget.promoCode ?? '',
        );
        await SharedPreferencesHelper().saveString(
          'residence',
          jsonEncode(widget.residence!.toJson()),
        );

        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

        Navigator.pushNamed(context, '/payment-waiting', arguments: paymentId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Paiement échoué')),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erreur réseau')));
    }
  }
}
