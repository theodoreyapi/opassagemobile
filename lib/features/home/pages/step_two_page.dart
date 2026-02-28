import 'package:flutter/material.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/home/home.dart';
import 'package:opassage/models/rooms_model.dart';
import 'package:opassage/services/reservation_service.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/utils.dart';

class ReservationStep2Screen extends StatefulWidget {
  RoomsModel? room;
  final DateTime? startDate;
  final DateTime? endDate;

  ReservationStep2Screen({super.key, this.room, this.startDate, this.endDate});

  @override
  State<ReservationStep2Screen> createState() => _ReservationStep2ScreenState();
}

class _ReservationStep2ScreenState extends State<ReservationStep2Screen> {
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  int get _nights {
    final diff = widget.endDate!.difference(widget.startDate!).inDays;
    return diff <= 0 ? 1 : diff;
  }

  double get _unitPrice {
    return double.tryParse(widget.room!.pricings!.first.price.toString()) ?? 0;
  }

  double get _totalPrice {
    return _nights * _unitPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Résumé Réservation',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Row(
              children: [
                _buildStepIndicator(1, true),
                Container(
                  width: 30,
                  height: 2,
                  color: const Color(0xFF9C27B0),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                ),
                _buildStepIndicator(2, true),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// CARD HÔTEL
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        /// IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.room!.images!.first.imagePath ?? '',
                            fit: BoxFit.contain,
                            height: 30.w,
                            width: 30.w,
                            errorBuilder: (_, __, ___) => Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.hotel, size: 40),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        /// INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.room!.name!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.room!.hotelAddress!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    widget.room!.rating!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '(${widget.room!.review} Avis)',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// DÉTAILS DU SÉJOUR
                  const Text(
                    'Détails du séjour',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  _buildDetailRow('Heure de début', widget.room!.hotelIn!),
                  Divider(height: 32),
                  _buildDetailRow('Heure de fin', widget.room!.hotelOut!),
                  Divider(height: 32),
                  _buildDetailRow('Arrivée', _formatDate(widget.startDate!)),
                  Divider(height: 32),
                  _buildDetailRow('Départ', _formatDate(widget.endDate!)),
                  Divider(height: 32),
                  _buildDetailRow('Durée', '$_nights nuit(s)'),
                  Divider(height: 32),
                  _buildDetailRow(
                    'Prix Unitaire',
                    '${widget.room!.pricings!.first.price} FCFA',
                  ),

                  const SizedBox(height: 32),

                  /// COÛT TOTAL
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9C27B0).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Coût total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${_totalPrice.toStringAsFixed(0)} FCFA',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9C27B0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          /// BOUTON VALIDER
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 16,
              top: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: isLoadingFavorite
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : SubmitButton("Valider", onPressed: _toggleReservation),
          ),
        ],
      ),
    );
  }

  String formatDateForApi(DateTime date) {
    return date.toIso8601String().split('T').first;
  }

  bool isLoadingFavorite = false;

  Future<void> _toggleReservation() async {
    if (isLoadingFavorite) return;

    setState(() => isLoadingFavorite = true);

    // ✅ récupérer l'identifiant correctement
    final int? userIdStr = SharedPreferencesHelper().getInt('identifiant');

    if (userIdStr == null) {
      setState(() => isLoadingFavorite = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Vous n'êtes pas connecté"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = await ReservationService.createReservation(
      userId: userIdStr,
      roomId: widget.room!.idRoom!,
      start: formatDateForApi(widget.startDate!),
      end: formatDateForApi(widget.endDate!),
    );

    setState(() => isLoadingFavorite = false);

    if (result['status'] == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReservationConfirmedScreen()),
      );
    } else {
      print(extractErrorMessage(result['body']['message']));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(extractErrorMessage(result['body']['message'])),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String extractErrorMessage(dynamic message) {
    if (message is String) {
      return message;
    }

    if (message is Map) {
      return message.values
          .map((e) => e is List ? e.join(', ') : e.toString())
          .join('\n');
    }

    return 'Une erreur est survenue';
  }

  Widget _buildStepIndicator(int step, bool isActive) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF9C27B0) : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
