import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 2, // Index pour "Confirmées"
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FE),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          title: Text(
            "Historique",
            style: TextStyle(
              color: Color(0xFF9C27B0), // Violet de l'image
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(110),
            child: Column(
              children: [
                // Barre de recherche
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Rechercher",
                            filled: true,
                            fillColor: Color(0xFFF4F7FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F7FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.tune, color: Colors.blue[300]),
                      ),
                    ],
                  ),
                ),
                // TabBar
                TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.indigo[900],
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: "Toutes"),
                    Tab(text: "En attente"),
                    Tab(text: "Confirmées"),
                    Tab(text: "usées"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(), // Toutes
            Container(), // En attente
            _buildConfirmedList(), // Confirmées
            Container(), // usées
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmedList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildReservationCard(
          title: "Studio prestige O’passage",
          location: "Abidjan Cocody riviera palmeraie",
          price: "45 000 FCFA",
          type: "Court/Long Séjour",
          periode: "15-18 Mai 2025",
          categorie: "Résidence Meublé",
          paiement: "Wave Money",
          dateEmission: "12 Mai 2025",
          ref: "#RES-8842",
          imageUrl: 'assets/images/room1.png',
        ),
        SizedBox(height: 16),
        _buildReservationCard(
          title: "Villa les palmiers",
          location: "Abidjan Cocody riviera palmeraie",
          price: "45 000 FCFA",
          type: "Repo/Dayuse",
          periode: "14:00 - 19:00", // Utilisé pour l'heure
          categorie: "Résidence Meublé",
          paiement: "Wave Money",
          dateEmission: "12 Mai 2025",
          ref: "#RES-8843",
          imageUrl: 'assets/images/room3.png',
        ),
      ],
    );
  }

  Widget _buildReservationCard({
    required String title,
    required String location,
    required String price,
    required String type,
    required String periode,
    required String categorie,
    required String paiement,
    required String dateEmission,
    required String ref,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          // Image avec badge "Confirmée"
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF00C853),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text("Confirmée", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Détails
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Text(price, style: TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Text(location, style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(height: 15),
                Row(
                  children: [
                    _buildInfoItem("TYPE", type),
                    Spacer(),
                    _buildInfoItem(type.contains("Dayuse") ? "HEURE" : "PÉRIODE", periode),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _buildInfoItem("CATÉGORIE", categorie),
                    Spacer(),
                    _buildInfoItem("PAIEMENT", paiement),
                  ],
                ),
              ],
            ),
          ),
          // Footer de la carte
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFFFFFDE7),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Émis le $dateEmission", style: TextStyle(fontSize: 11)),
                Text("Ref: $ref", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600], fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}