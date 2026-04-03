import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:opassage/features/proprio/espaces/pages/termine_page.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─── Catégories disponibles ───────────────────────────────────────────────────
enum HebergementCategorie {
  none,
  dayuse, // Repos/Dayuse (1H–2H–3H)
  demiJournee, // Demie (1/2) journée
  courtLong, // Court/Long séjour
}

// ─────────────────────────────────────────────────────────────────────────────
//  FINALISATION DE L'ENREGISTREMENT — Étape 1/2
// ─────────────────────────────────────────────────────────────────────────────
class FinalisationEnregistrementPage extends StatefulWidget {
  const FinalisationEnregistrementPage({super.key});

  @override
  State<FinalisationEnregistrementPage> createState() =>
      _FinalisationEnregistrementPageState();
}

class _FinalisationEnregistrementPageState
    extends State<FinalisationEnregistrementPage> {
  // ── PHOTOS ──
  final List<String?> _photos = [
    'asset_building', // 1 photo déjà ajoutée (simulée)
    null,
    null,
    null,
    null,
  ];

  // ── DESCRIPTION ──
  final _descController = TextEditingController();

  // ── CATÉGORIE ──
  HebergementCategorie _categorie = HebergementCategorie.none;

  // ── TARIFICATION DAYUSE : En semaine et week-end ──
  final Map<String, TextEditingController> _prixDayuse = {
    's1h': TextEditingController(),
    's2h': TextEditingController(),
    's3h': TextEditingController(),
    's4h': TextEditingController(),
    'w1h': TextEditingController(),
    'w2h': TextEditingController(),
    'w3h': TextEditingController(),
    'w4h': TextEditingController(),
  };

  // ── TARIFICATION DEMI-JOURNEE ──
  final Map<String, TextEditingController> _prixDemi = {
    's8_14': TextEditingController(),
    's14_20': TextEditingController(),
    'w8_14': TextEditingController(),
    'w14_20': TextEditingController(),
  };

  // ── TARIFICATION COURT/LONG ──
  final Map<String, TextEditingController> _prixCourt = {
    's1nuit': TextEditingController(),
    's2nuits': TextEditingController(),
    's3nuits': TextEditingController(),
    'sSemaine': TextEditingController(),
    'sMois': TextEditingController(),
    'w1nuit': TextEditingController(),
    'w2nuits': TextEditingController(),
    'w3nuits': TextEditingController(),
  };

  // ── RÉDUCTIONS ──
  final _reductionController = TextEditingController(text: '0');
  final String _periodeReduction = '10/06/25 - 10/07/25';

  // ── MODE DE COMMANDE ──
  String? _modeCommande;
  final List<String> _modesCommande = [
    'Réservation instantanée (Express)',
    'Réservation à confirmer',
    'Réservation manuelle',
  ];

  // ── DISPONIBILITÉ (calendrier) ──
  DateTime _focusedDay = DateTime(2025, 12, 1);
  final Set<DateTime> _selectedDays = {
    DateTime(2025, 12, 6),
    DateTime(2025, 12, 13),
    DateTime(2025, 12, 19),
    DateTime(2025, 12, 27),
  };

  // ── POLITIQUE D'ACCÈS ──
  String _heureAcces = '5 minutes avant le début de la période';

  // Court/Long séjour ajoute heure entrée/sortie
  final _heureEntreeController = TextEditingController(text: '11H00');
  final _heureSortieController = TextEditingController(text: '18H00');

  // ── POLITIQUE D'ANNULATION ──
  bool _fraisSup = false;
  final _fraisController = TextEditingController();

  // ── PAIEMENT ──
  bool _payLigne = false;
  bool _payPlace = false;
  bool _facturePro = false;

  @override
  void dispose() {
    _descController.dispose();
    _reductionController.dispose();
    _heureEntreeController.dispose();
    _heureSortieController.dispose();
    _fraisController.dispose();
    for (final c in [
      ..._prixDayuse.values,
      ..._prixDemi.values,
      ..._prixCourt.values,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  // ── POLITIQUE D'ANNULATION selon catégorie ──
  String get _texteAnnulation {
    switch (_categorie) {
      case HebergementCategorie.dayuse:
        return 'Possible jusqu\'à 15 min avant le début du séjour';
      case HebergementCategorie.demiJournee:
        return 'Possible jusqu\'à 30 min avant le début du séjour';
      case HebergementCategorie.courtLong:
        return 'Possible jusqu\'à 12 H avant le début du séjour';
      default:
        return 'Possible jusqu\'à 15 min avant le début du séjour';
    }
  }

  // ── HEURE D'ACCÈS label selon catégorie ──
  String get _labelHeureAcces {
    if (_categorie == HebergementCategorie.courtLong) return 'Nuitée';
    return 'Heure d\'accès';
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
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── PHOTOS ──
                  _buildSectionTitle('Ajouter des photos de l\'espace'),
                  _buildSubtitle('Au moins 5 photos sur tous les angles'),
                  Gap(1.5.h),
                  _buildPhotosButtons(),
                  Gap(1.5.h),
                  _buildPhotosGrid(),

                  Gap(2.5.h),

                  // ── DESCRIPTION ──
                  _buildSectionTitle('Ajouter une description'),
                  Gap(1.2.h),
                  _buildTextField(
                    controller: _descController,
                    hint: 'un petit texte accrocheur',
                    maxLines: 5,
                  ),

                  Gap(2.5.h),

                  // ── CATÉGORIE ──
                  _buildSectionTitle('Catégorie de l\'hébergement'),
                  Gap(1.2.h),
                  _buildCategorieDropdown(),

                  Gap(2.5.h),

                  // ── TARIFICATION (dynamique) ──
                  _buildSectionTitle('Tarification'),
                  Gap(1.2.h),
                  _buildTarification(),

                  Gap(2.5.h),

                  // ── MODE DE COMMANDE ──
                  _buildSectionTitle('Mode de commande'),
                  Gap(1.2.h),
                  _buildDropdown(
                    value: _modeCommande,
                    items: _modesCommande,
                    onChanged: (v) => setState(() => _modeCommande = v),
                  ),

                  Gap(2.5.h),

                  // ── DISPONIBILITÉ (seulement si Express) ──
                  if (_modeCommande == 'Réservation instantanée (Express)') ...[
                    Row(
                      children: [
                        _buildSectionTitle('Disponibilité'),
                        Gap(2.w),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: kGold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'CALENDRIER AFFICHE SI EXPRESS',
                            style: TextStyle(
                              color: kGold,
                              fontSize: 7.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(1.2.h),
                    _buildCalendrier(),
                    Gap(2.5.h),
                  ],

                  // ── POLITIQUE D'ACCÈS ──
                  _buildSectionTitle('Politique d\'accès'),
                  Gap(0.5.h),
                  Text(
                    _labelHeureAcces,
                    style: TextStyle(color: Colors.black54, fontSize: 11.sp),
                  ),
                  Gap(0.8.h),
                  _buildReadonlyField(_heureAcces),

                  // Heure entrée/sortie pour Court/Long séjour
                  if (_categorie == HebergementCategorie.courtLong) ...[
                    Gap(1.2.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Heure d\'entrée',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11.sp,
                                ),
                              ),
                              Gap(0.5.h),
                              _buildSmallTimeField(_heureEntreeController),
                            ],
                          ),
                        ),
                        Gap(4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Heure de sortie',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11.sp,
                                ),
                              ),
                              Gap(0.5.h),
                              _buildSmallTimeField(_heureSortieController),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],

                  Gap(2.5.h),

                  // ── POLITIQUE D'ANNULATION ──
                  _buildSectionTitle('Politique d\'annulation'),
                  Gap(1.2.h),
                  _buildReadonlyField(_texteAnnulation),
                  Gap(1.h),
                  _CheckItem(
                    label:
                        'Frais supplémentaires : ménage, électricité, restauration',
                    value: _fraisSup,
                    onChanged: (v) => setState(() => _fraisSup = v!),
                  ),
                  Gap(0.8.h),
                  _buildTextField(
                    controller: _fraisController,
                    hint: 'Décris les frais',
                    maxLines: 4,
                    italic: true,
                  ),

                  Gap(2.5.h),

                  // ── PAIEMENT ──
                  _buildSectionTitle('Paiement'),
                  Gap(1.h),
                  _CheckItem(
                    label: 'Paiement en ligne (Mobile Money / Djamo)',
                    value: _payLigne,
                    onChanged: (v) => setState(() => _payLigne = v!),
                  ),
                  _CheckItem(
                    label:
                        'Paiement sur place (Espèces / Mobile money / Carte Bancaire)',
                    value: _payPlace,
                    onChanged: (v) => setState(() => _payPlace = v!),
                  ),
                  _CheckItem(
                    label: 'Facture professionnelle disponible',
                    value: _facturePro,
                    onChanged: (v) => setState(() => _facturePro = v!),
                  ),

                  Gap(3.h),

                  // ── APPLIQUER UNE AUTRE CATÉGORIE ──
                  _buildAutreCategorie(),

                  Gap(2.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildTerminerButton(),
    );
  }

  // ─── HEADER ──────────────────────────────────────────────────────────────
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
                  'Finalisation de\nl\'enregistrement',
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
              'Étape 1/2',
              style: TextStyle(color: kGold, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ─── SECTION TITLE ───────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: kPurple,
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle(String text) {
    return Text(
      text,
      style: TextStyle(color: kGold, fontSize: 10.sp),
    );
  }

  // ─── PHOTOS ──────────────────────────────────────────────────────────────
  Widget _buildPhotosButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildPhotoBtn(
            Icons.camera_alt_outlined,
            'Prendre de nouvelles photos',
          ),
        ),
        Gap(3.w),
        Expanded(
          child: _buildPhotoBtn(Icons.upload_outlined, 'Ajoute des photos'),
        ),
      ],
    );
  }

  Widget _buildPhotoBtn(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Icon(icon, color: kPurple, size: 22),
          Gap(0.5.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.sp, color: kPurple),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosGrid() {
    return SizedBox(
      height: 13.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final hasPhoto = _photos[i] != null;
          return Container(
            width: 13.w,
            height: 13.w,
            decoration: BoxDecoration(
              color: hasPhoto
                  ? kPurple.withValues(alpha: 0.15)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: hasPhoto
                ? const Icon(Icons.apartment, color: kPurple)
                : null,
          );
        },
      ),
    );
  }

  // ─── CATÉGORIE DROPDOWN ──────────────────────────────────────────────────
  Widget _buildCategorieDropdown() {
    final Map<HebergementCategorie, String> labels = {
      HebergementCategorie.dayuse: 'Repos/Dayuse (1H- 2H - 3H)',
      HebergementCategorie.demiJournee: 'Demie (1/2) journée',
      HebergementCategorie.courtLong: 'Court/Long séjour',
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<HebergementCategorie>(
          value: _categorie == HebergementCategorie.none ? null : _categorie,
          hint: Text(
            'sélectionner',
            style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
          ),
          items: labels.entries
              .map(
                (e) => DropdownMenuItem(
                  value: e.key,
                  child: Text(
                    e.value,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => _categorie = v!),
        ),
      ),
    );
  }

  // ─── TARIFICATION DYNAMIQUE ───────────────────────────────────────────────
  Widget _buildTarification() {
    switch (_categorie) {
      case HebergementCategorie.dayuse:
        return _buildTarifDayuse();
      case HebergementCategorie.demiJournee:
        return _buildTarifDemi();
      case HebergementCategorie.courtLong:
        return _buildTarifCourt();
      default:
        return _buildTarifDayuse(); // par défaut
    }
  }

  // Dayuse : 1H/2H/3H/4H × semaine et week-end
  Widget _buildTarifDayuse() {
    final semaine = [
      ('1H', _prixDayuse['s1h']!),
      ('2 H', _prixDayuse['s2h']!),
      ('3 H', _prixDayuse['s3h']!),
      ('4 H', _prixDayuse['s4h']!),
    ];
    final weekend = [
      ('1H', _prixDayuse['w1h']!),
      ('2 H', _prixDayuse['w2h']!),
      ('3 H', _prixDayuse['w3h']!),
      ('4 H', _prixDayuse['w4h']!),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tarifLabel('En semaine'),
                  ...semaine.map((e) => _tarifRow(e.$1, e.$2)),
                ],
              ),
            ),
            Gap(3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tarifLabel('En week-end'),
                  ...weekend.map((e) => _tarifRow(e.$1, e.$2)),
                ],
              ),
            ),
          ],
        ),
        Gap(1.5.h),
        _buildReductionRow(),
      ],
    );
  }

  // Demi-journée : 8H-14H et 14H-20H × semaine et week-end
  Widget _buildTarifDemi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tarifLabel('En semaine'),
        _tarifRow('8 H - 14 H', _prixDemi['s8_14']!),
        _tarifRow('14 H - 20 H', _prixDemi['s14_20']!),
        Gap(1.h),
        _tarifLabel('En week-end'),
        _tarifRow('8 H - 14 H', _prixDemi['w8_14']!),
        _tarifRow('14 H - 20 H', _prixDemi['w14_20']!),
        Gap(1.5.h),
        _buildReductionRow(),
      ],
    );
  }

  // Court/Long séjour
  Widget _buildTarifCourt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tarifLabel('En semaine'),
        _tarifRow('1 nuitée', _prixCourt['s1nuit']!),
        _tarifRow('2 nuitées', _prixCourt['s2nuits']!),
        _tarifRow('3 nuitées', _prixCourt['s3nuits']!),
        _tarifRow('À partir 1 semaine', _prixCourt['sSemaine']!),
        _tarifRow('À partir 1 mois', _prixCourt['sMois']!),
        Gap(1.h),
        _tarifLabel('En week-end'),
        _tarifRow('1 nuitée', _prixCourt['w1nuit']!),
        _tarifRow('2 nuitées', _prixCourt['w2nuits']!),
        _tarifRow('3 nuitées', _prixCourt['w3nuits']!),
        Gap(1.5.h),
        _buildReductionRow(),
      ],
    );
  }

  Widget _tarifLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _tarifRow(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 11.w,
              child: Text(
                label,
                style: TextStyle(fontSize: 10.sp, color: Colors.black87),
              ),
            ),
            Expanded(
              child: TextField(
                controller: ctrl,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 10.sp, color: Colors.black54),
                decoration: InputDecoration(
                  hintText: 'saisir le prix',
                  hintStyle: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                ),
              ),
            ),
            Text(
              'Fcfa',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReductionRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Réductions accordée (%)',
                style: TextStyle(fontSize: 10.sp, color: Colors.black54),
              ),
              Gap(0.5.h),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _reductionController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 12.sp),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Du',
                style: TextStyle(fontSize: 10.sp, color: Colors.black54),
              ),
              Gap(0.5.h),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  _periodeReduction,
                  style: TextStyle(fontSize: 11.sp, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── CALENDRIER ──────────────────────────────────────────────────────────
  Widget _buildCalendrier() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(8),
      child: TableCalendar(
        firstDay: DateTime(2025, 1, 1),
        lastDay: DateTime(2026, 12, 31),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: false,
          titleTextStyle: TextStyle(
            color: kPurple,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
          leftChevronIcon: const Icon(Icons.chevron_left, color: kPurple),
          rightChevronIcon: const Icon(Icons.chevron_right, color: kPurple),
          headerPadding: const EdgeInsets.symmetric(vertical: 4),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: kPurple,
          ),
          weekendStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: kGold,
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          outsideTextStyle: TextStyle(
            color: kGold.withValues(alpha: 0.6),
            fontSize: 10.sp,
          ),
          defaultTextStyle: TextStyle(color: Colors.black87, fontSize: 10.sp),
          weekendTextStyle: TextStyle(color: Colors.black87, fontSize: 10.sp),
          selectedDecoration: const BoxDecoration(
            color: kPurple,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
          todayDecoration: BoxDecoration(
            color: kPurple.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(color: kPurple),
        ),
        selectedDayPredicate: (day) =>
            _selectedDays.any((d) => isSameDay(d, day)),
        onDaySelected: (selected, focused) {
          setState(() {
            _focusedDay = focused;
            if (_selectedDays.any((d) => isSameDay(d, selected))) {
              _selectedDays.removeWhere((d) => isSameDay(d, selected));
            } else {
              _selectedDays.add(selected);
            }
          });
        },
        onPageChanged: (focused) => setState(() => _focusedDay = focused),
      ),
    );
  }

  // ─── DROPDOWN GÉNÉRIQUE ───────────────────────────────────────────────────
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

  // ─── CHAMP READONLY ───────────────────────────────────────────────────────
  Widget _buildReadonlyField(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.4.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12.sp, color: Colors.black87),
      ),
    );
  }

  // ─── CHAMP TEXTE ──────────────────────────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    bool italic = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black87,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 13.sp,
            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          ),
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

  // ─── CHAMP HEURE (Court/Long séjour) ─────────────────────────────────────
  Widget _buildSmallTimeField(TextEditingController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: ctrl,
              style: TextStyle(fontSize: 12.sp),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const Icon(Icons.unfold_more, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  // ─── APPLIQUER UNE AUTRE CATÉGORIE ───────────────────────────────────────
  Widget _buildAutreCategorie() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: kPurple, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: kPurple),
            Gap(2.w),
            Text(
              'Appliquer une autre catégorie',
              style: TextStyle(
                color: kPurple,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── BOUTON TERMINER ─────────────────────────────────────────────────────
  Widget _buildTerminerButton() {
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
                MaterialPageRoute(builder: (_) => EnregistrementSuccessPage()),
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
              'Terminer l\'enregistrement',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
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
