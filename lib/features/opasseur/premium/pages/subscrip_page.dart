import 'package:flutter/material.dart';

class SubscriptionSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond violet qui recouvre tout l'écran
      backgroundColor: const Color(0xFF9C27B0),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // S'adapte au contenu
            children: [
              const SizedBox(height: 20),

              // Icône de validation dorée
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDE7), // Jaune très clair
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Forme de badge étoilé (simplifié avec une icône)
                      Icon(Icons.verified, size: 80, color: Colors.yellow[700]),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Félicitations !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Votre abonnement O'passeur\nPremium est maintenant actif.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 30),

              // Tableau récapitulatif
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[50]!),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow("Formule choisie", "Mensuelle", isBoldValue: true),
                    const Divider(height: 25),
                    _buildSummaryRow("Période", "25 oct 24 Nov", isBoldValue: true),
                    const Divider(height: 25),
                    _buildSummaryRow("Montant payé", "2000 FCFA",
                        isBoldValue: true,
                        valueColor: const Color(0xFF9C27B0)),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Bouton Terminer
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700), // Jaune vif
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Terminer",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBoldValue = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}