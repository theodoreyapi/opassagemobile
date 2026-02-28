import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:opassage/features/home/home.dart';
import 'package:opassage/models/rooms_model.dart';
import 'package:opassage/services/favorite_service.dart';

import '../../../core/utils/utils.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<RoomsModel>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = FavoriteService.getFavorites(
      SharedPreferencesHelper().getInt('identifiant')!,
    );
  }

  Future<void> _removeFavorite(int userId, int roomId) async {
    final success = await FavoriteService.deleteFavorite(userId, roomId);

    if (success) {
      setState(() {
        _loadFavorites(); // refresh automatique
      });

      _showToast('Supprimé des favoris ❤️‍🔥');
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
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
      body: FutureBuilder<List<RoomsModel>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun favori enregistré"));
          }

          final favorites = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final room = favorites[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildFavoriteCard(room),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoriteCard(RoomsModel room) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HotelDetailScreen(room: room)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.network(
                    room.images?.isNotEmpty == true
                        ? room.images!.first.imagePath!
                        : '',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 160,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.hotel, size: 60),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => _removeFavorite(
                      SharedPreferencesHelper().getInt('identifiant')!,
                      room.idRoom!,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.favorite, color: Colors.purple),
                    ),
                  ),
                ),
              ],
            ),

            /// TEXTE
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.name ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${room.pricePerNight} ${room.monnaie}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '/ nuit',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        room.hotelAddress ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${room.capacity} personne(s)',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 12),

                  /// AMENITIES
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: room.amenities!
                        .take(5)
                        .map((a) => _buildAmenityTag(a.name ?? ''))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenityTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}