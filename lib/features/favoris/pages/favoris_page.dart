import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FE), // Fond légèrement grisé
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          "Favoris",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildFavoriteCard(
            imageUrl: 'assets/images/room1.png',
            title: "Chambre standard",
            location: "Cocody riviera palmeraie",
            price: "10 000 FCFA",
            details: "2 adultes : 1 lit double",
            amenities: ["Wifi", "TV", "Jacuzzi", "Chauffe eau", "Climatiseur"],
          ),
          SizedBox(height: 16),
          _buildFavoriteCard(
            imageUrl: 'assets/images/room2.jpg',
            title: "Chambre standard",
            location: "Cocody riviera palmeraie",
            price: "10 000 FCFA",
            details: "2 adultes : 1 lit double",
            amenities: ["Wifi", "TV", "Jacuzzi", "Chauffe eau", "Climatiseur"],
          ),
          SizedBox(height: 16),
          _buildFavoriteCard(
            imageUrl: 'assets/images/room3.png',
            title: "Chambre standard",
            location: "Cocody riviera palmeraie",
            price: "10 000 FCFA",
            details: "2 adultes : 1 lit double",
            amenities: ["Wifi", "TV", "Jacuzzi", "Chauffe eau", "Climatiseur"],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard({
    required String imageUrl,
    required String title,
    required String location,
    required String price,
    required String details,
    required List<String> amenities,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image avec bouton coeur
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite, color: Colors.purple, size: 20),
                ),
              ),
            ],
          ),
          // Contenu texte
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[900],
                          ),
                        ),
                        Text("/ nuit", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.purple),
                    SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  details,
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey[800]),
                ),
                SizedBox(height: 12),
                // Liste des équipements (Chips)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: amenities.map((item) => _buildAmenityTag(item)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFF1F4FF), // Bleu très clair
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.blueGrey[400],
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}