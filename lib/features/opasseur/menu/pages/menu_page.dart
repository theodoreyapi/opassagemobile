import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opassage/features/auth/auth.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/themes.dart';
import '../../../../core/utils/utils.dart';
import '../../favoris/favoris.dart';
import '../../history/history.dart';
import '../../home/home.dart';
import '../../profile/pages/pages.dart';
import '../../reservation/pages/pages.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentPageIndex = 0;

  /// Pages
  final Widget _home = HomePage();
  final Widget _invite = MyNewBookingsScreen();
  final Widget _chat = HistoryScreen();
  final Widget _favoris = FavoritesScreen();
  final Widget _profile = ProfileScreen();

  /// Pages protégées
  final List<int> protectedPages = [1, 2, 3, 4];

  /// Vérifier si connecté
  Future<bool> isLoggedIn() async {
    final userId = SharedPreferencesHelper().getInt('identifiant');
    return userId != null;
  }

  /// Gestion navigation
  Future<void> handleNavigation(int index) async {
    final loggedIn = await isLoggedIn();

    /// Si page protégée
    if (!loggedIn && protectedPages.contains(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez vous connecter"),
          backgroundColor: Colors.orange,
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
      return;
    }

    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body sécurisé
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: getBody(),
      ),

      /// Navigation bar
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        surfaceTintColor: appColor,
        indicatorColor: appColor.withValues(alpha: 0.15),
        selectedIndex: currentPageIndex,
        onDestinationSelected: handleNavigation,
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

  /// Body avec protection anti-contournement
  Widget getBody() {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final loggedIn = snapshot.data!;

        /// Sécurité si accès direct
        if (!loggedIn && protectedPages.contains(currentPageIndex)) {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return const SizedBox();
        }

        switch (currentPageIndex) {
          case 0:
            return _home;
          case 1:
            return _invite;
          case 2:
            return _chat;
          case 3:
            return _favoris;
          case 4:
            return _profile;
          default:
            return _home;
        }
      },
    );
  }
}
