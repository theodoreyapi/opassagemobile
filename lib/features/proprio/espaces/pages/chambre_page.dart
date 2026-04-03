import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'chambre_two_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  DÉTAIL CHAMBRES — Étape 1/2
// ─────────────────────────────────────────
class DetailChambreEtape1Page extends StatefulWidget {
  const DetailChambreEtape1Page({super.key});

  @override
  State<DetailChambreEtape1Page> createState() =>
      _DetailChambreEtape1PageState();
}

class _DetailChambreEtape1PageState extends State<DetailChambreEtape1Page> {
  // Type de chambre
  bool _typeChambreEnabled = true;
  String? _typeChambre;

  // Nombre de lit
  int _nbLits = 0;

  // Lit
  bool _litEnabled = false;
  String? _lit;

  // Canapé
  bool _canapeEnabled = false;
  String? _canape;

  // Armoire
  bool _armoireEnabled = false;
  String? _armoire;

  final List<String> _typesChambre = [
    'Chambre simple',
    'Chambre double',
    'Chambre twin',
    'Chambre triple',
    'Suite',
    'Suite junior',
    'Suite présidentielle',
    'Chambre familiale',
    'Studio',
    'Appartement',
  ];

  final List<String> _typesLit = [
    'Lit simple',
    'Lit double',
    'Grand lit (Queen)',
    'Très grand lit (King)',
    'Lits superposés',
    'Lit bébé / enfant',
    'Canapé-lit',
  ];

  final List<String> _typesCanape = [
    'Canapé simple',
    'Canapé double',
    'Canapé-lit 1 place',
    'Canapé-lit 2 places',
    'Méridienne',
  ];

  final List<String> _typesArmoire = [
    'Armoire avec portes',
    'Penderie ouverte',
    'Placard encastré',
    'Dressing',
    'Armoire avec coffre-fort',
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
                  // ── TYPE DE CHAMBRE ──
                  _buildSectionTitle(
                    'Type de chambre',
                    _typeChambreEnabled,
                    (v) => setState(() => _typeChambreEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typeChambre,
                    items: _typesChambre,
                    onChanged: (v) => setState(() => _typeChambre = v),
                  ),

                  Gap(3.h),

                  // ── NOMBRE DE LIT ──
                  Text(
                    'Nombre de lit',
                    style: TextStyle(
                      color: kPurple,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(1.2.h),
                  _buildCounter(),

                  Gap(3.h),

                  // ── LIT ──
                  _buildSectionTitle(
                    'Lit',
                    _litEnabled,
                    (v) => setState(() => _litEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _lit,
                    items: _typesLit,
                    onChanged: (v) => setState(() => _lit = v),
                  ),

                  Gap(3.h),

                  // ── CANAPÉ ──
                  _buildSectionTitle(
                    'Canapé ou canapé-lit',
                    _canapeEnabled,
                    (v) => setState(() => _canapeEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _canape,
                    items: _typesCanape,
                    onChanged: (v) => setState(() => _canape = v),
                  ),

                  Gap(3.h),

                  // ── ARMOIRE ──
                  _buildSectionTitle(
                    'Armoire / penderie / placard',
                    _armoireEnabled,
                    (v) => setState(() => _armoireEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _armoire,
                    items: _typesArmoire,
                    onChanged: (v) => setState(() => _armoire = v),
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
              'Étape 1/2',
              style: TextStyle(color: kGold, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ── TITRE DE SECTION + TOGGLE ──
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
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ── COMPTEUR NOMBRE DE LITS ──
  Widget _buildCounter() {
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
              _nbLits == 0 ? 'saisir' : '$_nbLits',
              style: TextStyle(
                fontSize: 13.sp,
                color: _nbLits == 0 ? Colors.black87 : Colors.black87,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _nbLits++),
            child: const _CircleBtn(icon: Icons.add),
          ),
          Gap(2.w),
          GestureDetector(
            onTap: () {
              if (_nbLits > 0) setState(() => _nbLits--);
            },
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
                MaterialPageRoute(builder: (_) => DetailChambreEtape2Page()),
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
