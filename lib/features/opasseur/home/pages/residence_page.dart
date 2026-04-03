import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

import '../home.dart';
import 'home_page.dart';

class ResidencePage extends StatefulWidget {
  const ResidencePage({super.key});

  @override
  State<ResidencePage> createState() => _ResidencePageState();
}

class _ResidencePageState extends State<ResidencePage> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  String selectedDuration = 'Repas/Dayuse (1h-2H-3h+)';
  String selectedCommune = 'Cocody';
  String selectedBudget = '15 000';
  String selectedPiece = 'Studio';

  // Position initiale (Abidjan)
  final LatLng _initialPosition = const LatLng(5.3599517, -4.0082563);

  // Liste des hôtels avec positions
  final List<HotelMarker> hotels = [
    HotelMarker(
      id: '1',
      name: 'Hotel Palm',
      price: '30 000 CFA',
      distance: 'Riviera 2km',
      position: LatLng(5.3699517, -4.0182563),
      imageUrl: 'assets/images/room1.png',
    ),
    HotelMarker(
      id: '2',
      name: 'Villa Luxe',
      price: '40 000 CFA',
      distance: 'Riviera 2km',
      position: LatLng(5.3499517, -3.9982563),
      imageUrl: 'assets/images/room2.jpg',
    ),
    HotelMarker(
      id: '3',
      name: 'Suite Confort',
      price: '15 000 CFA',
      distance: 'Riviera 2km',
      position: LatLng(5.3799517, -4.0282563),
      imageUrl: 'assets/images/room3.png',
    ),
  ];

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

  Future<Marker> _createCustomMarker(HotelMarker hotel) async {
    return Marker(
      markerId: MarkerId(hotel.id),
      position: hotel.position,
      onTap: () => _showHotelDetails(hotel),
      icon: await _createPriceMarkerIcon(hotel.price, hotel.imageUrl),
    );
  }

  Future<BitmapDescriptor> _createPriceMarkerIcon(
      String price, String imageUrl) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(180, 80);

    // Dessiner le fond blanc arrondi
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(5, 5, size.width - 10, size.height - 15),
      const Radius.circular(12),
    );

    // Ombre
    canvas.drawRRect(rect, shadowPaint);
    // Fond
    canvas.drawRRect(rect, paint);

    // Dessiner l'image (cercle)
    final circlePaint = Paint()..color = Colors.grey.shade300;
    canvas.drawCircle(const Offset(30, 30), 18, circlePaint);

    // Dessiner le prix
    final textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: price,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, const Offset(55, 20));

    // Dessiner la distance
    final distanceText = TextPainter(
      text: const TextSpan(
        text: 'Riviera 2km',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    distanceText.layout();
    distanceText.paint(canvas, const Offset(55, 38));

    // Dessiner le triangle pointer
    final trianglePath = Path();
    trianglePath.moveTo(size.width / 2 - 8, size.height - 15);
    trianglePath.lineTo(size.width / 2, size.height - 5);
    trianglePath.lineTo(size.width / 2 + 8, size.height - 15);
    trianglePath.close();

    canvas.drawPath(trianglePath, paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  void _showHotelDetails(HotelMarker hotel) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    hotel.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.hotel),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hotel.distance,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        hotel.price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Action de réservation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Réserver maintenant',
                  style: TextStyle(fontSize: 16, color: appColorBlack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
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

                  /// BOUTON "VOIR TOUT" EN HAUT
                  Positioned(
                    top: 50,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action pour voir tout
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        'Voir tout',
                        style: TextStyle(fontSize: 14, color: appColorWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /// PANNEAU DE RECHERCHE EN BAS
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITRE
                      const Text(
                        'Résidence meublées',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Affinez votre recherche pour commander',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// BOUTONS DE DURÉE
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildDurationChip('Repas/Dayuse (1h-2H-3h+)', true),
                            const SizedBox(width: 8),
                            _buildDurationChip('Court/Long Séjour', false),
                            const SizedBox(width: 8),
                            _buildDurationChip('Court/Séjour', false),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// CHAMPS DE RECHERCHE
                      Row(
                        children: [
                          /// COMMUNE
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Commune',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedCommune,
                                      isExpanded: true,
                                      icon: const Icon(Icons.keyboard_arrow_down,
                                          size: 20),
                                      items: ['Cocody', 'Plateau', 'Yopougon']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCommune = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// BUDGET
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Budget ( FCFA)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedBudget,
                                      isExpanded: true,
                                      icon: const Icon(Icons.keyboard_arrow_down,
                                          size: 20),
                                      items: [
                                        '15 000',
                                        '30 000',
                                        '50 000',
                                        '100 000'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedBudget = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [

                          /// PIECES
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nombre de pièces',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedPiece,
                                      isExpanded: true,
                                      icon: const Icon(Icons.keyboard_arrow_down,
                                          size: 20),
                                      items: [
                                        'Studio',
                                        '1 pièce',
                                        '2 pièces',
                                        '3 pièces'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedPiece = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          /// BOUTON RECHERCHE
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.search,
                                    color: Colors.black, size: 26),
                                onPressed: () {
                                  // Action de recherche
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      Gap(2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: propertyList.length,
                          itemBuilder: (context, index) {
                            final property = propertyList[index];
                            return PropertyCard(property: property);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildDurationChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? appColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? appColor : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}