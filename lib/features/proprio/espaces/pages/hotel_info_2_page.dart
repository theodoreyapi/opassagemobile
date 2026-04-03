import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'hotal_info_3_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  ÉTAPE 2 — Équipements de l'établissement
// ─────────────────────────────────────────
class EtablissementEtape2Page extends StatefulWidget {
  const EtablissementEtape2Page({super.key});

  @override
  State<EtablissementEtape2Page> createState() =>
      _EtablissementEtape2PageState();
}

class _EtablissementEtape2PageState extends State<EtablissementEtape2Page> {
  // ── RESTAURATION ──
  bool _restaurationEnabled = false;
  final Map<String, bool> _restauration = {
    'Restaurant principal': false,
    'Snack-bar': false,
    'Bar': false,
    'Salon de thé': false,
    'Café': false,
    'Service banquet': false,
    'Room service': false,
    'Traiteur': false,
    'Petit-déjeuner': false,
    'Espace barbecue': false,
    'Distributeur automatique (boissons / snacks)': false,
  };

  // ── STATIONNEMENT & TRANSPORT ──
  bool _stationnementEnabled = false;
  final Map<String, bool> _stationnement = {
    'Parking gratuit': false,
    'Parking payant': false,
    'Parking sécurisé': false,
    'Parking surveillé': false,
    'Service voiturier': false,
    'Navette aéroport': false,
    'Garage couvert': false,
    'Navette ville': false,
    'Bornes de recharge pour voitures électriques': false,
    'Location de voitures': false,
    'Service de transport privé': false,
  };

  // ── SERVICES CLIENTS ──
  bool _servicesEnabled = false;
  final Map<String, bool> _services = {
    'Réception 24h/24': false,
    'Conciergerie': false,
    'Bagagerie': false,
    'Service de ménage quotidien': false,
    'Blanchisserie / pressing / repassage': false,
    'Service de nettoyage à sec': false,
    'Service de réveil': false,
    'Location de matériel (fer à repasser, adaptateur, parapluie, etc.)': false,
    'Service médical / infirmerie': false,
    "Garde d'enfants (baby-sitting)": false,
  };

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
                  // ── RESTAURATION ──
                  _EquipSection(
                    title: 'Restauration',
                    enabled: _restaurationEnabled,
                    onToggle: (v) => setState(() => _restaurationEnabled = v),
                    items: _restauration,
                    onItemChanged: (key, v) =>
                        setState(() => _restauration[key] = v),
                    twoColumns: true,
                    fullWidthKeys: const [
                      'Distributeur automatique (boissons / snacks)',
                    ],
                  ),

                  Gap(3.h),

                  // ── STATIONNEMENT ──
                  _EquipSection(
                    title: 'Stationnement & transport',
                    enabled: _stationnementEnabled,
                    onToggle: (v) => setState(() => _stationnementEnabled = v),
                    items: _stationnement,
                    onItemChanged: (key, v) =>
                        setState(() => _stationnement[key] = v),
                    twoColumns: true,
                    fullWidthKeys: const [
                      'Bornes de recharge pour voitures électriques',
                    ],
                  ),

                  Gap(3.h),

                  // ── SERVICES CLIENTS ──
                  _EquipSection(
                    title: 'Services clients',
                    enabled: _servicesEnabled,
                    onToggle: (v) => setState(() => _servicesEnabled = v),
                    items: _services,
                    onItemChanged: (key, v) =>
                        setState(() => _services[key] = v),
                    twoColumns: false,
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

  // ── HEADER VIOLET ──
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
              'Étape 2/4',
              style: TextStyle(color: kWhite, fontSize: 12.sp),
            ),
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
                MaterialPageRoute(builder: (_) => EtablissementEtape3Page()),
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
//  WIDGET SECTION ÉQUIPEMENTS
// ─────────────────────────────────────────
class _EquipSection extends StatelessWidget {
  final String title;
  final bool enabled;
  final ValueChanged<bool> onToggle;
  final Map<String, bool> items;
  final void Function(String key, bool value) onItemChanged;
  final bool twoColumns;
  final List<String> fullWidthKeys;

  const _EquipSection({
    required this.title,
    required this.enabled,
    required this.onToggle,
    required this.items,
    required this.onItemChanged,
    this.twoColumns = true,
    this.fullWidthKeys = const [],
  });

  @override
  Widget build(BuildContext context) {
    // Séparer les items pleine largeur des items normaux
    final normalKeys = items.keys
        .where((k) => !fullWidthKeys.contains(k))
        .toList();
    final fullKeys = items.keys
        .where((k) => fullWidthKeys.contains(k))
        .toList();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre + switch
          Row(
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
              Switch(
                value: enabled,
                onChanged: onToggle,
                activeColor: kPurple,
                inactiveThumbColor: Colors.grey.shade400,
                inactiveTrackColor: Colors.grey.shade300,
              ),
            ],
          ),

          Gap(1.h),

          // Items en 2 colonnes
          if (twoColumns) ...[
            _buildTwoColumnGrid(normalKeys),
          ] else ...[
            _buildSingleColumn(normalKeys),
          ],

          // Items pleine largeur
          ...fullKeys.map(
            (key) => _CheckItem(
              label: key,
              value: items[key]!,
              onChanged: (v) => onItemChanged(key, v!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoColumnGrid(List<String> keys) {
    // Grouper par paires
    final rows = <Widget>[];
    for (int i = 0; i < keys.length; i += 2) {
      final left = keys[i];
      final right = i + 1 < keys.length ? keys[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CheckItem(
                label: left,
                value: items[left]!,
                onChanged: (v) => onItemChanged(left, v!),
              ),
            ),
            if (right != null)
              Expanded(
                child: _CheckItem(
                  label: right,
                  value: items[right]!,
                  onChanged: (v) => onItemChanged(right, v!),
                ),
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildSingleColumn(List<String> keys) {
    return Column(
      children: keys
          .map(
            (key) => _CheckItem(
              label: key,
              value: items[key]!,
              onChanged: (v) => onItemChanged(key, v!),
            ),
          )
          .toList(),
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
