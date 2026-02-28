import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opassage/core/constants/constants.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/reservation/pages/payment_page.dart';
import 'package:opassage/models/reservation_model.dart';
import 'package:sizer/sizer.dart';

class ReservationDetailScreen extends StatefulWidget {
  ReservationModel? reserve;

  ReservationDetailScreen({super.key, this.reserve});

  @override
  State<ReservationDetailScreen> createState() =>
      _ReservationDetailScreenState();
}

class _ReservationDetailScreenState extends State<ReservationDetailScreen> {
  final TextEditingController promoController = TextEditingController();

  bool isCheckingPromo = false;
  String? promoError;
  double discountAmount = 0;
  Map<String, dynamic>? promoData;

  double get totalPrice => double.parse(widget.reserve!.totalPrice!);

  double get finalPrice => totalPrice - discountAmount;

  String get duration {
    final start = DateTime.parse(widget.reserve!.startDate!);
    final end = DateTime.parse(widget.reserve!.endDate!);

    final diff = end.difference(start).inHours;
    return "$diff Heures";
  }

  double get deposit => finalPrice * 0.5;

  Future<void> checkPromoCode() async {
    if (promoController.text.isEmpty) return;

    setState(() {
      isCheckingPromo = true;
      promoError = null;
      discountAmount = 0;
    });

    final url = Uri.parse('${ApiUrls.getPromoCheck}${promoController.text}');

    try {
      final response = await http.get(url);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        promoData = data['data'];

        if (promoData!['discount_type'] == 'percentage') {
          discountAmount = (totalPrice * promoData!['discount_value']) / 100;
        } else {
          discountAmount = promoData!['discount_value'].toDouble();
        }

        // Sécurité
        if (discountAmount > totalPrice) {
          discountAmount = totalPrice;
        }
      } else {
        promoError = data['message'];
      }
    } catch (e) {
      promoError = "Erreur de connexion";
    }

    setState(() {
      isCheckingPromo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Nouvelle commande",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image principale
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.reserve!.room!.firstImage ?? '',
                fit: BoxFit.cover,
                height: 50.w,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.hotel, size: 40),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Titre et Localisation
            Text(
              widget.reserve!.room!.name!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                Text(
                  widget.reserve!.room!.hotel!.address!,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Bannière de statut (Violette)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Réservation acceptée, merci de payer pour confirmer (Délai : 3 min)",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Grille de détails
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50]?.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                children: [
                  _buildDetailItem("DATE", widget.reserve!.startDate!),
                  _buildDetailItem("DURÉE", duration),
                  _buildDetailItem(
                    "HEURE",
                    "${widget.reserve!.room!.hotel!.checkInTime} - ${widget.reserve!.room!.hotel!.checkOutTime}",
                  ),
                  _buildDetailItem(
                    "TARIF HORAIRE",
                    "${widget.reserve!.room!.pricePerNight} ${widget.reserve!.room!.hotel!.currency}/J",
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            // Section Code Promo
            Text(
              "Code de réduction",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promoController,
                    decoration: InputDecoration(
                      hintText: "Entrez votre code",
                      errorText: promoError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: isCheckingPromo
                      ? CircularProgressIndicator()
                      : Icon(Icons.check, color: Colors.blue),
                  onPressed: checkPromoCode,
                ),
              ],
            ),
            SizedBox(height: 30),

            _buildPriceRow(
              "Coût initial",
              "$totalPrice ${widget.reserve!.room!.hotel!.currency}",
              isBold: false,
            ),

            if (discountAmount > 0)
              _buildPriceRow(
                "Réduction",
                "- $discountAmount ${widget.reserve!.room!.hotel!.currency}",
                isBold: false,
                color: Colors.green,
              ),

            _buildPriceRow(
              "Total à payer",
              "$finalPrice ${widget.reserve!.room!.hotel!.currency}",
              isBold: true,
              color: Colors.purple,
            ),

            _buildPriceRow(
              "Acompte (50%)",
              "$deposit ${widget.reserve!.room!.hotel!.currency}",
              isBold: true,
            ),

            SizedBox(height: 30),

            widget.reserve!.status! == 'confirmed'
                ? SubmitButton(
                    "Payer $deposit ${widget.reserve!.room!.hotel!.currency}",
                    onPressed: finalPrice <= 0
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentMethodScreen(
                                  amount: deposit,
                                  promoCode: promoController.text,
                                  residence: widget.reserve,
                                ),
                              ),
                            );
                          },
                  )
                : SizedBox.shrink(),

            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildSecondaryButton("Modifier")),
                SizedBox(width: 10),
                Expanded(child: _buildSecondaryButton("Annuler")),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Supprimer la réservation",
                  style: TextStyle(color: Colors.blue[300]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget d'aide pour les lignes de prix
  Widget _buildPriceRow(
    String label,
    String price, {
    required bool isBold,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Widget d'aide pour les items de détails
  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Widget pour les boutons blancs
  Widget _buildSecondaryButton(String text) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue[100]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: TextStyle(color: Colors.blue[300])),
    );
  }
}
