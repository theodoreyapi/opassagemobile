import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opassage/features/proprio/reservation/reservation.dart';
import 'package:opassage/features/proprio/scan/scan.dart';
import 'package:opassage/features/proprio/wallet/wallet.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/themes.dart';
import '../../home/home.dart';
import '../../profile/pages/pages.dart';

class MenuProprioPage extends StatefulWidget {
  const MenuProprioPage({super.key});

  @override
  State<MenuProprioPage> createState() => _MenuProprioPageState();
}

class _MenuProprioPageState extends State<MenuProprioPage> {
  int currentPageIndex = 0;

  final Widget _home = HomePageProprio();
  final Widget _invite = MesReservationsPage();
  final Widget _chat = ScanPage();
  final Widget _favoris = WalletPage();
  final Widget _profile = ProfileProprioScreen();

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
          _buildNavItem(Icons.article_outlined, "Commandes", 1),
          _buildNavItem(Icons.qr_code_scanner, "Scanner", 2),
          _buildNavItem(Icons.account_balance_wallet_outlined, "Mon wallet", 3),
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
