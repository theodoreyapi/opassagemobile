import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_color.dart';
import '../profile.dart';

class ProfileProprioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 2.5.h),
            decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'assets/images/room1.png',
                  ), // Image de Jean Kouassi
                ),
                Gap(2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jean Kouassi",
                      style: TextStyle(
                        color: appColorSecond,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(1.w),
                    Row(
                      children: [
                        Icon(
                          Icons.star_outline_outlined,
                          color: appColorSecond,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Hôte",
                          style: TextStyle(color: appColorSecond, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(3.w),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  // Bannière de score (Violette)
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: Colors.purple[900],
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outlined,
                          color: appColorSecond,
                          size: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "Héberge les O'Passeurs dans ton établissement "
                            "et gagne des revenus en améliorant ton "
                            "taux d'occupation",
                            style: TextStyle(
                              color: appColorSecond,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Section MENU
                  _buildSectionTitle("MENU"),
                  _buildMenuItem(
                    Icons.assignment_outlined,
                    "Mes réservations confirmées",
                  ),
                  _buildMenuItem(Icons.wallet_outlined, "Mon wallet"),
                  _buildMenuItem(Icons.confirmation_number_outlined, "Incentives & Gestion client"),

                  SizedBox(height: 30),

                  // Section INFORMATIONS UTILES (Cartes horizontales)
                  _buildSectionTitle("INFORMATIONS UTILES"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildInfoCard(
                          icon: Icons.workspace_premium_outlined,
                          text:
                              "",
                          color: appColor, // Bleu-gris
                          iconColor: Colors.purple,
                        ),
                        SizedBox(width: 15),
                        _buildInfoCard(
                          icon: Icons.verified_user_outlined,
                          text:
                              "",
                          color: appColor, // Vert clair
                          iconColor: Colors.green,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Section ACCUEIL (Navigation technique)
                  _buildSectionTitle("ACCUEIL"),
                  _buildMenuItem(Icons.notifications_none, "Mes nouvelles commandes"),
                  _buildMenuItem(
                    Icons.access_time,
                    "Aides et gestion du compte",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HelpAndAccountScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.event_available_outlined, "Mes réservations fournies"),
                  _buildMenuItem(Icons.logout, "Déconnexion", isLogout: true),

                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : Colors.purple[800],
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isLogout ? Colors.red : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: onTap,
        ),
        Divider(height: 1, color: Colors.grey[200]),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String text,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
