import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'hotel_info_4_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  ÉTAPE 3 — Technologies, Commerces, Accessibilité, Sécurité
// ─────────────────────────────────────────
class EtablissementEtape3Page extends StatefulWidget {
  const EtablissementEtape3Page({super.key});

  @override
  State<EtablissementEtape3Page> createState() =>
      _EtablissementEtape3PageState();
}

class _EtablissementEtape3PageState extends State<EtablissementEtape3Page> {
  // ── TECHNOLOGIES & AFFAIRES ──
  bool _techEnabled = true;
  final Map<String, bool> _tech = {
    'Wi-Fi gratuit': false,
    'Salle de réunion': false,
    'Business center': false,
    'Service de traduction': false,
    'Salle de conférence': false,
    'Espace coworking': false,
    'Équipements audiovisuels': false,
    'Imprimante / photocopieur / fax': false,
  };

  // ── COMMERCES & COMMODITÉS ──
  bool _commercesEnabled = true;
  final Map<String, bool> _commerces = {
    'Boutique / mini-market': false,
    'Souvenir shop': false,
    'Bijouterie': false,
    'Salon de coiffure / beauté': false,
    'Distributeur automatique de billets': false,
    'Bureau de change': false,
  };

  // ── ACCESSIBILITÉ & CONFORT ──
  bool _accessEnabled = true;
  final Map<String, bool> _access = {
    'Ascenseur': false,
    'Espaces accessibles en fauteuil roulant': false,
    "Rampes d'accès": false,
    'Toilettes adaptées': false,
    'Signalétique en braille': false,
  };

  // ── SÉCURITÉ ──
  bool _secuEnabled = true;
  final Map<String, bool> _secu = {
    'Service de sécurité 24h/24': false,
    'Caméras de surveillance': false,
    'Coffre-fort à la réception': false,
    'Coffre-fort en chambre': false,
    'Détecteurs incendie / extincteurs': false,
    'Accès sécurisé par badge ou carte magnétique': false,
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
                  // Technologies & affaires
                  _EquipSection(
                    title: 'Technologies & affaires',
                    enabled: _techEnabled,
                    onToggle: (v) => setState(() => _techEnabled = v),
                    items: _tech,
                    onItemChanged: (k, v) => setState(() => _tech[k] = v),
                    twoColumns: true,
                    fullWidthKeys: const [
                      'Équipements audiovisuels',
                      'Imprimante / photocopieur / fax',
                    ],
                  ),

                  Gap(3.h),

                  // Commerces & commodités
                  _EquipSection(
                    title: 'Commerces & commodités',
                    enabled: _commercesEnabled,
                    onToggle: (v) => setState(() => _commercesEnabled = v),
                    items: _commerces,
                    onItemChanged: (k, v) => setState(() => _commerces[k] = v),
                    twoColumns: false,
                  ),

                  Gap(3.h),

                  // Accessibilité & confort
                  _EquipSection(
                    title: 'Accessibilité & confort',
                    enabled: _accessEnabled,
                    onToggle: (v) => setState(() => _accessEnabled = v),
                    items: _access,
                    onItemChanged: (k, v) => setState(() => _access[k] = v),
                    twoColumns: false,
                  ),

                  Gap(3.h),

                  // Sécurité
                  _EquipSection(
                    title: 'Sécurité',
                    enabled: _secuEnabled,
                    onToggle: (v) => setState(() => _secuEnabled = v),
                    items: _secu,
                    onItemChanged: (k, v) => setState(() => _secu[k] = v),
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
              'Étape 3/4',
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
                MaterialPageRoute(builder: (_) => EtablissementEtape4Page()),
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
          // Titre + toggle
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
              _PurpleToggle(value: enabled, onChanged: onToggle),
            ],
          ),
          Gap(1.2.h),

          // Items normaux
          if (twoColumns)
            _buildTwoColumns(normalKeys)
          else
            _buildSingleColumn(normalKeys),

          // Items pleine largeur
          ...fullKeys.map(
            (k) => _CheckItem(
              label: k,
              value: items[k]!,
              onChanged: (v) => onItemChanged(k, v!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoColumns(List<String> keys) {
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
            (k) => _CheckItem(
              label: k,
              value: items[k]!,
              onChanged: (v) => onItemChanged(k, v!),
            ),
          )
          .toList(),
    );
  }
}

// ─────────────────────────────────────────
//  TOGGLE VIOLET REMPLI (comme sur la maquette)
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
