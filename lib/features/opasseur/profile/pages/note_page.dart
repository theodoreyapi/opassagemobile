import 'package:flutter/material.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

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
          icon: Icon(Icons.arrow_back, color: appColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Noter ton application",
          style: TextStyle(
            color: appColor,
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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: appColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.star_border_rounded,
                    size: 80,
                    color: appColorSecond,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Textes
            Text(
              "Ton avis compte !",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Aimez-vous utiliser O’Passeur? aides nous à nous améliorer "
              "en nous laissant vos avis stp",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: appColor, height: 1.4),
            ),

            const SizedBox(height: 50),

            // Bouton App Store
            _buildStoreButton(
              // À remplacer par votre asset
              title: "Download on the",
              storeName: "App Store",
              onTap: () {},
            ),

            const SizedBox(height: 20),

            // Bouton Google Play
            _buildStoreButton(
              // À remplacer par votre asset
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
    required String title,
    required String storeName,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: appColorSecond.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Row(
          children: [
            Icon(Icons.apps, color: appColor),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 9, color: appColor)),
                Text(
                  storeName,
                  style: TextStyle(
                    fontSize: 16,
                    color: appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: appColor),
        onTap: onTap,
      ),
    );
  }
}