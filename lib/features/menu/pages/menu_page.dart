import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opassage/features/favoris/favoris.dart';
import 'package:opassage/features/history/history.dart';
import 'package:opassage/features/home/home.dart';
import 'package:opassage/features/profile/pages/pages.dart';
import 'package:opassage/features/reservation/pages/reservation_page.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentPageIndex = 0;

  final Widget _home = HomePage();
  final Widget _invite = MyNewBookingsScreen();
  final Widget _chat = HistoryScreen();
  final Widget _favoris = FavoritesScreen();
  final Widget _profile = ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: getBody(),
      ),

      /// Navigation bar
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        surfaceTintColor: appColor,
        indicatorColor: appColor.withValues(alpha: 0.15),
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          _buildNavItem(Icons.home_outlined, "Accueil", 0),
          _buildNavItem(Icons.assignment_outlined, "Réservations", 1),
          _buildNavItem(Icons.history_outlined, "Historique", 2),
          _buildNavItem(Icons.favorite_outline, "Favoris", 3),
          _buildNavItem(Icons.person_outline, "Profil", 4),
        ],
      ),
    );
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentPageIndex == index;
    return NavigationDestination(
      icon: Icon(
        icon,
        color: isSelected ? appColor : appColorBlack.withValues(alpha: 0.5),
        size: 24,
      ),
      label: label,
    );
  }

  Widget getBody() {
    if (currentPageIndex == 0) {
      return _home;
    } else if (currentPageIndex == 1) {
      return _invite;
    } else if (currentPageIndex == 2) {
      return _chat;
    } else if (currentPageIndex == 3) {
      return _favoris;
    } else {
      return _profile;
    }
  }
}
