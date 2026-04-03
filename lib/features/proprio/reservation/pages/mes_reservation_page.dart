import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

final kPurple = appColor;
final kGold = appColorSecond;
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─── Onglets ──────────────────────────────────────────────────────────────────
enum ReservationTab { toutes, fournies, confirmees, recues, acceptees }

// ─── Types de badge catégorie ─────────────────────────────────────────────────
enum CategorieBadge { courtLong, dayuse, demi }

// ─── Actions possibles ────────────────────────────────────────────────────────
enum ActionType {
  attentePaiement, // violet → "En attente de paiement / confirmation"
  attenteConsomation, // violet → "En attente de consomation"
  disponible, // violet → "Disponible" + gold → "Indisponible"
  noter, // gold   → "Noter l'O'Passeur"
}

// ─── Modèle réservation ───────────────────────────────────────────────────────
class _Reservation {
  final String nomEtablissement;
  final CategorieBadge categorie;
  final String ville;
  final String description;
  final String periode;
  final String client;
  final String? grade; // Prime / Classic / Basic
  final String prix;
  final String? modePaiement; // "Wave" / "Djamo" / null
  final String emis;
  final ActionType action;
  final String? statut; // "Acceptée à 11h30" / "Confirmée à 11h30"
  final bool? paye; // badge "Payé"
  final String? reduction; // "30 % réduction"
  final ReservationTab tab;

  const _Reservation({
    required this.nomEtablissement,
    required this.categorie,
    required this.ville,
    required this.description,
    required this.periode,
    required this.client,
    this.grade,
    required this.prix,
    this.modePaiement,
    required this.emis,
    required this.action,
    this.statut,
    this.paye,
    this.reduction,
    required this.tab,
  });
}

