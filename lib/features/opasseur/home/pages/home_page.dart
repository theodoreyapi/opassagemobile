import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/models/rooms_model.dart';
import 'package:opassage/services/rooms_service.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/utils.dart';
import '../../premium/pages/pages.dart';
import '../home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var recherche = TextEditingController();

  final PageController _promoController = PageController();
  int _currentPromoIndex = 0;
  Timer? _promoTimer;

  late Future<List<RoomsModel>> roomsFuture;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    roomsFuture = RoomsService.fetchRooms();
  }

  void _startAutoScroll() {
    _promoTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPromoIndex < promoList.length - 1) {
        _currentPromoIndex++;
      } else {
        _currentPromoIndex = 0;
      }

      _promoController.animateToPage(
        _currentPromoIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _promoTimer?.cancel();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFondLayout,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 6.h,
                left: 4.w,
                right: 4.w,
                bottom: 1.5.h,
              ),
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.w),
                  bottomRight: Radius.circular(10.w),
                ),
              ),
              child: Column(
                children: [
                  /// Ligne principale
                  Row(
                    children: [
                      /// Avatar
                      CircleAvatar(
                        radius: 6.w,
                        backgroundImage: const AssetImage(
                          "assets/images/djamo.jpg",
                        ),
                      ),

                      Gap(3.w),

                      /// Texte Bonjour
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SharedPreferencesHelper().getString('username') !=
                                      null
                                  ? "Bonjour ${SharedPreferencesHelper().getString('username')}"
                                  : "Bonjour invité",
                              style: TextStyle(
                                color: appColorSecond,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_border,
                                  color: appColorSecond,
                                  size: 16.sp,
                                ),
                                Gap(1.w),
                                Text(
                                  "O’Passeur classic",
                                  style: TextStyle(
                                    color: appColorSecond,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// Icônes droite
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.headset_mic_outlined,
                              color: appColorSecond,
                            ),
                          ),
                          Gap(3.w),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: appColorSecond,
                            ),
                          ),
                          Gap(3.w),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.menu_outlined,
                              color: appColorSecond,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Gap(1.h),

                  /// Bouton VIP
                  Align(
                    alignment: Alignment.centerRight,
                    child: SubmitButton(
                      "J'accède à un traitement de vip",
                      height: 4.h,
                      radius: 10.w,
                      fontSize: 11.sp,
                      couleur: appColorSecond,
                      textcouleur: appColor,
                      width: 30.w,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PremiumSubscriptionScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Gap(3.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: appColorSecond.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Champ recherche
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: appColor),
                          Gap(2.w),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Rechercher près de moi",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: appColor),
                        ],
                      ),
                    ),

                    Gap(3.h),

                    Row(
                      children: [
                        Text(
                          "Ou rechercher \nselon critères",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Gap(1.w),

                        /// HOTEL
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => HotelPage()),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(.2.h),
                              decoration: BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              child: Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Icon(
                                    Icons.apartment,
                                    color: appColorSecond,
                                    size: 18.sp,
                                  ),
                                  Gap(1.w),
                                  Text(
                                    "Hôtel",
                                    style: TextStyle(
                                      color: appColorSecond,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Gap(1.w),

                        /// RESIDENCE
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ResidencePage(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(.2.h),
                              decoration: BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              child: Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: appColorSecond,
                                    size: 18.sp,
                                  ),
                                  Gap(1.w),
                                  Text(
                                    "Résidence meublée",
                                    style: TextStyle(
                                      color: appColorSecond,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Gap(2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                'Nouveautés & offres importantes',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: appColor,
                ),
              ),
            ),

            Gap(1.5.h),

            /// CARROUSEL AUTO-SCROLLING
            SizedBox(
              height: 11.h,
              child: PageView.builder(
                controller: _promoController,
                onPageChanged: (index) {
                  setState(() => _currentPromoIndex = index);
                },
                itemCount: promoList.length,
                itemBuilder: (context, index) {
                  final promo = promoList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: PromoCard(promo: promo),
                  );
                },
              ),
            ),

            Gap(1.h),

            /// INDICATEURS DE PAGE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                promoList.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPromoIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPromoIndex == index
                        ? appColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                ),
              ),
            ),

            Gap(3.h),

            /// SECTION: Les plus accueillants
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Les plus accueillants',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: appColor,
                ),
              ),
            ),

            /// GRILLE DE LOGEMENTS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: FutureBuilder<List<RoomsModel>>(
                future: roomsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur de chargement'));
                  }

                  final rooms = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return RoomCard(room: rooms[index]);
                    },
                  );
                },
              ),
            ),

            Gap(2.h),
          ],
        ),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final RoomsModel room;

  const RoomCard({super.key, required this.room});

  String formatPrice(String? price) {
    if (price == null) return '';

    final number = double.tryParse(price) ?? 0;
    final formatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: room.monnaie,
      decimalDigits: 0,
    );

    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = room.images != null && room.images!.isNotEmpty
        ? room.images!.first.imagePath
        : null;

    return InkWell(
      borderRadius: BorderRadius.circular(3.w),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HotelDetailScreen(room: room)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(3.w)),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      height: 10.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 10.h,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image, size: 40),
                    ),
            ),

            /// Infos
            Padding(
              padding: EdgeInsets.all(1.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Localisation + prix
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          room.hotelAddress ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Gap(2.w),
                      Text(
                        '${formatPrice(room.pricePerNight)} / nuit',
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  /// Nom
                  Text(
                    room.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: appColor,
                    ),
                  ),
                  const SizedBox(height: 2),

                  /// Étoiles + commentaires
                  Row(
                    children: [
                      Icon(Icons.star, color: appColorSecond, size: 10.sp),
                      const SizedBox(width: 4),
                      Text(
                        '${room.rating ?? '0'} • ${room.review} commentaire(s)',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: appColor,
                          fontWeight: FontWeight.w500,
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
    );
  }
}

/// CARD PROMO
class PromoCard extends StatelessWidget {
  final PromoModel promo;

  const PromoCard({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: promo.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          /// BADGE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: promo.badgeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              promo.badge,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Gap(1.w),

          /// TEXTE
          Expanded(
            child: Text(
              promo.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// CARD PROPRIÉTÉ
class PropertyCard extends StatelessWidget {
  final PropertyModel property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  property.image,
                  height: 15.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// RATING
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        property.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// INFO
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  property.location,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${property.price} FCFA',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: ' /nuit',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// MODÈLES
class PromoModel {
  final String badge;
  final String text;
  final List<Color> colors;
  final Color badgeColor;

  PromoModel({
    required this.badge,
    required this.text,
    required this.colors,
    required this.badgeColor,
  });
}

class PropertyModel {
  final String image;
  final String title;
  final String location;
  final double rating;
  final String price;

  PropertyModel({
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
    required this.price,
  });
}

/// DONNÉES
final List<PromoModel> promoList = [
  PromoModel(
    badge: 'Innovation',
    text: 'Découvrez nos nouveaux espaces coworking !',
    colors: [Colors.orange.shade400, Colors.orange.shade600],
    badgeColor: Colors.deepPurple,
  ),
  PromoModel(
    badge: 'Innovation',
    text: '-20 % de réduction sur votre première réservation',
    colors: [Colors.purple.shade600, Colors.purple.shade800],
    badgeColor: Colors.orange,
  ),
  PromoModel(
    badge: 'Nouveauté',
    text: 'Profitez de nos offres exclusives ce mois-ci',
    colors: [Colors.blue.shade400, Colors.blue.shade700],
    badgeColor: Colors.pink,
  ),
];

final List<PropertyModel> propertyList = [
  PropertyModel(
    image: 'assets/images/room1.png',
    title: 'Chambre standard',
    location: 'Abidjan, Cocody, riviera 3',
    rating: 4.8,
    price: '25 000',
  ),
  PropertyModel(
    image: 'assets/images/room2.jpg',
    title: 'Villa les palmiers',
    location: 'Abidjan, Grand-Bassam',
    rating: 4.5,
    price: '45 000',
  ),
  PropertyModel(
    image: 'assets/images/room3.png',
    title: 'Loft Abatta',
    location: 'Bongouville, Abatta',
    rating: 4.8,
    price: '20 000',
  ),
  PropertyModel(
    image: 'assets/images/room4.png',
    title: 'Studio Cosy',
    location: 'Abidjan, Yopougon, maroc',
    rating: 4.5,
    price: '15 000',
  ),
];
