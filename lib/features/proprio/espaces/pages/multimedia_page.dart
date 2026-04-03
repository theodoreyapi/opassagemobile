import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'boisson_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  ÉQUIPEMENTS MULTIMÉDIAS — Étape 1/1
// ─────────────────────────────────────────
class EquipementsMultimediaPage extends StatefulWidget {
  const EquipementsMultimediaPage({super.key});

  @override
  State<EquipementsMultimediaPage> createState() =>
      _EquipementsMultimediaPageState();
}

class _EquipementsMultimediaPageState extends State<EquipementsMultimediaPage> {
  // ── TÉLÉVISION ──
  bool _tvEnabled = false;
  String? _typeTv;

  // ── MATÉRIEL DE REPASSAGE ──
  bool _repassageEnabled = true;
  String? _typeRepassage;

  // ── AUTRES ──
  bool _autresEnabled = true;
  String? _typeAutres;
  final _preciserController = TextEditingController();

  // ── LISTES ──
  final List<String> _typesTv = [
    'Télévision LCD',
    'Télévision LED',
    'Télévision OLED',
    'Télévision QLED',
    'Télévision Plasma',
    'Télévision UHD / 4K',
    'Télévision Full HD',
    'Télévision Smart TV (connectée)',
    'Télévision Android TV',
    'Télévision à écran plat',
    'Télévision incurvée',
    'Télévision murale',
    'Télévision sur pied',
    'Télévision pivotante',
    'Télévision avec port USB / HDMI',
    'Télévision avec chaînes satellite',
    'Télévision avec Chromecast intégrée',
    'Télévision connectée au câble',
    'Télévision 8K',
    'Télévision mini LED',
    'Autre (préciser)',
  ];

  final List<String> _typesRepassage = [
    'Fer à repasser',
    'Planche à repasser',
    'Fer à vapeur',
    'Centre de repassage vapeur',
    'Défroisseur vapeur',
    'Presse à repasser',
    'Autre (préciser)',
  ];

  final List<String> _typesAutres = [
    'Téléphone fixe',
    'Wi-Fi haut débit',
    'Prises USB / multiprise',
    'Réveil connecté / enceinte',
    'Lecteur DVD / Blu-ray',
    'Console de jeux',
    'Projecteur',
    'Système de son / enceinte Bluetooth',
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
                  // ── TÉLÉVISION ──
                  _buildSectionTitle(
                    'Télévision',
                    _tvEnabled,
                    (v) => setState(() => _tvEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeTv,
                    items: _typesTv,
                    onChanged: (v) => setState(() => _typeTv = v),
                  ),

                  Gap(3.h),

                  // ── MATÉRIEL DE REPASSAGE ──
                  _buildSectionTitle(
                    'Matériel de repassage',
                    _repassageEnabled,
                    (v) => setState(() => _repassageEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeRepassage,
                    items: _typesRepassage,
                    onChanged: (v) => setState(() => _typeRepassage = v),
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
                  'Équipements multimédias\net connectivité',
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
                MaterialPageRoute(builder: (_) => EquipementsBoissonsPage()),
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
