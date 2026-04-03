import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'divers_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  DÉCORATION ET AMBIANCE — Étape 1/1
// ─────────────────────────────────────────
class DecorationAmbiancePage extends StatefulWidget {
  const DecorationAmbiancePage({super.key});

  @override
  State<DecorationAmbiancePage> createState() => _DecorationAmbiancePageState();
}

class _DecorationAmbiancePageState extends State<DecorationAmbiancePage> {
  // ── MIROIRS ──
  bool _miroirsEnabled = false;
  String? _typeMiroir;

  // ── AUTRES ──
  String? _typeAutres;
  final _preciserController = TextEditingController();

  // ── LISTES ──
  final List<String> _typesMiroir = [
    'Miroir simple mural',
    'Miroir pleine longueur (pied)',
    'Miroir encadré (bois, métal, doré…)',
    'Miroir sans cadre / biseauté',
    'Miroir avec éclairage LED intégré',
    'Miroir anti-buée',
    'Miroir grossissant (x2, x5, x10…)',
    'Miroir double face (normal + grossissant)',
    'Miroir pivotant / orientable',
    'Miroir coiffeuse / maquillage',
    'Miroir de salle de bain encastré',
    'Miroir connecté / smart mirror',
    'Miroir avec tablette / rangement intégré',
    'Miroir décoratif (mosaïque, baroque…)',
    'Miroir panoramique',
    'Miroir de porte / coulissant',
    'Miroir soleil / rond décoratif',
    'Autre (préciser)',
  ];

  final List<String> _typesAutres = [
    'Tableau / œuvre d\'art',
    'Plante décorative (naturelle ou artificielle)',
    'Bouquet de fleurs / composition florale',
    'Bougie décorative / photophore',
    'Lampe d\'ambiance / lampadaire',
    'Guirlande lumineuse',
    'Éclairage indirect / spots décoratifs',
    'Tapis décoratif',
    'Coussin décoratif',
    'Rideau occultant décoratif',
    'Store vénitien / à lamelles',
    'Store enrouleur',
    'Baldaquin / ciel de lit',
    'Tête de lit décorative',
    'Papier peint / revêtement mural',
    'Horloge murale / pendule',
    'Statuette / objet de décoration',
    'Figurine / bibelot',
    'Cadre photo décoratif',
    'Vase décoratif',
    'Diffuseur de parfum / bougie parfumée',
    'Fontaine d\'intérieur décorative',
    'Plaid / jeté de lit décoratif',
    'Courtepointe / dessus de lit',
    'Revêtement de sol décoratif (parquet, carrelage…)',
    'Mur en pierre / brique apparente',
    'Faux plafond décoratif',
    'Luminaire design (suspension, applique…)',
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
                  // ── MIROIRS ──
                  _buildSectionTitle(
                    'Miroirs',
                    _miroirsEnabled,
                    (v) => setState(() => _miroirsEnabled = v),
                    showToggle: true,
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeMiroir,
                    items: _typesMiroir,
                    onChanged: (v) => setState(() => _typeMiroir = v),
                  ),

                  Gap(3.h),

                  // ── AUTRES (sans toggle) ──
                  _buildSectionTitle(
                    'Autres',
                    false,
                    (_) {},
                    showToggle: false,
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
                'Décoration et ambiance',
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

  // ── TITRE SECTION ──
  Widget _buildSectionTitle(
    String title,
    bool value,
    ValueChanged<bool> onChanged, {
    bool showToggle = true,
  }) {
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
            ),
          ),
        ),
        if (showToggle) ...[
          Gap(2.w),
          _PurpleToggle(value: value, onChanged: onChanged),
        ],
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
                MaterialPageRoute(builder: (_) => DiversPage()),
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