// ─── Données ──────────────────────────────────────────────────────────────────
const _allData = [
  // ── TOUTES ──
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.courtLong,
    ville: 'Abidjan, Cocody',
    description: '02 chambres salon (3 pieces)',
    periode:
        'Climatiser, wifi, jakuzzi, réfrigérateur\ndu 18 Nov au 20 Nov 2026 (2 jours)',
    client: 'Marc KOUASSI',
    grade: 'Prime',
    prix: '25 000 FCFA',
    emis: 'Emis Aujourd\'hui à 09h50',
    action: ActionType.disponible,
    reduction: '30 % réduction',
    tab: ReservationTab.toutes,
  ),
  _Reservation(
    nomEtablissement: 'Hôtel du Bonheur',
    categorie: CategorieBadge.dayuse,
    ville: 'Abidjan, Cocody',
    description: '01 chambre salon (2 pieces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 22h - 01h (04 heures)',
    client: 'Rose KONATE',
    grade: 'Classic',
    prix: '15 000 FCFA',
    emis: 'Emis il y a  20 minutes',
    action: ActionType.noter,
    tab: ReservationTab.toutes,
  ),
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.demi,
    ville: 'Abidjan, Cocody',
    description: '01 chambre salon (2 pieces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 14h - 20h (06 heures)',
    client: 'Rose KONATE',
    grade: 'Basic',
    prix: '15 000 FCFA',
    emis: 'Emis il y a  20 minutes',
    action: ActionType.attentePaiement,
    tab: ReservationTab.toutes,
  ),

  // ── FOURNIES ──
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.courtLong,
    ville: 'Abidjan, Cocody',
    description: '02 chambres salon (03 pieces)',
    periode:
        'Climatiser, wifi, jakuzzi, réfrigérateur\ndu 18 Nov au 20 Nov 2026 (02 jours)',
    client: 'Marc KOUASSI',
    grade: 'Prime',
    prix: '50 000 FCFA',
    modePaiement: 'Wave',
    emis: 'Emis Aujourd\'hui à 09h50',
    action: ActionType.noter,
    reduction: '30 % réduction',
    tab: ReservationTab.fournies,
  ),
  _Reservation(
    nomEtablissement: 'Hôtel du Bonheur',
    categorie: CategorieBadge.dayuse,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pieces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 22h - 01h (04 heures)',
    client: 'Jean Marc',
    grade: 'Classic',
    prix: '30 000 FCFA',
    modePaiement: 'Djamo',
    emis: 'Emis Aujourd\'hui à 12h50',
    action: ActionType.noter,
    tab: ReservationTab.fournies,
  ),
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.demi,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pieces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 14h - 20h (06 heures)',
    client: 'Eddy MEKER',
    grade: 'Classic',
    prix: '60 000 FCFA',
    modePaiement: 'Djamo',
    emis: 'Emis Aujourd\'hui à 09h50',
    action: ActionType.noter,
    tab: ReservationTab.fournies,
  ),

  // ── CONFIRMÉES ──
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.courtLong,
    ville: 'Abidjan, Cocody',
    description: '02 chambres salon (03 pieces)',
    periode:
        'Climatiser, wifi, jakuzzi, réfrigérateur\ndu 18 Nov au 20 Nov 2026 (02 jours)',
    client: 'Marc KOUASSI',
    grade: 'Prime',
    prix: '50 000 FCFA',
    emis: 'Emis Aujourd\'hui à 09h50',
    action: ActionType.attenteConsomation,
    statut: 'Confirmée à 11h30',
    paye: true,
    tab: ReservationTab.confirmees,
  ),
  _Reservation(
    nomEtablissement: 'Hôtel du Bonheur',
    categorie: CategorieBadge.dayuse,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pièces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 22h - 01h (04 heures)',
    client: 'Jean Marc',
    grade: 'Classic',
    prix: '30 000 FCFA',
    emis: 'Emis Aujourd\'hui à 12h50',
    action: ActionType.attenteConsomation,
    statut: 'Confirmée à 14h30',
    paye: true,
    tab: ReservationTab.confirmees,
  ),
  _Reservation(
    nomEtablissement: 'Hôtel La Vie',
    categorie: CategorieBadge.demi,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pièces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 8h - 14h (06 heures)',
    client: 'Eddy MEKER',
    grade: 'Classic',
    prix: '60 000 FCFA',
    emis: 'Emis Aujourd\'hui à 10h00',
    action: ActionType.attenteConsomation,
    statut: 'Confirmée à 12h00',
    paye: true,
    tab: ReservationTab.confirmees,
  ),

  // ── REÇUES ──
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.courtLong,
    ville: 'Abidjan, Cocody',
    description: '02 chambres salon (03 pieces)',
    periode:
        'Climatiser, wifi, jakuzzi, réfrigérateur\ndu 18 Nov au 20 Nov 2026 (02 jours)',
    client: 'Marc KOUASSI',
    grade: 'Prime',
    prix: '50 000 FCFA',
    emis: 'Emis Aujourd\'hui à 09h50',
    action: ActionType.disponible,
    tab: ReservationTab.recues,
  ),
  _Reservation(
    nomEtablissement: 'Hôtel du Bonheur',
    categorie: CategorieBadge.dayuse,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pieces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 22h - 01h (04 heures)',
    client: 'Jean Marc',
    grade: 'Classic',
    prix: '30 000 FCFA',
    emis: 'Emis Aujourd\'hui à 12h50',
    action: ActionType.disponible,
    reduction: '30 % réduction',
    tab: ReservationTab.recues,
  ),
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.demi,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pieces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 14h - 20h (06 heures)',
    client: 'Eddy MEKER',
    grade: 'Classic',
    prix: '60 000 FCFA',
    emis: 'Emis Aujourd\'hui à 10h50',
    action: ActionType.disponible,
    tab: ReservationTab.recues,
  ),

  // ── ACCEPTÉES ──
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.courtLong,
    ville: 'Abidjan, Cocody',
    description: '02 chambres salon (03 pieces)',
    periode:
        'Climatiser, wifi, jakuzzi, réfrigérateur\ndu 18 Nov au 20 Nov 2026 (02 jours)',
    client: 'Marc KOUASSI',
    grade: 'Prime',
    prix: '50 000 FCFA',
    emis: 'Emis Aujourd\'hui à 09h50',
    action: ActionType.attentePaiement,
    statut: 'Acceptée à 11h30',
    tab: ReservationTab.acceptees,
  ),
  _Reservation(
    nomEtablissement: 'Résidence Olam',
    categorie: CategorieBadge.dayuse,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pieces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 22h - 01h (04 heures)',
    client: 'Jean Marc',
    grade: 'Classic',
    prix: '30 000 FCFA',
    emis: 'Emis Aujourd\'hui à 12h50',
    action: ActionType.attentePaiement,
    statut: 'Acceptée à 11h30',
    tab: ReservationTab.acceptees,
  ),
  _Reservation(
    nomEtablissement: 'Hôtel La Vie',
    categorie: CategorieBadge.demi,
    ville: 'Abidjan, Yopougon',
    description: '01 chambres salon (02 pièces)',
    periode:
        'Climatiser, wifi, réfrigérateur\n24 Dec 2026 de 8h - 14h (06 heures)',
    client: 'Eddy MEKER',
    grade: 'Classic',
    prix: '60 000 FCFA',
    emis: 'Emis Aujourd\'hui à 09h50',
    action: ActionType.attentePaiement,
    statut: 'Acceptée à 11h30',
    tab: ReservationTab.acceptees,
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
//  PAGE MES RÉSERVATIONS
// ─────────────────────────────────────────────────────────────────────────────
class MesReservationsPage extends StatefulWidget {
  const MesReservationsPage({super.key});

  @override
  State<MesReservationsPage> createState() => _MesReservationsPageState();
}

class _MesReservationsPageState extends State<MesReservationsPage> {
  ReservationTab _activeTab = ReservationTab.toutes;
  final _searchController = TextEditingController();

  // Compteurs par onglet
  int _count(ReservationTab tab) => _allData.where((r) => r.tab == tab).length;

  List<_Reservation> get _filtered =>
      _allData.where((r) => r.tab == _activeTab).toList();

  @override
  void dispose() {
    _searchController.dispose();
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.5.h,
                  ),
                  child: Column(
                    children: [_buildSearchBar(), Gap(1.5.h), _buildTabs()],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 0.5.h,
                    ),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => Gap(1.5.h),
                    itemBuilder: (_, i) =>
                        _ReservationCard(reservation: _filtered[i]),
                  ),
                ),
                Gap(1.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 2.5.h),
      decoration: BoxDecoration(
        color: kPurple,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        children: [
          Gap(3.w),
          Expanded(
            child: Text(
              'Mes réservations',
              style: TextStyle(
                color: kGold,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(Icons.notifications_none_rounded, color: kGold, size: 26),
          Gap(4.w),
          Icon(Icons.menu_rounded, color: kGold, size: 26),
        ],
      ),
    );
  }

  // ── BARRE RECHERCHE ──
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: 'Recherche',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 1.3.h),
              ),
            ),
          ),
        ),
        Gap(3.w),
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(
            Icons.filter_list_rounded,
            color: Colors.grey.shade500,
            size: 20,
          ),
        ),
      ],
    );
  }

  // ── ONGLETS ──
  Widget _buildTabs() {
    final tabs = [
      (ReservationTab.toutes, 'Toutes', _count(ReservationTab.toutes)),
      (ReservationTab.fournies, 'Fournies', _count(ReservationTab.fournies)),
      (
        ReservationTab.confirmees,
        'Confirmées',
        _count(ReservationTab.confirmees),
      ),
      (ReservationTab.recues, 'Reçues', _count(ReservationTab.recues)),
      (ReservationTab.acceptees, 'Acceptées', _count(ReservationTab.acceptees)),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((t) {
          final active = _activeTab == t.$1;
          return GestureDetector(
            onTap: () => setState(() => _activeTab = t.$1),
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: active ? kPurple : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    t.$2,
                    style: TextStyle(
                      color: active ? kPurple : Colors.black54,
                      fontSize: 12.sp,
                      fontWeight: active ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Gap(2.w),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: kPurple.withValues(alpha: .1),
                      border: Border.all(color: kPurple),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                    child: Text(
                      '${t.$3}',
                      style: TextStyle(
                        color: kPurple,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  CARD RÉSERVATION
// ─────────────────────────────────────────
class _ReservationCard extends StatelessWidget {
  final _Reservation reservation;

  const _ReservationCard({required this.reservation});

  @override
  Widget build(BuildContext context) {
    final r = reservation;
    return Container(
      decoration: BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + infos à droite
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                child: Container(
                  width: 35.w,
                  height: 38.w,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.apartment,
                    color: Colors.white54,
                    size: 36,
                  ),
                ),
              ),

              // Infos
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(2.5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom + badge catégorie
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              r.nomEtablissement,
                              style: TextStyle(
                                color: kPurple,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(1.w),
                          _CategorieBadgeWidget(r.categorie),
                        ],
                      ),
                      Gap(0.5.h),

                      // Détails bullet
                      _bullet(r.ville),
                      _bullet(r.description),
                      ...r.periode.split('\n').map(_bullet),

                      Gap(0.5.h),

                      // Statut (Acceptée / Confirmée)
                      if (r.statut != null)
                        Row(
                          children: [
                            Text(
                              r.statut!,
                              style: TextStyle(
                                color: kPurple,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (r.paye == true) ...[
                              Gap(2.w),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: kPurple),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Payé',
                                  style: TextStyle(
                                    color: kPurple,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                      // Client
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${r.client}${r.grade != null ? ' (${r.grade})' : ''}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (r.reduction != null)
                            _ReductionBadge(r.reduction!),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Footer: prix + action
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                // Prix + émis
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.modePaiement != null ? '${r.prix} Payé par' : r.prix,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (r.modePaiement != null)
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          children: [TextSpan(text: ' ${r.modePaiement}')],
                        ),
                      ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 10,
                          color: Colors.black38,
                        ),
                        Gap(1.w),
                        Text(
                          r.emis,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                _ActionWidget(r.action),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(color: Colors.black54, fontSize: 9.sp),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.black54, fontSize: 9.sp),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Badge catégorie ──────────────────────────────────────────────────────────
class _CategorieBadgeWidget extends StatelessWidget {
  final CategorieBadge cat;

  const _CategorieBadgeWidget(this.cat);

  @override
  Widget build(BuildContext context) {
    String label;
    switch (cat) {
      case CategorieBadge.courtLong:
        label = 'Court/Long séjour';
        break;
      case CategorieBadge.dayuse:
        label = 'Repos/Dayuse\n(1H- 2H - 3H)';
        break;
      case CategorieBadge.demi:
        label = 'Demie (1/2) journée';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: kGold,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kPurple,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ─── Badge réduction ─────────────────────────────────────────────────────────
class _ReductionBadge extends StatelessWidget {
  final String label;

  const _ReductionBadge(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: kPurple,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: kGold,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ─── Widget action (footer) ───────────────────────────────────────────────────
class _ActionWidget extends StatelessWidget {
  final ActionType action;

  const _ActionWidget(this.action);

  @override
  Widget build(BuildContext context) {
    switch (action) {
      case ActionType.attentePaiement:
        return _purpleBtn(
          Icons.credit_card_outlined,
          'En attente de paiement / confirmation',
        );
      case ActionType.attenteConsomation:
        return _purpleBtn(null, 'En attente de consomation');
      case ActionType.noter:
        return _goldBtn();
      case ActionType.disponible:
        return Row(
          children: [
            _miniBtn('✓ Disponible', kPurple, kWhite),
            Gap(2.w),
            _miniBtn('✕ Indisponible', kGold, kPurple),
          ],
        );
    }
  }

  Widget _purpleBtn(IconData? icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: kPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: kGold, size: 13),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: kGold,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _goldBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: kGold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_border_rounded, color: kPurple, size: 13),
          SizedBox(width: 4),
          Text(
            "Noter l'O'Passeur",
            style: TextStyle(
              color: kPurple,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniBtn(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontSize: 8, fontWeight: FontWeight.bold),
      ),
    );
  }
}
