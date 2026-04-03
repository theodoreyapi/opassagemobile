import 'package:flutter/material.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

import '../profile.dart';

class HelpAndAccountScreen extends StatelessWidget {
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
          "Aide et gestion de compte",
          style: TextStyle(
            color: appColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("AIDE"),
            _buildActionGroup([
              _buildListTile(
                Icons.location_on_outlined,
                "Où nous trouver ?",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LocationScreen()),
                  );
                },
              ),
              _buildListTile(
                Icons.phone_in_talk_outlined,
                "Nous contacter",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ContactUsScreen()),
                  );
                },
              ),
              _buildListTile(
                Icons.help_outline,
                "À propos",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutScreen()),
                  );
                },
              ),
            ]),

            const SizedBox(height: 25),

            _buildSectionTitle("MON COMPTE"),
            _buildActionGroup([
              _buildListTile(
                Icons.person_outline,
                "Gestion de compte",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AccountManagementScreen(),
                    ),
                  );
                },
              ),
              _buildListTile(
                Icons.thumb_up_outlined,
                "Noter l'application",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RateAppScreen()),
                  );
                },
              ),
              _buildListTile(
                Icons.menu_book_outlined,
                "Incentives",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Container()),
                  );
                },
              ),
            ]),

            const SizedBox(height: 25),

            // Section Parrainage
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appColorSecond.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: appColor, // Violet très clair
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.card_giftcard,
                      color: appColorSecond,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Parrainage",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: appColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Je partage mon code parrainage\net je gagne 1000 FCFA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: appColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Pour obtenir votre bonus, vous et votre amie devez "
                    "avoir consommé une réservation d'un montant minimal "
                    "de 15 000 FCFA",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor, // Jaune/Or
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "J'invite mon ami(e",
                  style: TextStyle(
                    color: appColorSecond,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Bouton supprimer le compte
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Supprimer mon compte",
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget pour le titre des sections
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          color: appColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget pour grouper les éléments dans une carte blanche
  Widget _buildActionGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: appColorSecond.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Column(children: children),
    );
  }

  // Widget pour chaque ligne du menu
  Widget _buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: appColor, size: 22),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: appColor,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: appColor, size: 20),
          onTap: onTap,
        ),
        // On n'ajoute pas de Divider après le dernier élément (géré par la logique de la liste si besoin)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 1, color: Colors.grey[100]),
        ),
      ],
    );
  }
}
