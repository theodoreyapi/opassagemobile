import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'hotel_info_2_page.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  PAGE PRINCIPALE
// ─────────────────────────────────────────
class HotelInfoPage extends StatefulWidget {
  const HotelInfoPage({super.key});

  @override
  State<HotelInfoPage> createState() => _HotelInfoPageState();
}

class _HotelInfoPageState extends State<HotelInfoPage> {
  int _selectedTab = 0; // 0 = Hôtel, 1 = Résidence meublé

  // Contrôleurs communs
  final _nomController = TextEditingController();
  final _villeController = TextEditingController();
  final _quartierController = TextEditingController();
  final _descController = TextEditingController();
  final _adresseController = TextEditingController();
  final _telController = TextEditingController();
  final _preciserController = TextEditingController();

  // Hôtel
  int _nbChambres = 0;

  // Résidence
  int _nbHebergements = 0;
  String? _typeHebergement;
  bool _autreChecked = false;

  final List<String> _typesHebergement = [
    'Appartement',
    'Studio',
    'Villa',
    'Duplex',
    'Maison',
    'Autre',
  ];

  // Équipements (Hôtel)
  final Map<String, bool> _equipements = {
    'Piscine extérieure': false,
    'Piscine intérieure': false,
    'Spa et centre de bien-être': false,
    'Hammam': false,
    'Sauna': false,
    'Bain à remous': false,
    'Jacuzzi': false,
    'Salle de fitness': false,
    'Salle de sport': false,
    'Salle de billard': false,
    'Espace de massage': false,
    'Salle TV commune': false,
    'Salon de beauté / coiffure': false,
    'Terrasse': false,
    'Salle de jeux': false,
    'Bar lounge': false,
    'Aire de jeux pour enfants': false,
    'Bar lounge ': false,
    'Jardin': false,
    'Salle TV commune ': false,
    'Cinéma privé': false,
  };

  @override
  void dispose() {
    _nomController.dispose();
    _villeController.dispose();
    _quartierController.dispose();
    _descController.dispose();
    _adresseController.dispose();
    _telController.dispose();
    _preciserController.dispose();
    super.dispose();
  }

  // ── BUILD ──
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTabSelector(),
                  Gap(2.5.h),
                  // Affiche la vue correspondante
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _selectedTab == 0
                        ? _buildHotelForm()
                        : _buildResidenceForm(),
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

