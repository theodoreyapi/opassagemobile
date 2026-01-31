import 'package:flutter/material.dart';
import 'package:opassage/features/profile/profile.dart';

class HelpAndAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Fond gris très clair
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Aide et gestion de compte",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
                    MaterialPageRoute(builder: (_) => AccountManagementScreen()),
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
                "Instructives",
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E5F5), // Violet très clair
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.card_giftcard,
                      color: Colors.purple,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Parrainage",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Je partage mon code parrainage\net je gagne 1000 FCFA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Pour obtenir votre bonus, vous et votre amie devez avoir consommé une réservation d'un montant minimal de 15 000 FCFA",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700), // Jaune/Or
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Inviter un ami",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Bouton supprimer le compte
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Supprimer mon compte",
                  style: TextStyle(
                    color: Colors.purple,
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
          color: Colors.grey[700],
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget pour grouper les éléments dans une carte blanche
  Widget _buildActionGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  // Widget pour chaque ligne du menu
  Widget _buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: const Color(0xFF1A237E), size: 22),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.black,
            size: 20,
          ),
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
