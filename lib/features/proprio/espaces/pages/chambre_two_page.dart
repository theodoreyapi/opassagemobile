import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'confort_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  DÉTAIL CHAMBRES — Étape 2/2
// ─────────────────────────────────────────
class DetailChambreEtape2Page extends StatefulWidget {
  const DetailChambreEtape2Page({super.key});

  @override
  State<DetailChambreEtape2Page> createState() =>
      _DetailChambreEtape2PageState();
}

class _DetailChambreEtape2PageState extends State<DetailChambreEtape2Page> {
  // ── TABLE ──
  bool _tableEnabled = false;
  String? _typeTable;

  // ── NOMBRE DE CHAISE ──
  int _nbChaises = 0;

  // ── TYPE (chaise longue) ──
  String? _typeChaise;

  // ── FAUTEUIL ──
  bool _fauteuilEnabled = true;
  String? _typeFauteuil;

  // Listes options
  final List<String> _typesTable = [
    'Table de chevet',
    'Bureau / table de travail',
    'Table basse',
    'Coiffeuse / table à maquillage',
    "Table d'appoint / console",
    'Table pliante',
    'Table murale flottante',
    'Table à manger',
    'Table de nuit avec lampe',
    'Autre (préciser)',
  ];

  final List<String> _typesChaise = [
    'Chaise longue classique',
    'Méridienne avec accoudoir unique',
    'Méridienne double accoudoirs',
    'Chaise longue suspendue / balançoire',
    'Chaise longue pliante / portable',
    'Chaise longue convertible (avec rangement)',
    'Chaise longue design contemporain',
    'Chaise longue style scandinave',
    'Chaise longue capitonnée / Chesterfield',
    'Chaise longue en cuir',
    'Chaise longue en tissu / velours',
    'Chaise longue en bois massif',
    'Chaise longue modulable / sectionnelle',
    'Autre (préciser)',
  ];

  final List<String> _typesFauteuil = [
    'Fauteuil simple / standard',
    'Fauteuil lounge / relax',
    'Fauteuil club',
    'Fauteuil inclinable / relax électrique',
    "Fauteuil d'appoint / petit fauteuil",
    'Fauteuil pivotant / bureau',
    'Fauteuil double / love seat',
    'Fauteuil en cuir',
    'Fauteuil en tissu',
    'Fauteuil design / moderne',
    'Fauteuil berçant',
    'Fauteuil pliant',
    'Fauteuil canapé',
    'Autre (préciser)',
  ];

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
                  // ── TABLE ──
                  _buildSectionTitle(
                    'Table',
                    _tableEnabled,
                    (v) => setState(() => _tableEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeTable,
                    items: _typesTable,
                    onChanged: (v) => setState(() => _typeTable = v),
                  ),

                  Gap(3.h),

                  // ── NOMBRE DE CHAISE ──
                  Text(
                    'Nombre de chaise',
                    style: TextStyle(
                      color: kPurple,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(1.2.h),
                  _buildCounter(
                    value: _nbChaises,
                    onIncrement: () => setState(() => _nbChaises++),
                    onDecrement: () {
                      if (_nbChaises > 0) setState(() => _nbChaises--);
                    },
                  ),

                  Gap(3.h),

                  // ── TYPE (chaise longue) ──
                  Text(
                    'Type',
                    style: TextStyle(
                      color: kPurple,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeChaise,
                    items: _typesChaise,
                    onChanged: (v) => setState(() => _typeChaise = v),
                  ),

                  Gap(3.h),

                  // ── FAUTEUIL ──
                  _buildSectionTitle(
                    'Fauteuil',
                    _fauteuilEnabled,
                    (v) => setState(() => _fauteuilEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeFauteuil,
                    items: _typesFauteuil,
                    onChanged: (v) => setState(() => _typeFauteuil = v),
                  ),

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
                'Détail sur les chambres',
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
              'Étape 2/2',
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

  // ── COMPTEUR ──
  Widget _buildCounter({
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      width: 45.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value == 0 ? 'saisir' : '$value',
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: const _CircleBtn(icon: Icons.add),
          ),
          Gap(2.w),
          GestureDetector(
            onTap: onDecrement,
            child: const _CircleBtn(icon: Icons.remove),
          ),
        ],
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
                MaterialPageRoute(builder: (_) => ConfortLiterieePage()),
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

// ─────────────────────────────────────────
//  BOUTON CIRCULAIRE +/−
// ─────────────────────────────────────────
class _CircleBtn extends StatelessWidget {
  final IconData icon;

  const _CircleBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: const BoxDecoration(color: kPurple, shape: BoxShape.circle),
      child: Icon(icon, color: kWhite, size: 16),
    );
  }
}
