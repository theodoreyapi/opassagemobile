import 'package:flutter/material.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

class ContactUsScreen extends StatelessWidget {
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
          "Nous contacter",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            // Description
            Text(
              "Tu peux nous appeler, si tu rencontres une difficulté "
              "ou si tu veux nous aider a améliorer le service.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: appColor, height: 1.4),
            ),

            Spacer(),

            // Illustration centrale (Image de l'opératrice)
            // Utilise un CircleAvatar ou un Container circulaire pour l'effet de fond
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: appColor,
                // Bleu très clair/lavande pour le fond
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  'https://placeholder.com/contact_illustration',
                  // Remplace par ton asset
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Spacer(),

            // Bouton Appeler
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logique pour lancer l'appel
                },
                icon: Icon(Icons.phone_in_talk, color: appColorSecond),
                label: Text(
                  "Appeler le service client",
                  style: TextStyle(
                    color: appColorSecond,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor, // Jaune
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
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
                icon: Icon(Icons.mail_outline, color: appColorSecond),
                label: Text(
                  "Envoyez un email",
                  style: TextStyle(
                    color: appColorSecond,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor, // Violet
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
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
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: appColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                ),
                child: Text(
                  "Contactez le service client par whatsApp",
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Bouton Email
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Logique pour envoyer un email
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Signaler un bug",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}