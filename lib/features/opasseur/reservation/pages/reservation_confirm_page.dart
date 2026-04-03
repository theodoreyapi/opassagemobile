import 'package:flutter/material.dart';

class ReservationConfirmeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () {}),
        title: Text("Réservation Confirmée", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image et Titre
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/images/room1.png', height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 15),
            Text("Résidence O'Passage", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.purple),
                Text(" Cocody, riviera 3", style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            SizedBox(height: 20),

            // Bannière d'information jaune
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.notification_important_outlined, color: Colors.amber[600]),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Attend le jour/moment de ta réservation pour te rendre dans l'établissement et en profiter 😋",
                      style: TextStyle(color: Colors.amber[900], fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Grille récapitulative
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50]?.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoColumn("CATÉGORIE", "Court /long Séjour"),
                      _buildInfoColumn("TYPE", "Chambre Standard"),
                    ],
                  ),
                  Divider(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoColumn("DATE DE RÉSERVATION", "10 OCT. 2025"),
                      _buildInfoColumn("PÉRIODE", "1 NUIT"),
                    ],
                  ),
                  Divider(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoColumn("ARRIVÉE", "10 OCT. 14:00"),
                      _buildInfoColumn("DÉPART", "11 OCT. 12:00"),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("COÛT TOTAL", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                      Text("40 000 FCFA", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Section QR Code
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50]?.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Column(
                children: [
                  Icon(Icons.qr_code_2, size: 150, color: Colors.purple[700]), // Utilise CustomPainter ou une image pour un vrai QR
                  SizedBox(height: 10),
                  Text(
                    "Veuillez présenter ce code QR à la\nréception lors de votre arrivée",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.indigo[900], fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Boutons d'action circulaires
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.directions_car, "Je suis en route"),
                _buildActionButton(Icons.phone, "Joindre l'hôte"),
                _buildActionButton(Icons.near_me, "Je m'oriente"),
              ],
            ),
            SizedBox(height: 30),

            // Bouton Annuler
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.purple),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined, color: Colors.purple),
                  SizedBox(width: 8),
                  Text("Annuler la réservation", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blueGrey[900])),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.purple[700],
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.indigo[900], fontWeight: FontWeight.w500)),
      ],
    );
  }
}