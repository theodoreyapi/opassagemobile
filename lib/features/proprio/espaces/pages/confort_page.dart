import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'multimedia_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  CONFORT ET LITERIE — Étape 1/1
// ─────────────────────────────────────────
class ConfortLiterieePage extends StatefulWidget {
  const ConfortLiterieePage({super.key});

  @override
  State<ConfortLiterieePage> createState() => _ConfortLiterieePageState();
}

class _ConfortLiterieePageState extends State<ConfortLiterieePage> {
  // ── CLIMATISATION ──
  bool _climEnabled = false;
  String? _typeClim;

  // ── VENTILATEUR ──
  bool _venteEnabled = true;
  String? _typeVente;

  // ── AUTRES ──
  bool _autresEnabled = true;
  String? _typeAutres;
  final _preciserController = TextEditingController();

  // ── LISTES ──
  final List<String> _typesClim = [
    'Climatiseur de fenêtre',
    'Climatiseur monobloc',
    "Climatiseur à évaporation",
    'Climatiseur split mural',
    'Climatiseur split inverter',
    'Climatiseur multi-split',
    'Climatiseur cassette',
    'Climatiseur gainable',
    'Climatiseur centralisé',
    'Climatiseur portable',
    'Climatiseur réversible (froid / chaud)',
    'Climatiseur solaire',
    'Climatiseur connecté (Wi-Fi / Smart)',
    'Climatiseur mural design',
    'Climatiseur console',
    'Climatiseur VRV / VRF',
    'Climatiseur sans unité extérieure',
    'Climatiseur silencieux',
    'Climatiseur écologique (gaz R32 ou CO₂)',
  ];

  final List<String> _typesVente = [
    'Ventilateur sur pied',
    'Ventilateur de table / de bureau',
    'Ventilateur mural',
    'Ventilateur plafond / plafonnier',
    'Ventilateur tour / colonne',
    'Ventilateur brumisateur',
  ];

  final List<String> _typesAutres = [
    'Peignoirs',
    'Chaussons',
    'Rideaux ou voilages occultants',
    'Pantoufle',
    "Purificateur d'air",
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
                  // Titre de section principal
                  Text(
                    'Confort et literie',
                    style: TextStyle(
                      color: kPurple,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Gap(2.5.h),

                  // ── CLIMATISATION ──
                  _buildSectionTitle(
                    'Climatisation',
                    _climEnabled,
                    (v) => setState(() => _climEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeClim,
                    items: _typesClim,
                    onChanged: (v) => setState(() => _typeClim = v),
                  ),

                  Gap(3.h),

                  // ── VENTILATEUR ──
                  _buildSectionTitle(
                    'Ventilateur',
                    _venteEnabled,
                    (v) => setState(() => _venteEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeVente,
                    items: _typesVente,
                    onChanged: (v) => setState(() => _typeVente = v),
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

                  // Champ préciser
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text(
                'Confort et literie',
                style: TextStyle(
                  color: kGold,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
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
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: kPurple,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                MaterialPageRoute(builder: (_) => EquipementsMultimediaPage()),
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
