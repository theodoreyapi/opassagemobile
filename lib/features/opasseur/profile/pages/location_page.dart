import 'package:flutter/material.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Ou nous trouver ?",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tu peux te rendre chez O’Passage pour un quelconque besoin ?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: appColor, height: 1.4),
            ),

            const SizedBox(height: 30),

            // Aperçu de la Carte (Google Maps Image)
            ClipRRect(
              borderRadius: BorderRadius.circular(3.w),
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Image.network(
                  'https://placeholder.com/map_static_view',
                  // Remplace par ton asset ou URL
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Carte d'adresse
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: Row(
                children: [
                  // Icône de localisation circulaire
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: appColorSecond,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.location_on, color: appColor, size: 28),
                  ),
                  const SizedBox(width: 15),
                  // Détails de l'adresse
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "O’passage",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: appColorSecond, // Bleu indigo
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Cocody, Riviera palmeraie, Abidjan, Côte D’ivoire",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Bouton "C'est par ici"
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Logique pour ouvrir Google Maps ici
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "C’est par ici",
                      style: TextStyle(
                        color: appColorSecond,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.near_me, color: appColorSecond, size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
