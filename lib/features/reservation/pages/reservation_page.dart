import 'package:flutter/material.dart';
import 'package:opassage/core/themes/app_color.dart';
import 'package:opassage/core/utils/utils.dart';
import 'package:opassage/features/reservation/reservation.dart';
import 'package:opassage/models/reservation_model.dart';
import 'package:opassage/services/reservation_service.dart';
import 'package:sizer/sizer.dart';

class MyNewBookingsScreen extends StatefulWidget {
  const MyNewBookingsScreen({super.key});

  @override
  State<MyNewBookingsScreen> createState() => _MyNewBookingsScreenState();
}

class _MyNewBookingsScreenState extends State<MyNewBookingsScreen> {
  final TextEditingController _searchController = TextEditingController();

  late Future<List<ReservationModel>> _reservations;

  @override
  void initState() {
    super.initState();
    _reservations = ReservationService().fetchReservations(
      SharedPreferencesHelper().getInt('identifiant')!,
    );
  }

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
              child: FutureBuilder<List<ReservationModel>>(
                future: _reservations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // ✅ Ajout de la gestion d'erreur
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text("Erreur : ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Aucune réservation enregistrée"));
                  }

                  final reservation = snapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: reservation.length,
                    itemBuilder: (context, index) {
                      final booking = reservation[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: BookingCard(booking: booking),
                      );
                    },
                  );
                },
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
                activeThumbColor: const Color(0xFF9C27B0),
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

/// CARD DE RÉSERVATION DYNAMIQUE
class BookingCard extends StatelessWidget {
  final ReservationModel booking;

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
            color: Colors.black.withValues(alpha: 0.05),
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
                      booking.room!.name ?? 'Chambre',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Capacité: ${booking.room?.capacity ?? '-'}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${booking.totalPrice ?? '-'} ${booking.room!.hotel!.currency!}",
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

          _buildDetailRow(
            Icons.apartment_outlined,
            booking.room?.hotel!.hotelName! ?? 'Nom hôtel',
          ),
          const SizedBox(height: 10),
          _buildDetailRow(
            Icons.location_on_outlined,
            booking.room!.hotel!.address!,
          ), // tu peux ajouter l'hôtel avec location
          const SizedBox(height: 10),
          _buildDetailRow(
            Icons.calendar_today_outlined,
            "${booking.startDate} - ${booking.endDate}",
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(booking.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(booking.status),
                      color: _getStatusColor(booking.status),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _getStatusLabel(booking.status),
                      style: TextStyle(
                        color: _getStatusColor(booking.status),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReservationDetailScreen(reserve: booking),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    const SizedBox(width: 4),
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

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'confirmed':  return Colors.green.shade700;
      case 'pending':    return Colors.orange.shade700;
      case 'canceled':   return Colors.red.shade700;
      case 'completed':  return Colors.blue.shade700;
      case 'no_show':    return Colors.red.shade500;
      default:           return Colors.grey.shade700;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'confirmed':  return Icons.check_circle;
      case 'pending':    return Icons.hourglass_empty;
      case 'canceled':   return Icons.cancel;
      case 'completed':  return Icons.task_alt;
      case 'no_show':    return Icons.person_off;
      default:           return Icons.help_outline;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status) {
      case 'confirmed':  return 'Disponible';
      case 'pending':    return 'En attente';
      case 'canceled':   return 'Annulée';
      case 'completed':  return 'Terminée';
      case 'no_show':    return 'Indisponible';
      default:           return 'Inconnu';
    }
  }
}
