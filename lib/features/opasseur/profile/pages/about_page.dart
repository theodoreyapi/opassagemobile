import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
          "À propos",
          style: TextStyle(
            fontSize: 24,
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
          crossAxisAlignment: .center,
          children: [
            Gap(2.h),
            // Bannière Gradient "Ce que tu dois savoir"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: Text(
                "Ce que tu dois savoir sur ton appli",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appColorSecond,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Liste des options
            _buildAboutItem(Icons.balance, "Mentions légales"),
            _buildAboutItem(Icons.verified_user_outlined, "Politiques de confidentialités"),
            _buildAboutItem(Icons.list_alt_rounded, "Conditions générales d’utilisation"),
            _buildAboutItem(Icons.error_outline, "Note ton application"),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: appColorSecond.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: ListTile(
        leading: Icon(icon, color: appColor, size: 22),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: appColor,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
