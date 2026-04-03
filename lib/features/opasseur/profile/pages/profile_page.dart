import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

import '../profile.dart';

class ProfileScreen extends StatelessWidget {
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
          Gap(1.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bannière de score (Violette)
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.purple[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.report_problem_outlined,
                          color: Colors.orange,
                          size: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "Augmentez votre score en acceptant un de nos "
                            "hébergement et continuez de profiter "
                            "d'expériences inédites",
                            style: TextStyle(color: Colors.white, fontSize: 13),
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
                    "Mes nouvelles commandes",
                  ),
                  _buildMenuItem(Icons.history, "Historique"),
                  _buildMenuItem(Icons.favorite_border, "Mes Favoris"),

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
                              "Migrez vers un compte O'Passeur Prime et"
                                  " bénéficiez de nombreux avantages",
                          color: Color(0xFFDDE3F0), // Bleu-gris
                          iconColor: Colors.purple,
                        ),
                        SizedBox(width: 15),
                        _buildInfoCard(
                          icon: Icons.verified_user_outlined,
                          text:
                              "Migrez vers un compte O'Passeur Prime et "
                                  "bénéficiez de nombreux avantages",
                          color: Color(0xFFC8E6C9), // Vert clair
                          iconColor: Colors.green,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Section ACCUEIL (Navigation technique)
                  _buildSectionTitle("ACCUEIL"),
                  _buildMenuItem(
                    Icons.confirmation_number_outlined,
                    "Code promo et privilège",
                  ),
                  _buildMenuItem(Icons.notifications_none, "Notifications"),
                  _buildMenuItem(
                    Icons.access_time,
                    "Aides et gestion du compte",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HelpAndAccountScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.calendar_today_outlined, "Réservations"),
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
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
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
