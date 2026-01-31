import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Titre principal
            const Text(
              "Nous contacter",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),

            // Description
            Text(
              "Vous pouvez nous appeler si vous\nrencontrez un problème ou pour tout autre\nbesoin",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 40),

            // Illustration centrale (Image de l'opératrice)
            // Utilise un CircleAvatar ou un Container circulaire pour l'effet de fond
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF6), // Bleu très clair/lavande pour le fond
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  'https://placeholder.com/contact_illustration', // Remplace par ton asset
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 60),

            // Bouton Appeler
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logique pour lancer l'appel
                },
                icon: const Icon(Icons.phone_in_talk, color: Color(0xFF1A237E)),
                label: const Text(
                  "Appeler le service client",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700), // Jaune
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Bouton Email
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logique pour envoyer un email
                },
                icon: const Icon(Icons.mail_outline, color: Colors.white),
                label: const Text(
                  "Envoyez un email",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C27B0), // Violet
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}