  // ─────────────────────────────────────────
  //  FORMULAIRE HÔTEL
  // ─────────────────────────────────────────
  Widget _buildHotelForm() {
    return Column(
      key: const ValueKey('hotel'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nom de l'établissement"),
        Gap(0.8.h),
        _buildTextField('Ex les trois palmier', _nomController),
        Gap(2.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Ville'),
                  Gap(0.8.h),
                  _buildTextField('Ex Abidjan', _villeController),
                ],
              ),
            ),
            Gap(3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Quartier'),
                  Gap(0.8.h),
                  _buildTextField('Ex 7 ième Tranche', _quartierController),
                ],
              ),
            ),
          ],
        ),
        Gap(2.5.h),
        _buildLabel("Description de l'établissement"),
        Gap(0.8.h),
        _buildTextField(
          'Petit message accrocheur',
          _descController,
          maxLines: 5,
        ),
        Gap(2.5.h),
        _buildLabel('Ajoutez la localisation'),
        Gap(0.4.h),
        _buildLocalisationSubtitle(),
        Gap(1.h),
        _buildAdresseGPS(),
        Gap(2.5.h),
        _buildLabel("Nombre de chambre dans\nl'établissement"),
        Gap(1.h),
        _buildCounter(
          value: _nbChambres,
          onDecrement: () {
            if (_nbChambres > 0) setState(() => _nbChambres--);
          },
          onIncrement: () => setState(() => _nbChambres++),
        ),
        Gap(2.5.h),
        _buildLabel('Numéro de la réception /Établissement'),
        Gap(0.8.h),
        _buildTextField(
          '07 07 07 07 07',
          _telController,
          keyboardType: TextInputType.phone,
        ),
        Gap(2.5.h),
        _buildEquipementsSection(),
      ],
    );
  }

  // ─────────────────────────────────────────
  //  FORMULAIRE RÉSIDENCE
  // ─────────────────────────────────────────
  Widget _buildResidenceForm() {
    return Column(
      key: const ValueKey('residence'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nom de l'établissement"),
        Gap(0.8.h),
        _buildTextField('Ex les trois palmier', _nomController),
        Gap(2.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Ville'),
                  Gap(0.8.h),
                  _buildTextField('Ex Abidjan', _villeController),
                ],
              ),
            ),
            Gap(3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Quartier'),
                  Gap(0.8.h),
                  _buildTextField('Ex 7 ième Tranche', _quartierController),
                ],
              ),
            ),
          ],
        ),
        Gap(2.5.h),

        // Nombre d'hébergements (avant description dans résidence)
        _buildLabel("Nombre d'hébergements"),
        Gap(1.h),
        _buildCounter(
          value: _nbHebergements,
          onDecrement: () {
            if (_nbHebergements > 0) setState(() => _nbHebergements--);
          },
          onIncrement: () => setState(() => _nbHebergements++),
        ),
        Gap(2.5.h),

        _buildLabel("Description de l'établissement"),
        Gap(0.8.h),
        _buildTextField(
          'Petit message accrocheur',
          _descController,
          maxLines: 5,
        ),
        Gap(2.5.h),

        _buildLabel('Ajoutez la localisation'),
        Gap(0.4.h),
        _buildLocalisationSubtitle(),
        Gap(1.h),
        _buildAdresseGPS(),
        Gap(2.5.h),

        // Type d'hébergement
        _buildLabel("Type d'hébergement"),
        Gap(0.8.h),
        _buildDropdown(),
        Gap(2.5.h),

        // Numéro réception avec chevron
        _buildLabel('Numéro de la réception /Établissement'),
        Gap(0.8.h),
        _buildTextField(
          '07 07 07 07 07',
          _telController,
          keyboardType: TextInputType.phone,
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
          ),
        ),
        Gap(1.5.h),

        // Checkbox Autre + champ préciser
        Row(
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: _autreChecked,
                onChanged: (v) => setState(() => _autreChecked = v!),
                activeColor: kPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: Colors.grey.shade400),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            Gap(2.w),
            Text(
              'Autre',
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
          ],
        ),
        Gap(1.h),
        _buildTextField('Préciser', _preciserController, maxLines: 3),
      ],
    );
  }

  // ─────────────────────────────────────────
  //  WIDGETS COMMUNS
  // ─────────────────────────────────────────

  // Header violet
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
              'Étape 1/4',
              style: TextStyle(color: kWhite, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  // Tabs
  Widget _buildTabSelector() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _TabItem(
            label: 'Hôtel',
            selected: _selectedTab == 0,
            onTap: () => setState(() => _selectedTab = 0),
          ),
          _TabItem(
            label: 'Résidence meublé',
            selected: _selectedTab == 1,
            onTap: () => setState(() => _selectedTab = 1),
          ),
        ],
      ),
    );
  }

  // Label violet gras
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: kPurple,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // TextField générique
  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: kWhite,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kPurple, width: 1.5),
        ),
      ),
    );
  }

  // Sous-titre localisation
  Widget _buildLocalisationSubtitle() {
    return Text(
      'Assurer vous d\'être dans les locaux pour avoir\nla localisation exacte',
      style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
    );
  }

  // Adresse + GPS
  Widget _buildAdresseGPS() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField('Saisir l\'adresse', _adresseController),
        ),
        Gap(2.w),
        Container(
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: kPurple, size: 18),
              Gap(1.w),
              Text(
                'GPS',
                style: TextStyle(
                  color: kPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Compteur +/−
  Widget _buildCounter({
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value == 0 ? 'saisir' : '$value',
              style: TextStyle(
                fontSize: 13.sp,
                color: value == 0 ? Colors.grey.shade400 : Colors.black87,
              ),
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: _CounterBtn(icon: Icons.add),
          ),
          Gap(2.w),
          GestureDetector(
            onTap: onDecrement,
            child: _CounterBtn(icon: Icons.remove),
          ),
        ],
      ),
    );
  }

  // Dropdown type hébergement
  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _typeHebergement,
          hint: Text(
            'sélectionner',
            style: TextStyle(color: Colors.black87, fontSize: 13.sp),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
          ),
          items: _typesHebergement
              .map(
                (t) => DropdownMenuItem(
                  value: t,
                  child: Text(t, style: TextStyle(fontSize: 13.sp)),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => _typeHebergement = v),
        ),
      ),
    );
  }

  // Section équipements (Hôtel uniquement)
  Widget _buildEquipementsSection() {
    final keys = _equipements.keys.toList();
    final leftItems = [for (int i = 0; i < keys.length; i += 2) keys[i]];
    final rightItems = [for (int i = 1; i < keys.length; i += 2) keys[i]];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildLabel('Équipements généraux dans\nl\'établissement'),
            ),
            Switch(value: false, onChanged: (_) {}, activeThumbColor: kPurple),
          ],
        ),
        Gap(1.5.h),
        Text(
          'Loisirs & détente',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Gap(1.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: leftItems
                    .map(
                      (e) => _EquipementCheckbox(
                        label: e.trim(),
                        value: _equipements[e]!,
                        onChanged: (v) => setState(() => _equipements[e] = v!),
                      ),
                    )
                    .toList(),
              ),
            ),
            Gap(2.w),
            Expanded(
              child: Column(
                children: rightItems
                    .map(
                      (e) => _EquipementCheckbox(
                        label: e.trim(),
                        value: _equipements[e]!,
                        onChanged: (v) => setState(() => _equipements[e] = v!),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Bouton Continuer
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
                MaterialPageRoute(builder: (_) => EtablissementEtape2Page()),
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
//  WIDGETS HELPERS
// ─────────────────────────────────────────

class _TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? kPurple : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? kGold : Colors.grey.shade600,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _CounterBtn extends StatelessWidget {
  final IconData icon;

  const _CounterBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(color: kPurple, shape: BoxShape.circle),
      child: Icon(icon, color: kWhite, size: 16),
    );
  }
}

class _EquipementCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _EquipementCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
