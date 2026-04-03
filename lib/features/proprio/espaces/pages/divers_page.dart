import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'finale_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  DIVERS — Étape 1/1
// ─────────────────────────────────────────
class DiversPage extends StatefulWidget {
  const DiversPage({super.key});

  @override
  State<DiversPage> createState() => _DiversPageState();
}

class _DiversPageState extends State<DiversPage> {
  // ── DROPDOWNS avec toggle ──
  bool _balconEnabled = false;
  String? _typeBalcon;

  bool _fenetreEnabled = false;
  String? _typeFenetre;

  bool _bonusEnabled = false;
  String? _typeBonus;

  bool _jeuxEnabled = false;
  String? _typeJeux;

  bool _accesEnabled = false;
  String? _typeAcces;

  bool _vueEnabled = false;
  String? _typeVue;

  // ── INTERDITS DE LA CHAMBRE ──
  final Map<String, bool> _interdits = {
    'Interdit aux fumeurs': false,
    'Interdit aux animaux': false,
    'Interdit aux personnes du même sexe': false,
    'Interdit de faire du bruit après une certaine heure': false,
    "Interdit d'organiser des soirées": false,
    'Interdit de cuisiner certains aliments (forte odeur)': false,
    "Interdit d'utiliser certains équipements sans autorisation": false,
    'Autre': false,
  };
  final _preciserController = TextEditingController();

  // ── LISTES ──
  final List<String> _typesBalcon = [
    'Balcon privé',
    'Terrasse privée',
    'Balcon partagé',
    'Terrasse commune / rooftop',
    'Loggia',
    'Véranda',
    'Pergola',
    'Balcon avec vue mer',
    'Balcon avec vue montagne',
    'Balcon avec vue jardin',
    'Balcon avec vue piscine',
    'Terrasse avec jacuzzi',
    'Terrasse avec mobilier de jardin',
    'Terrasse avec barbecue',
    'Autre (préciser)',
  ];

  final List<String> _typesFenetre = [
    'Fenêtre simple vitrée',
    'Fenêtre double vitrage (isolation phonique)',
    'Fenêtre à guillotine',
    'Fenêtre à battants',
    'Fenêtre à soufflet / vasistas',
    'Fenêtre coulissante',
    'Fenêtre oscillo-battante',
    'Fenêtre avec volets intérieurs',
    'Fenêtre avec volets extérieurs',
    'Fenêtre avec volet roulant',
    'Fenêtre avec store intégré',
    'Fenêtre panoramique',
    'Baie vitrée',
    'Lucarne / fenêtre de toit',
    'Hublot décoratif',
    'Fenêtre sans vue (mur / cour intérieure)',
    'Fenêtre avec vue mer',
    'Fenêtre avec vue jardin',
    'Fenêtre avec vue ville',
    'Fenêtre teintée / anti-UV',
    'Fenêtre connectée (ouverture motorisée)',
    'Autre (préciser)',
  ];

  final List<String> _typesBonus = [
    'Fleurs / bouquet de bienvenue',
    'Panier de fruits offert',
    'Chocolats / sucreries de bienvenue',
    'Bouteille de vin / champagne',
    'Message de bienvenue personnalisé',
    'Cadeaux de bienvenue (savons, bougies…)',
    'Décoration romantique (pétales, bougies)',
    'Gâteau d\'anniversaire sur demande',
    'Bouteille d\'eau offerte',
    'Collations / snacks offerts',
    'Kit spa (sel de bain, huiles…)',
    'Livre d\'or / carte de bienvenue',
    'Surprise personnalisée sur demande',
    'Autre (préciser)',
  ];

  final List<String> _typesJeux = [
    'Jeux de société (Scrabble, Monopoly…)',
    'Jeux de cartes',
    'Échecs / dames / backgammon',
    'Puzzles',
    'Billard',
    'Baby-foot',
    'Ping-pong / tennis de table',
    'Fléchettes',
    'Console de jeux vidéo (PlayStation, Xbox…)',
    'Jeux de fléchettes magnétiques',
    'Jeu de quilles',
    'Jeu de billes / toupie',
    'Jeux éducatifs pour enfants',
    'Livres / bibliothèque en chambre',
    'Autre (préciser)',
  ];

  final List<String> _typesAcces = [
    'Accès plage privée',
    'Accès piscine commune',
    'Accès jacuzzi commun',
    'Accès sauna commun',
    'Accès hammam commun',
    'Accès salle de sport',
    'Accès spa',
    'Accès rooftop',
    'Accès jardin privatif',
    'Accès jardin commun',
    'Accès parking privé',
    'Accès parking commun',
    'Accès buanderie',
    'Accès cuisine commune',
    'Accès salle de réunion',
    'Accès terrasse commune',
    'Accès bibliothèque / salle de lecture',
    'Accès business center',
    'Accès aux transports (navette, vélo…)',
    'Autre (préciser)',
  ];

