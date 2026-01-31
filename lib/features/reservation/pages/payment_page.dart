import 'package:flutter/material.dart';
import 'package:opassage/features/reservation/pages/summary_page.dart';

class PaymentMethodScreen extends StatelessWidget {
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
              logo: 'assets/wave_logo.png', // Remplacez par vos assets
              title: "Wave",
              subtitle: "Paiement rapide",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationSummaryScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 15),
            _buildPaymentOption(
              logo: 'assets/djamo_logo.png', // Remplacez par vos assets
              title: "Djamo",
              subtitle: "Paiement Mobile Money",
              onTap: () {},
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
        border: Border.all(color: Colors.blue.withOpacity(0.15), width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          // Utilisez Image.asset ou Icon selon vos ressources
          child: Icon(Icons.account_balance_wallet, color: Colors.blue),
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
}
