import 'package:flutter/material.dart';

class AccountManagementScreen extends StatefulWidget {
  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Mon profil",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(height: 1, color: Colors.grey[100]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            _buildManagementCard(
              icon: Icons.person_add_alt_1_outlined,
              title: "Modification profil",
              subtitle: "Mettez à jour vos informations personnelles",
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _buildManagementCard(
              icon: Icons.lock_outline,
              title: "Modification Mot de passe",
              subtitle: "Changer votre mot de passe pour plus de sécurité",
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _buildManagementCard(
              icon: Icons.key_outlined,
              title: "Ajouter un code d’accès",
              subtitle: "Configurez un code pour accéder rapidement",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8EAF6)), // Bordure bleue très claire
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: const Color(0xFF9C27B0), size: 28), // Violet
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.blueGrey[200],
        ),
        onTap: onTap,
      ),
    );
  }
}