import 'package:flutter/material.dart';
import 'package:opassage/core/themes/app_color.dart';
import 'package:opassage/features/reservation/pages/detail_page.dart';

class MyNewBookingsScreen extends StatefulWidget {
  const MyNewBookingsScreen({super.key});

  @override
  State<MyNewBookingsScreen> createState() => _MyNewBookingsScreenState();
}

class _MyNewBookingsScreenState extends State<MyNewBookingsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Liste des réservations
  final List<BookingModel> bookings = [
    BookingModel(
      type: 'Repos/Dayuse',
      roomType: 'Chambre standard',
      price: '15 000 FCA',
      hotelName: 'Hôtel le refuge',
      location: 'Marcory, Zone 4',
      date: '15 Oct. 08h00 - 14H00',
      status: BookingStatus.available,
    ),
    BookingModel(
      type: 'Court séjour',
      roomType: 'Chambre standard',
      price: '60 000 FCA',
      hotelName: 'Résidence onyx',
      location: 'Marcory, Zone 4',
      date: 'Du 22 oct. 2026 au 26 oct. 2026 ( 4 jours )',
      status: BookingStatus.unavailable,
    ),
    BookingModel(
      type: '1/2 journée',
      roomType: 'Chambre standard',
      price: '10 000 FCA',
      hotelName: 'Hôtel le refuge',
      location: 'Marcory, Zone 4',
      date: 'Le 31 jan. 2026 de 14h-20h (6h)',
      status: BookingStatus.available,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Mes nouvelles réservations',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// BARRE DE RECHERCHE ET FILTRE
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  /// CHAMP DE RECHERCHE
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey.shade400,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Rechercher',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// BOUTON FILTRE
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.tune, color: Colors.grey.shade600),
                      onPressed: () {
                        _showFilterBottomSheet();
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// LISTE DES RÉSERVATIONS
            Expanded(
              child: Container(
                color: appColorBorder,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BookingCard(booking: bookings[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Disponible'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: const Color(0xFF9C27B0),
              ),
            ),
            ListTile(
              title: const Text('Indisponible'),
              trailing: Switch(value: false, onChanged: (value) {}),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C27B0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Appliquer', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CARD DE RÉSERVATION
class BookingCard extends StatelessWidget {
  final BookingModel booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// EN-TÊTE AVEC TYPE ET PRIX
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.type,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking.roomType,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                booking.price,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C27B0),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 16),

          /// DÉTAILS
          _buildDetailRow(Icons.apartment_outlined, booking.hotelName),
          const SizedBox(height: 10),
          _buildDetailRow(Icons.location_on_outlined, booking.location),
          const SizedBox(height: 10),
          _buildDetailRow(Icons.calendar_today_outlined, booking.date),

          const SizedBox(height: 20),

          /// BAS - STATUT ET BOUTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// BADGE STATUT
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: booking.status == BookingStatus.available
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      booking.status == BookingStatus.available
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: booking.status == BookingStatus.available
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      booking.status == BookingStatus.available
                          ? 'Disponible'
                          : 'Indisponible',
                      style: TextStyle(
                        color: booking.status == BookingStatus.available
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              /// BOUTON DÉTAILS
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationDetailScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Détails',
                      style: TextStyle(
                        color: appColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: appColor, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade400, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}

/// MODÈLES
enum BookingStatus { available, unavailable }

class BookingModel {
  final String type;
  final String roomType;
  final String price;
  final String hotelName;
  final String location;
  final String date;
  final BookingStatus status;

  BookingModel({
    required this.type,
    required this.roomType,
    required this.price,
    required this.hotelName,
    required this.location,
    required this.date,
    required this.status,
  });
}
