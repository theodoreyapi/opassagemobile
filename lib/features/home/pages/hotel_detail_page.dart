import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/home/home.dart';
import 'package:opassage/models/rooms_model.dart';
import 'package:opassage/services/favorite_service.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/utils.dart';

class HotelDetailScreen extends StatefulWidget {
  RoomsModel? room;

  HotelDetailScreen({super.key, this.room});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  LatLng get hotelPosition {
    final lat = double.tryParse(room.latitude ?? '');
    final lng = double.tryParse(room.longitude ?? '');
    return LatLng(lat ?? 5.3599, lng ?? -4.0082);
  }

  bool isFavorite = false;
  bool isLoadingFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  late final room = widget.room!;
  late final images = room.images ?? [];
  late final pricings = room.pricings ?? [];
  late final amenities = room.amenities ?? [];

  Future<void> _toggleFavorite() async {
    if (isLoadingFavorite) return;

    setState(() => isLoadingFavorite = true);

    // ✅ récupérer l'identifiant correctement
    final int? userIdStr = SharedPreferencesHelper().getInt('identifiant');

    if (userIdStr == null) {
      setState(() => isLoadingFavorite = false);
      _showToast("Utilisateur non connecté");
      return;
    }

    final result = await FavoriteService.addFavorite(
      userId: userIdStr,
      roomId: widget.room!.idRoom!,
      hotelId: widget.room!.idHotel!,
    );

    setState(() => isLoadingFavorite = false);

    if (result['status'] == 200) {
      setState(() => isFavorite = true);
      _showToast('Ajouté aux favoris ❤️');
    } else {
      _showToast(result['body']['message'] ?? 'Erreur');
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM);
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
                    Image.network(
                      images.isNotEmpty ? images.first.imagePath! : '',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
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
                          icon: isLoadingFavorite
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.black,
                                ),
                          onPressed: _toggleFavorite,
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
                            child: Text(
                              widget.room!.name!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                pricings.isNotEmpty
                                    ? formatPrice(pricings.first.price)
                                    : "—",
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
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xFF9C27B0),
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            room.hotelAddress ?? '',
                            style: TextStyle(
                              color: const Color(0xFF9C27B0),
                              fontSize: 14.sp,
                            ),
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
                          color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF9C27B0),
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${room.nbreReservation ?? 0} réservations réalisées',
                              style: const TextStyle(
                                color: Color(0xFF9C27B0),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      /// DESCRIPTION DE L'ÉTABLISSEMENT
                      Text(
                        'Description de l\'établissement',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        room.descEtabli?.isNotEmpty == true
                            ? room.descEtabli!
                            : "Aucune description disponible",
                      ),
                      const SizedBox(height: 24),

                      /// DESCRIPTION DE L'HÉBERGEMENT
                      Text(
                        'Description de l\'hébergement',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        room.descHeberge?.isNotEmpty == true
                            ? room.descHeberge!
                            : "Aucune information disponible",
                      ),

                      const SizedBox(height: 20),

                      /// CARACTÉRISTIQUES
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildFeatureChip(
                            Icons.meeting_room,
                            room.name ?? '',
                          ),
                          _buildFeatureChip(
                            Icons.bed,
                            '${room.bedrooms ?? 0} chambres',
                          ),
                          _buildFeatureChip(
                            Icons.bathtub_outlined,
                            '${room.bathrooms ?? 0} salles de bain',
                          ),
                          _buildFeatureChip(
                            Icons.chair_outlined,
                            '${room.livingRooms ?? 0} salon',
                          ),
                          _buildFeatureChip(
                            Icons.people,
                            '${room.capacity ?? 0} personnes',
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

                      /// GRILLE D'ÉQUIPEMENTS
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: amenities.map((amenity) {
                          return _buildAmenityItem(amenity.icon, amenity.name);
                        }).toList(),
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

                      Column(
                        children: pricings.map((p) {
                          return _buildPricingRow(
                            p.label ?? '',
                            formatPrice(p.price),
                          );
                        }).toList(),
                      ),

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
                            _buildPolicyRow(
                              'Arrivée (Check-in)',
                              room.hotelIn != null
                                  ? 'Dès ${room.hotelIn}'
                                  : '—',
                            ),
                            Divider(height: 24),
                            _buildPolicyRow(
                              'Départ (Check-out)',
                              room.hotelOut != null
                                  ? 'Avant ${room.hotelOut}'
                                  : '—',
                            ),
                            Divider(height: 24),
                            _buildPolicyRow(
                              'Annulation',
                              room.freeCancel != null
                                  ? 'Gratuite jusqu\'à ${room.freeCancel}h'
                                  : '—',
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
                          Text(
                            widget.room!.rating!,
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
                          Text(
                            '${widget.room!.review!} Avis',
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
                      Text(
                        room.hotelAddress ?? '',
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
                              target: hotelPosition,
                              zoom: 14,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('hotel'),
                                position: hotelPosition,
                              ),
                            },
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
                    color: Colors.black.withValues(alpha: 0.1),
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
                      children: [
                        const Text(
                          'Prix total',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pricings.isNotEmpty
                              ? formatPrice(pricings.first.price)
                              : '—',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: appColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(1.w),
                  Expanded(
                    child: SubmitButton(
                      "Réserver",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReservationStep1Screen(room: widget.room),
                          ),
                        );
                      },
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

  String formatPrice(String? price) {
    if (price == null) return '';

    final number = double.tryParse(price) ?? 0;
    final formatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: 'FCFA',
      decimalDigits: 0,
    );

    return formatter.format(number);
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

  Widget _buildAmenityItem(String? iconUrl, String? label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(
              iconUrl ?? '',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.check_circle_outline,
                color: Colors.grey.shade400,
                size: 26,
              ),
            ),
          ),
        ),
        Text(
          label ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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
