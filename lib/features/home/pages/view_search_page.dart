import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:opassage/core/themes/themes.dart';
import 'dart:ui' as ui;

import 'package:opassage/features/home/home.dart';

class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({super.key});

  @override
  State<HotelSearchScreen> createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  // Position initiale
  final LatLng _initialPosition = const LatLng(40.7128, -74.0060); // New York

  // Liste des hôtels
  final List<HotelLocation> hotels = [
    HotelLocation(
      id: '1',
      name: 'Studio Zen',
      price: '30 000 CFA',
      position: LatLng(40.7228, -74.0060),
      imageUrl: 'assets/images/room1.png',
    ),
    HotelLocation(
      id: '2',
      name: 'Studio Zen',
      price: '15 000 CFA',
      position: LatLng(40.7328, -73.9960),
      imageUrl: 'assets/images/room2.jpg',
    ),
    HotelLocation(
      id: '3',
      name: 'Studio Zen',
      price: '40 000 CFA',
      position: LatLng(40.7028, -74.0160),
      imageUrl: 'assets/images/room3.png',
    ),
    HotelLocation(
      id: '4',
      name: 'Studio Zen',
      price: '25 000 CFA',
      position: LatLng(40.6928, -74.0260),
      imageUrl: 'assets/images/room4.png',
    ),
    HotelLocation(
      id: '5',
      name: 'Studio Zen',
      price: '15 000 CFA',
      position: LatLng(40.7428, -73.9860),
      imageUrl: 'assets/images/room3.jpg',
    ),
  ];

  HotelLocation? selectedHotel;

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  Future<void> _createMarkers() async {
    for (var hotel in hotels) {
      final marker = await _createCustomMarker(hotel);
      _markers.add(marker);
    }
    setState(() {});
  }

  Future<Marker> _createCustomMarker(HotelLocation hotel) async {
    return Marker(
      markerId: MarkerId(hotel.id),
      position: hotel.position,
      onTap: () {
        setState(() => selectedHotel = hotel);
        _sheetController.animateTo(
          0.6,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
      icon: await _createMarkerIcon(hotel),
    );
  }

  Future<BitmapDescriptor> _createMarkerIcon(HotelLocation hotel) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(200, 90);

    // Fond blanc avec ombre
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 8, size.width - 16, size.height - 25),
      const Radius.circular(12),
    );

    canvas.drawRRect(rect, shadowPaint);
    canvas.drawRRect(rect, bgPaint);

    // Image circulaire (placeholder)
    final circlePaint = Paint()..color = Colors.grey.shade400;
    canvas.drawCircle(const Offset(40, 35), 22, circlePaint);

    // Texte prix
    final priceText = TextPainter(
      text: TextSpan(
        text: hotel.price,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    priceText.layout();
    priceText.paint(canvas, const Offset(70, 23));

    // Texte nom
    final nameText = TextPainter(
      text: TextSpan(
        text: hotel.name,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      ),
      textDirection: TextDirection.ltr,
    );
    nameText.layout();
    nameText.paint(canvas, const Offset(70, 42));

    // Triangle pointer
    final trianglePath = Path();
    trianglePath.moveTo(size.width / 2 - 10, size.height - 25);
    trianglePath.lineTo(size.width / 2, size.height - 10);
    trianglePath.lineTo(size.width / 2 + 10, size.height - 25);
    trianglePath.close();

    canvas.drawPath(trianglePath, bgPaint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// GOOGLE MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 13,
            ),
            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          /// APP BAR
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Rechercher près de vous',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          /// DRAGGABLE BOTTOM SHEET
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: selectedHotel != null
                    ? _buildHotelDetails(scrollController)
                    : _buildEmptyState(),
              );
            },
          ),

          /// BOTTOM NAV BAR
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Accueil', true),
                  _buildNavItem(
                    Icons.calendar_today,
                    'Mes nouvelles réservations',
                    false,
                  ),
                  _buildNavItem(Icons.history, 'Historique', false),
                  _buildNavItem(Icons.favorite_border, 'Favoris', false),
                  _buildNavItem(Icons.person_outline, 'Profil', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelDetails(ScrollController scrollController) {
    final hotel = selectedHotel!;

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          /// DRAG HANDLE
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          /// IMAGE
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('assets/images/room1.png'),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
            ),
            child: Stack(
              children: [
                /// RATING BADGE
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 4),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '(124 avis)',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// DETAILS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Résidence O\'Palmier',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Cocody, Abidjan',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '25 000 FCFA',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: appColor,
                          ),
                        ),
                        Text(
                          'Par nuit',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// FEATURES
                Row(
                  children: [
                    Expanded(child: _buildFeature(Icons.hotel, 'Suite junior')),
                    Expanded(
                      child: _buildFeature(
                        Icons.home_work,
                        'Résidence meublée',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _buildFeature(Icons.people, '345 Réservations'),

                const SizedBox(height: 20),

                /// DESCRIPTION
                const Text(
                  'Hébergement spacieux avec vue imprenable, équipé de toutes les commodités modernes',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                /// BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() => selectedHotel = null);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'Fermer',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetailScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Consulter',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'Sélectionnez un hôtel sur la carte',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? appColor : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? appColor : Colors.grey,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _sheetController.dispose();
    super.dispose();
  }
}

/// MODÈLE
class HotelLocation {
  final String id;
  final String name;
  final String price;
  final LatLng position;
  final String imageUrl;

  HotelLocation({
    required this.id,
    required this.name,
    required this.price,
    required this.position,
    required this.imageUrl,
  });
}