  final List<String> _typesVue = [
    'Vue sur mer / océan',
    'Vue sur lac',
    'Vue sur rivière / fleuve',
    'Vue sur montagne',
    'Vue sur jardin / parc',
    'Vue sur piscine',
    'Vue sur ville / skyline',
    'Vue sur cour intérieure',
    'Vue panoramique',
    'Vue sur forêt / nature',
    'Vue sur plage',
    'Vue sur patio',
    'Vue sur rue / boulevard',
    'Vue sur monument / site historique',
    'Vue dégagée (pas de vis-à-vis)',
    'Pas de vue particulière',
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
                  // ── BALCON ──
                  _buildDropdownSection(
                    title: 'Balcon ou terrasse',
                    enabled: _balconEnabled,
                    onToggle: (v) => setState(() => _balconEnabled = v),
                    value: _typeBalcon,
                    items: _typesBalcon,
                    onChanged: (v) => setState(() => _typeBalcon = v),
                  ),
                  Gap(2.5.h),

                  // ── FENÊTRE ──
                  _buildDropdownSection(
                    title: 'Fenêtre',
                    enabled: _fenetreEnabled,
                    onToggle: (v) => setState(() => _fenetreEnabled = v),
                    value: _typeFenetre,
                    items: _typesFenetre,
                    onChanged: (v) => setState(() => _typeFenetre = v),
                  ),
                  Gap(2.5.h),

                  // ── BONUS ──
                  _buildDropdownSection(
                    title: 'Bonus',
                    enabled: _bonusEnabled,
                    onToggle: (v) => setState(() => _bonusEnabled = v),
                    value: _typeBonus,
                    items: _typesBonus,
                    onChanged: (v) => setState(() => _typeBonus = v),
                  ),
                  Gap(2.5.h),

                  // ── JEUX D'INTÉRIEUR ──
                  _buildDropdownSection(
                    title: "Jeux d'intérieur",
                    enabled: _jeuxEnabled,
                    onToggle: (v) => setState(() => _jeuxEnabled = v),
                    value: _typeJeux,
                    items: _typesJeux,
                    onChanged: (v) => setState(() => _typeJeux = v),
                  ),
                  Gap(2.5.h),

                  // ── ACCÈS À ──
                  _buildDropdownSection(
                    title: 'Accès à',
                    enabled: _accesEnabled,
                    onToggle: (v) => setState(() => _accesEnabled = v),
                    value: _typeAcces,
                    items: _typesAcces,
                    onChanged: (v) => setState(() => _typeAcces = v),
                  ),
                  Gap(2.5.h),

                  // ── VUE SUR ──
                  _buildDropdownSection(
                    title: 'Vue sur',
                    enabled: _vueEnabled,
                    onToggle: (v) => setState(() => _vueEnabled = v),
                    value: _typeVue,
                    items: _typesVue,
                    onChanged: (v) => setState(() => _typeVue = v),
                  ),
                  Gap(3.h),

                  // ── INTERDITS DE LA CHAMBRE ──
                  _buildInterditsSection(),

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

  // ── SECTION DROPDOWN GÉNÉRIQUE ──
  Widget _buildDropdownSection({
    required String title,
    required bool enabled,
    required ValueChanged<bool> onToggle,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            _PurpleToggle(value: enabled, onChanged: onToggle),
          ],
        ),
        Gap(1.2.h),
        _buildDropdown(value: value, items: items, onChanged: onChanged),
      ],
    );
  }

  // ── SECTION INTERDITS ──
  Widget _buildInterditsSection() {
    final keys = _interdits.keys.toList();
    final normalKeys = keys.where((k) => k != 'Autre').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interdits de la chambre',
          style: TextStyle(
            color: kPurple,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(1.2.h),
        ...normalKeys.map(
          (k) => _CheckItem(
            label: k,
            value: _interdits[k]!,
            onChanged: (v) => setState(() => _interdits[k] = v!),
          ),
        ),
        _CheckItem(
          label: 'Autre',
          value: _interdits['Autre']!,
          onChanged: (v) => setState(() => _interdits['Autre'] = v!),
        ),
        Gap(1.h),
        _buildPreciserField(),
      ],
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
                'Divers',
                style: TextStyle(
                  color: kGold,
                  fontSize: 22.sp,
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
                MaterialPageRoute(
                  builder: (_) => FinalisationEnregistrementPage(),
                ),
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
//  TOGGLE VIOLET
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
