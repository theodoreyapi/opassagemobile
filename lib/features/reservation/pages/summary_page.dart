import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/reservation/pages/reservation_confirm_page.dart';
import 'package:opassage/models/reservation_model.dart';

class ReservationSummaryScreen extends StatefulWidget {
  double? amount;
  String? promoCode;
  ReservationModel? residence;

  ReservationSummaryScreen({
    super.key,
    this.amount,
    this.promoCode,
    this.residence,
  });

  @override
  _ReservationSummaryScreenState createState() =>
      _ReservationSummaryScreenState();
}

class _ReservationSummaryScreenState extends State<ReservationSummaryScreen> {
  bool reserveForThirdParty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec Stepper personnalisé
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 40),
                // Pour centrer le titre par rapport au stepper
                Text(
                  "Résumé Réservation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildStepper(),
              ],
            ),
            SizedBox(height: 30),

            // Carte de la résidence
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/room1.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Résidence O'Passage",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Chambre standard, vue sur la ville",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          "Cocody, riviera 3",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              size: 16,
                              color: Colors.orange,
                            ),
                            Text(
                              " 4.9 (120 Avis)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            Text(
              "Détails du séjour",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            // Tableau des détails
            _buildDetailRow("Date", "10 Octobre 2025"),
            _buildDetailRow("Heure de début", "08:00"),
            _buildDetailRow("Heure de fin", "14:00"),
            _buildDetailRow("Durée totale", "1/2 journée (06H)"),
            _buildDetailRow("Prix Unitaire", "${widget.amount} ${widget.residence!.room!.hotel!.currency}"),

            // Ligne Coût Total avec fond bleu clair
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF4F7FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coût total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "25 000 FCFA",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Section Réserver pour un tiers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Réserver pour un tiers",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Souhaites-tu réserver pour une\nautre personne ?",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                CupertinoSwitch(
                  value: reserveForThirdParty,
                  activeTrackColor: appColorChoise,
                  onChanged: (val) =>
                      setState(() => reserveForThirdParty = val),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Formulaire bénéficiaire (Conditionnel)
            if (reserveForThirdParty) _buildBeneficiaryForm(),

            SizedBox(height: 30),

            SubmitButton(
              "Valider",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationConfirmeScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: appColorChoise,
          child: Text("1", style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        Container(width: 30, height: 2, color: appColorChoise),
        CircleAvatar(
          radius: 12,
          backgroundColor: appColorChoise,
          child: Text("2", style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Divider(height: 1),
      ],
    );
  }

  Widget _buildBeneficiaryForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Information du Bénéficiaire",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          _buildTextField("Nom & prénoms"),
          SizedBox(height: 12),
          _buildTextField(
            "Numéro de téléphone",
            icon: Icons.contact_phone_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {IconData? icon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: icon != null
            ? Icon(icon, color: appColorChoise, size: 20)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      ),
    );
  }
}
