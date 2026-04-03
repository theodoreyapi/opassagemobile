import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'chambre_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  ÉTAPE 4 — Autres services + Interdits + CGU
// ─────────────────────────────────────────
class EtablissementEtape4Page extends StatefulWidget {
  const EtablissementEtape4Page({super.key});

  @override
  State<EtablissementEtape4Page> createState() =>
      _EtablissementEtape4PageState();
}

class _EtablissementEtape4PageState extends State<EtablissementEtape4Page> {
  // ── AUTRES SERVICES ──
  bool _autresEnabled = true;
  final Map<String, bool> _autresServices = {
    'Animaux domestiques acceptés (selon politique)': false,
    "Service d'accueil multilingue": false,
    "Organisation d'excursions": false,
    'Location de vélos': false,
    "Organisation d'événements / mariages / séminaires": false,
    'Visites guidées': false,
    'Autre': false,
  };
  final _autresPreciserController = TextEditingController();

  // ── INTERDIT DE L'HÉBERGEMENT ──
  bool _interditEnabled = true;
  final Map<String, bool> _interdits = {
    'Interdit de fumer': false,
    'Animaux interdits': false,
    'Accès interdit aux mineurs non accompagnés': false,
    'Accès interdit aux visiteurs non-résidents': false,
    'Interdit de faire du bruit après une certaine heure': false,
    'Interdit de cuisiner dans les chambres': false,
    "Consommation d'alcool interdite en dehors des zones autorisées (bar, restaurant)":
        false,
    "Consommation d'alcool interdite": false,
    'Interdit de cuisiner dans les chambres ': false,
    'Autre': false,
  };
  final _interditPreciserController = TextEditingController();

  // ── CGU ──
  bool _cguAccepted = false;

  @override
  void dispose() {
    _autresPreciserController.dispose();
    _interditPreciserController.dispose();
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
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── AUTRES SERVICES ──
                  _buildAutresServices(),

                  Gap(3.h),

                  // ── INTERDIT DE L'HÉBERGEMENT ──
                  _buildInterdits(),

                  Gap(3.h),

                  // ── CGU ──
                  _buildCGU(),

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

  // ─────────────────────────────────────────
  //  SECTION AUTRES SERVICES
  // ─────────────────────────────────────────
  Widget _buildAutresServices() {
    final keys = _autresServices.keys.toList();
    final normalKeys = keys.where((k) => k != 'Autre').toList();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Autres services',
            _autresEnabled,
            (v) => setState(() => _autresEnabled = v),
          ),
          Gap(1.2.h),

          // Items normaux
          ...normalKeys.map(
            (k) => _CheckItem(
              label: k,
              value: _autresServices[k]!,
              onChanged: (v) => setState(() => _autresServices[k] = v!),
            ),
          ),

          // Checkbox Autre
          _CheckItem(
            label: 'Autre',
            value: _autresServices['Autre']!,
            onChanged: (v) => setState(() => _autresServices['Autre'] = v!),
          ),

          Gap(1.h),

          // Champ préciser
          _buildPreciserField(_autresPreciserController),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  //  SECTION INTERDITS
  // ─────────────────────────────────────────
  Widget _buildInterdits() {
    final keys = _interdits.keys.toList();
    final normalKeys = keys.where((k) => k != 'Autre').toList();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            "Interdit de l'hébergement",
            _interditEnabled,
            (v) => setState(() => _interditEnabled = v),
          ),
          Gap(1.2.h),

          // Items normaux
          ...normalKeys.map(
            (k) => _CheckItem(
              label: k,
              value: _interdits[k]!,
              onChanged: (v) => setState(() => _interdits[k] = v!),
            ),
          ),

          // Checkbox Autre
          _CheckItem(
            label: 'Autre',
            value: _interdits['Autre']!,
            onChanged: (v) => setState(() => _interdits['Autre'] = v!),
          ),

          Gap(1.h),

          // Champ préciser
          _buildPreciserField(_interditPreciserController),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  //  CGU
  // ─────────────────────────────────────────
  Widget _buildCGU() {
    return GestureDetector(
      onTap: () => setState(() => _cguAccepted = !_cguAccepted),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: _cguAccepted,
              onChanged: (v) => setState(() => _cguAccepted = v!),
              activeColor: kPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: kPurple, width: 1.5),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          Gap(3.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 12.sp, color: kPurple, height: 1.5),
                children: const [
                  TextSpan(
                    text:
                        "J'accepte les termes et conditions et je certifie que toutes les informations fournies sont exactes et véridique",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  //  WIDGETS PARTAGÉS
  // ─────────────────────────────────────────

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
                  'Informations générales sur\nl\'établissement',
                  style: TextStyle(
                    color: kGold,
                    fontSize: 18.sp,
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
              'Étape 4/4',
              style: TextStyle(color: kWhite, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
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
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _PurpleToggle(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildPreciserField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: 5,
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

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: kWhite,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildContinuerButton() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: SizedBox(
          width: double.infinity,
          height: 6.5.h,
          child: ElevatedButton(
            onPressed: _cguAccepted
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailChambreEtape1Page(),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPurple,
              foregroundColor: kGold,
              disabledBackgroundColor: kPurple.withValues(alpha: 0.5),
              disabledForegroundColor: kGold.withValues(alpha: 0.5),
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
//  CHECKBOX ITEM
// ─────────────────────────────────────────
class _CheckItem extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _CheckItem({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: kPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(color: Colors.grey.shade400),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
