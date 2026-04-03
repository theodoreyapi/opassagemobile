import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'decoration_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  SÉCURITÉ ET SERVICE — Étape 1/1
// ─────────────────────────────────────────
class SecuriteServicePage extends StatefulWidget {
  const SecuriteServicePage({super.key});

  @override
  State<SecuriteServicePage> createState() => _SecuriteServicePageState();
}

class _SecuriteServicePageState extends State<SecuriteServicePage> {
  // ── PORTE ──
  bool _porteEnabled = false;
  String? _typePorte;

  // ── AUTRES ──
  bool _autresEnabled = false;
  String? _typeAutres;
  final _preciserController = TextEditingController();

  // ── LISTES ──
  final List<String> _typesPorte = [
    'Porte en bois massif',
    'Porte métallique / blindée',
    'Porte avec serrure à clé standard',
    'Porte avec serrure à carte magnétique',
    'Porte avec serrure à code / digicode',
    'Porte avec serrure connectée (smartphone)',
    'Porte avec serrure biométrique (empreinte)',
    'Porte avec verrou de sécurité intérieur',
    'Porte avec chaîne de sécurité',
    'Porte avec judas / œilleton',
    'Porte avec interphone / visiophone',
    'Porte coulissante',
    'Porte accordéon / pliante',
    'Porte vitrée sécurisée',
    'Porte avec alarme anti-intrusion',
    'Porte coupe-feu',
    'Porte automatique',
    'Porte avec ferme-porte automatique',
    'Autre (préciser)',
  ];

  final List<String> _typesAutres = [
    'Coffre-fort en chambre',
    'Détecteur de fumée',
    'Détecteur de monoxyde de carbone',
    'Extincteur',
    'Alarme incendie',
    'Sprinkler / système d\'extinction automatique',
    'Caméra de surveillance (couloir / extérieur)',
    'Interphone / visiophone de chambre',
    'Bouton d\'appel d\'urgence',
    'Kit de premiers secours',
    'Plan d\'évacuation affiché',
    'Éclairage de secours / veilleuse de nuit',
    'Volet roulant sécurisé',
    'Grille de sécurité (fenêtre)',
    'Garde-corps / rambarde (balcon)',
    'Antivol vélo / scooter',
    'Casier / consigne bagages sécurisé',
    'Trousse de secours',
    'Défibrillateur (AED) à proximité',
    'Numéro d\'urgence affiché en chambre',
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
                  // ── PORTE ──
                  _buildSectionTitle(
                    'Porte',
                    _porteEnabled,
                    (v) => setState(() => _porteEnabled = v),
                  ),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _typePorte,
                    items: _typesPorte,
                    onChanged: (v) => setState(() => _typePorte = v),
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
                'Sécurité et service',
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
                MaterialPageRoute(builder: (_) => DecorationAmbiancePage()),
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
