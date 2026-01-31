import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:opassage/features/home/home.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  final Set<Marker> _markers = {};
  final LatLng _hotelPosition = const LatLng(5.3599517, -4.0082563);

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(markerId: const MarkerId('hotel'), position: _hotelPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// CONTENU SCROLLABLE
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE HEADER
                Stack(
                  children: [
                    /// IMAGE PRINCIPALE
                    Image.asset(
                      'assets/images/hotel_room.jpg',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 300,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.hotel, size: 80),
                      ),
                    ),

                    /// BOUTON RETOUR
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    /// BOUTON FAVORIS
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),

                    /// BOUTONS BAS DE L'IMAGE
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        children: [
                          _buildImageButton(
                            icon: Icons.photo_library_outlined,
                            label: 'Voir photos',
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          _buildImageButton(
                            icon: Icons.panorama_fish_eye,
                            label: 'Visite 360°',
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// CONTENU PRINCIPAL
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// EN-TÊTE AVEC NOM ET PRIX
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Résidence O\'Passage',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xFF9C27B0),
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Cocody, riviera 3',
                                      style: TextStyle(
                                        color: Color(0xFF9C27B0),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                '25 000 CFA',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '/ nuit',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// BADGE RÉSERVATIONS
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9C27B0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF9C27B0),
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '124 réservations réalisées',
                              style: TextStyle(
                                color: Color(0xFF9C27B0),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// DESCRIPTION DE L'ÉTABLISSEMENT
                      const Text(
                        'Description de l\'établissement',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Appartement moderne et lumineux idéal pour vos séjours à Abidjan. Profitez d\'un espace calme, sécurisé et entièrement équipé pour le travail comme pour se détente',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// DESCRIPTION DE L'HÉBERGEMENT
                      const Text(
                        'Description de l\'hébergement',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Appartement moderne et lumineux idéal pour vos séjours à Abidjan. Profitez d\'un espace calme, sécurisé et entièrement équipé comme pour se détente',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// CARACTÉRISTIQUES
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildFeatureChip(
                            Icons.meeting_room,
                            'Studio premium',
                          ),
                          _buildFeatureChip(Icons.bed, '2 chambres'),
                          _buildFeatureChip(
                            Icons.bathtub_outlined,
                            '3 salles de bain',
                          ),
                          _buildFeatureChip(Icons.chair_outlined, '1 Salon'),
                          _buildFeatureChip(
                            Icons.kitchen_outlined,
                            'Cuisine équipée',
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// ÉQUIPEMENTS & SERVICES
                      const Text(
                        'Équipements & services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// GRILLE D'ÉQUIPEMENTS
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          _buildAmenityItem(Icons.hot_tub_outlined, 'Jacuzzi'),
                          _buildAmenityItem(
                            Icons.restaurant_outlined,
                            'Restaurant',
                          ),
                          _buildAmenityItem(Icons.pool_outlined, 'Piscine'),
                          _buildAmenityItem(Icons.wifi, 'Wifi HD'),
                          _buildAmenityItem(
                            Icons.local_parking_outlined,
                            'Parking\nPrivé',
                          ),
                          _buildAmenityItem(
                            Icons.security_outlined,
                            'Sécurité\n24h/24',
                          ),
                          _buildAmenityItem(
                            Icons.fitness_center_outlined,
                            'Salle de\nsport',
                          ),
                          _buildAmenityItem(
                            Icons.local_laundry_service_outlined,
                            'Machine\nà laver',
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// TARIFICATION
                      const Text(
                        'Tarification',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildPricingRow('Pour 1 nuitée', '25 000 FCFA'),
                      _buildPricingRow('Pour 3 nuitées', '70 000 FCFA'),
                      _buildPricingRow('pour 1 semaine', '150 000 FCFA'),

                      const SizedBox(height: 32),

                      /// POLITIQUE ARRIVÉE / DÉPART
                      const Text(
                        'Politique Arrivée / Départ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _buildPolicyRow('Arrivée (Check-in)', 'Dès 14:00'),
                            const Divider(height: 24),
                            _buildPolicyRow(
                              'Départ (Check-out)',
                              'Avant 12:00',
                            ),
                            const Divider(height: 24),
                            _buildPolicyRow(
                              'Politique D\'annulation',
                              'Gratuite jusqu\'à 48H',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// AVIS DES VOYAGEURS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Avis des voyageurs',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Text(
                                  'Consulter',
                                  style: TextStyle(
                                    color: Color(0xFF9C27B0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Color(0xFF9C27B0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Text(
                            '5,0',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Color(0xFF9C27B0),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '32 Avis',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// EMPLACEMENT
                      const Text(
                        'Emplacement',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Cocody, Riviera 3, Abidjan',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),

                      /// CARTE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 200,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _hotelPosition,
                              zoom: 14,
                            ),
                            markers: _markers,
                            zoomControlsEnabled: false,
                            scrollGesturesEnabled: false,
                            zoomGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// BOUTON RÉSERVER FIXE EN BAS
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Prix total',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '25 000 F',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9C27B0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationStep1Screen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Réserver',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF9C27B0), size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF9C27B0),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF9C27B0), size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFF9C27B0), size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.2),
        ),
      ],
    );
  }

  Widget _buildPricingRow(String label, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
