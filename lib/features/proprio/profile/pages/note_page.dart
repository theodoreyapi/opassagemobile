import 'package:flutter/material.dart';

class RateAppScreen extends StatefulWidget {
  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Noter Votre application",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Illustration de l'étoile centrale
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDE7), // Jaune très pâle
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.star_border_rounded,
                    size: 80,
                    color: Colors.yellow[700],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Textes
            const Text(
              "Votre avis compte !",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Aimez-vous utiliser O’Passeur ? aidez-nous à nous\naméliorer en nous laissant vos avis",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 50),

            // Bouton App Store
            _buildStoreButton(
              logoPath: 'assets/app_store_logo.png', // À remplacer par votre asset
              title: "Download on the",
              storeName: "App Store",
              onTap: () {},
            ),

            const SizedBox(height: 20),

            // Bouton Google Play
            _buildStoreButton(
              logoPath: 'assets/google_play_logo.png', // À remplacer par votre asset
              title: "GET IT ON",
              storeName: "Google Play",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreButton({
    required String logoPath,
    required String title,
    required String storeName,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8EAF6)), // Bordure bleue très claire
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 120, // Largeur pour simuler le bloc logo + texte du store
          child: Row(
            children: [
              const Icon(Icons.apps, color: Colors.blueGrey), // Placeholder pour le logo
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey)),
                  Text(storeName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.blueGrey),
        onTap: onTap,
      ),
    );
  }
}