import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

const kBg = Color(0xFFF2F2F7);

// ─── Modèle ───────────────────────────────────────────────────────────────────
class _Espace {
  final String nom;
  final String residence;
  final String localisation;
  final String prix;
  final List<String> equips;
  final String capacite;
  final bool sponsorise;

  const _Espace({
    required this.nom,
    required this.residence,
    required this.localisation,
    required this.prix,
    required this.equips,
    required this.capacite,
    required this.sponsorise,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
//  LISTE DES ESPACES ET DES HÉBERGEMENTS
// ─────────────────────────────────────────────────────────────────────────────
class ListEspacePage extends StatefulWidget {
  const ListEspacePage({super.key});

  @override
  State<ListEspacePage> createState() => _ListEspacePageState();
}

class _ListEspacePageState extends State<ListEspacePage> {
  final _searchController = TextEditingController();

  final List<_Espace> _espaces = const [
    _Espace(
      nom: 'Chambre Standard',
      residence: 'Résidence Palmier',
      localisation: 'Cocody Riviera palmeraie',
      prix: '50 000 FCFA / nuit',
      equips: ['Chauffe eau', 'Jacuzzi', 'Wifi', 'TV', 'Climatiseur'],
      capacite: '2 adultes : 1 lit double',
      sponsorise: true,
    ),
    _Espace(
      nom: 'Chambre Standard',
      residence: 'Résidence Caillet',
      localisation: 'Yopougon, Maroc',
      prix: '5000 FCFA / heure',
      equips: ['Chauffe eau', 'Jacuzzi', 'Wifi', 'TV', 'Climatiseur'],
      capacite: '2 adultes : 1 lit double',
      sponsorise: false,
    ),
    _Espace(
      nom: 'Chambre Standard',
      residence: 'Résidence Ma vie',
      localisation: 'Yopougon, Maroc',
      prix: '50 000 FCFA / nuit',
      equips: ['Chauffe eau', 'Jacuzzi', 'Wifi', 'TV', 'Climatiseur'],
      capacite: '2 adultes : 1 lit double',
      sponsorise: true,
    ),
    _Espace(
      nom: 'Studio Américain',
      residence: 'Résidence Palmier',
      localisation: 'Cocody Riviera palmeraie',
      prix: '50 000 FCFA / nuit',
      equips: ['Chauffe eau', 'Jacuzzi', 'Wifi', 'TV', 'Climatiseur'],
      capacite: '2 adultes : 1 lit double',
      sponsorise: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              itemCount: _espaces.length + 1,
              itemBuilder: (context, index) {

                /// Premier élément = barre de recherche
                if (index == 0) {
                  return Column(
                    children: [
                      _buildSearchBar(),
                      Gap(2.h),
                    ],
                  );
                }

                final espace = _espaces[index - 1];

                return Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: _EspaceCard(espace: espace),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 3.h),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: appColorSecond, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.chevron_left, color: appColorSecond, size: 22),
            ),
          ),
          Gap(3.w),
          Expanded(
            child: Text(
              'Liste des espaces et des\nhébergements',
              style: TextStyle(
                color: appColorSecond,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── BARRE DE RECHERCHE ──
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: 'Recherche',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 1.4.h),
              ),
            ),
          ),
        ),
        Gap(3.w),
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(
            Icons.filter_list_rounded,
            color: Colors.grey.shade500,
            size: 20,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
//  CARD ESPACE
// ─────────────────────────────────────────
class _EspaceCard extends StatelessWidget {
  final _Espace espace;

  const _EspaceCard({required this.espace});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: appColorWhite,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(3.w),
                ),
                child: Image.asset(
                  "assets/images/room1.png",
                  width: double.infinity,
                  height: 22.h,
                  fit: BoxFit.cover,
                ),
              ),

              /// Nom résidence
              Positioned(
                left: 3.w,
                bottom: 2.h,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Text(
                    espace.residence,
                    style: TextStyle(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              /// Badge sponsorisé
              if (espace.sponsorise)
                Positioned(
                  top: 1.5.h,
                  right: 3.w,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Text(
                      "Sponsorisé",
                      style: TextStyle(
                        color: appColorSecond,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /// CONTENU
          Padding(
            padding: EdgeInsets.all(3.5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Nom espace
                Text(
                  espace.nom,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                ),

                Gap(.6.h),

                /// localisation
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: appColor,
                    ),
                    Gap(1.w),
                    Expanded(
                      child: Text(
                        espace.localisation,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(1.h),

                /// prix
                Text(
                  espace.prix,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                ),

                Gap(1.h),

                /// équipements
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: espace.equips
                      .map((e) => _EquipChip(label: e))
                      .toList(),
                ),

                Gap(1.h),

                /// capacité
                Text(
                  espace.capacite,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Gap(1.2.h),

                /// ACTIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// détails
                    _actionButton(
                      icon: Icons.help_outline_outlined,
                      label: "Détails",
                      onTap: () {},
                    ),

                    /// modifier
                    _actionButton(
                      icon: Icons.edit_outlined,
                      label: "Modifier",
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: .9.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: appColor),
            Gap(1.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: appColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  CHIP ÉQUIPEMENT
// ─────────────────────────────────────────
class _EquipChip extends StatelessWidget {
  final String label;

  const _EquipChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: appColorSecond,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
