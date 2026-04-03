import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'salle_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  ÉQUIPEMENTS BOISSONS & NOURRITURES — Étape 1/1
// ─────────────────────────────────────────
class EquipementsBoissonsPage extends StatefulWidget {
  const EquipementsBoissonsPage({super.key});

  @override
  State<EquipementsBoissonsPage> createState() =>
      _EquipementsBoissonsPageState();
}

class _EquipementsBoissonsPageState extends State<EquipementsBoissonsPage> {
  // ── RÉFRIGÉRATEUR ──
  bool _frigoEnabled = false;
  String? _typeFrigo;

  // ── MACHINE À CAFÉ / BOUILLOIRE / PLATEAU ──
  bool _cafeEnabled = true;
  String? _typeCafe;

  // ── AUTRES ──
  bool _autresEnabled = true;
  String? _typeAutres;
  final _preciserController = TextEditingController();

  // ── LISTES ──
  final List<String> _typesFrigo = [
    'Mini-réfrigérateur',
    'Réfrigérateur standard',
    'Réfrigérateur à deux portes',
    'Réfrigérateur américain (side-by-side)',
    'Réfrigérateur encastré',
    'Réfrigérateur à congélateur intégré',
    'Cave à vin / minibar à vin',
    'Minibar / réfrigérateur de chambre',
    'Réfrigérateur bar (avec serrure)',
    'Réfrigérateur connecté (Smart)',
    'Réfrigérateur sans givre (No Frost)',
    'Réfrigérateur solaire',
    'Réfrigérateur compact / portable',
    'Réfrigérateur de laboratoire',
    'Autre (préciser)',
  ];

  final List<String> _typesCafe = [
    'Machine à café à capsules (Nespresso, Dolce Gusto…)',
    'Machine à café à dosettes (Senseo, Tassimo…)',
    'Cafetière filtre / à percolateur',
    'Machine à café à grain (expresso automatique)',
    'Machine à expresso manuelle / semi-automatique',
    'Cafetière à piston (French press)',
    'Cafetière italienne (Moka)',
    'Cafetière turque / ibrik',
    'Machine à café soluble / instantané',
    'Machine à café connectée (Wi-Fi / Bluetooth)',
    'Bouilloire électrique standard',
    'Bouilloire à température variable',
    'Bouilloire isotherme / à maintien de chaleur',
    'Plateau de courtoisie (tasses, sachets de thé, sucre…)',
    'Distributeur de boissons chaudes',
    'Machine à chocolat chaud',
    'Théière électrique',
    'Autre (préciser)',
  ];

  final List<String> _typesAutres = [
    'Four micro-ondes',
    'Four classique / four encastré',
    'Grille-pain / toaster',
    'Cuisinière / plaques de cuisson',
    'Plaque à induction',
    'Plaque vitrocéramique',
    'Plaque gaz',
    'Extracteur de jus / centrifugeuse',
    'Blender / mixeur',
    'Presse-agrumes électrique',
    'Machine à pop-corn',
    'Machine à barbe à papa',
    'Machine à gaufres',
    'Crêpière électrique',
    'Grill électrique / plancha',
    'Friteuse (classique ou à air)',
    'Cuiseur à riz',
    'Cuiseur vapeur',
    'Fontaine à eau / distributeur d\'eau',
    'Machine à glace / glaçons',
    'Distributeur de boissons froides',
    'Autre (préciser)',
  ];

  @override
  void dispose() {
    _preciserController.dispose();
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── RÉFRIGÉRATEUR ──
                  _buildSectionTitle(
                    'Réfrigérateur',
                    _frigoEnabled,
                    (v) => setState(() => _frigoEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeFrigo,
                    items: _typesFrigo,
                    onChanged: (v) => setState(() => _typeFrigo = v),
                  ),

                  Gap(3.h),

                  // ── MACHINE À CAFÉ / BOUILLOIRE / PLATEAU ──
                  _buildSectionTitle(
                    'Machine à café /\nbouilloire / plateau',
                    _cafeEnabled,
                    (v) => setState(() => _cafeEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeCafe,
                    items: _typesCafe,
                    onChanged: (v) => setState(() => _typeCafe = v),
                  ),

                  Gap(3.h),

                  // ── AUTRES ──
                  _buildSectionTitle(
                    'Autres',
                    _autresEnabled,
                    (v) => setState(() => _autresEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeAutres,
                    items: _typesAutres,
                    onChanged: (v) => setState(() => _typeAutres = v),
                  ),

                  Gap(1.5.h),
                  _buildPreciserField(),
                  Gap(10.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildContinuerButton(),
    );
  }

  // ── HEADER ──
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 2.5.h),
      decoration: const BoxDecoration(
        color: kPurple,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    border: Border.all(color: kGold, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.chevron_left, color: kGold, size: 22),
                ),
              ),
              Gap(3.w),
              Expanded(
                child: Text(
                  'Équipements pour boissons\net nourritures',
                  style: TextStyle(
                    color: kGold,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          Gap(0.8.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Étape 1/1',
              style: TextStyle(color: kGold, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ── TITRE SECTION + TOGGLE ──
  Widget _buildSectionTitle(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: kPurple,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
        ),
        Gap(2.w),
        _PurpleToggle(value: value, onChanged: onChanged),
      ],
    );
  }

  // ── DROPDOWN ──
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            'sélectionner',
            style: TextStyle(color: Colors.black87, fontSize: 13.sp),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
          ),
          items: items
              .map(
                (t) => DropdownMenuItem(
                  value: t,
                  child: Text(
                    t,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ── CHAMP PRÉCISER ──
  Widget _buildPreciserField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _preciserController,
        maxLines: 6,
        style: TextStyle(fontSize: 13.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: 'Préciser',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
          filled: false,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 1.5.h,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // ── BOUTON CONTINUER ──
  Widget _buildContinuerButton() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: SizedBox(
          width: double.infinity,
          height: 6.5.h,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EquipementsSalleBainPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPurple,
              foregroundColor: kGold,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(
              'Continuer',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  TOGGLE VIOLET PERSONNALISÉ
// ─────────────────────────────────────────
class _PurpleToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PurpleToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 46,
        height: 26,
        decoration: BoxDecoration(
          color: value ? kPurple : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(13),
        ),
        padding: const EdgeInsets.all(3),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: kWhite,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
