import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/core/widgets/widgets.dart';
import 'package:opassage/features/proprio/transaction/transaction.dart';
import 'package:sizer/sizer.dart';

import '../../espaces/espaces.dart';
import '../../espaces/pages/list_espace_page.dart';
import '../../incentive/incentive.dart';

// ─────────────────────────────────────────
//  PAGE PRINCIPALE
// ─────────────────────────────────────────
class HomePageProprio extends StatefulWidget {
  const HomePageProprio({super.key});

  @override
  State<HomePageProprio> createState() => _HomePageProprioState();
}

class _HomePageProprioState extends State<HomePageProprio> {
  bool _balanceVisible = false;
  int _currentResidenceIndex = 0;
  final PageController _residenceController = PageController();
  Timer? _residenceTimer;

  final List<Map<String, String>> residences = [
    {
      'type': 'Résidence Meublée',
      'location': 'Cocody Riviera palmeraie',
      'image': 'assets/images/room1.png',
    },
    {
      'type': 'Hôtel',
      'location': 'Plateau, Centre-ville',
      'image': 'assets/images/room2.jpg',
    },
    {
      'type': 'Villa',
      'location': 'Grand-Bassam, Bord de mer',
      'image': 'assets/images/room3.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _residenceTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      setState(() {
        _currentResidenceIndex =
            (_currentResidenceIndex + 1) % residences.length;
      });
      _residenceController.animateToPage(
        _currentResidenceIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _residenceTimer?.cancel();
    _residenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildHeader(),
            _buildWalletCard(),
            Gap(2.h),
            _buildSectionTitle('Mes réalisations'),
            Gap(1.h),
            _buildStatsCard(),
            Gap(2.5.h),
            _buildSectionTitle('Actions rapides'),
            Gap(1.h),
            _buildActionsRapides(context),
            Gap(2.5.h),
            _buildResidenceCarousel(),
            Gap(2.5.h),
            _buildSectionTitle('Outils'),
            Gap(1.h),
            _buildOutils(),
            Gap(4.h),
          ],
        ),
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 6.h, left: 4.w, right: 4.w, bottom: 1.5.h),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.w),
          bottomRight: Radius.circular(10.w),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: const AssetImage('assets/images/djamo.jpg'),
                backgroundColor: Colors.grey.shade300,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: appColorSecond,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: appColorWhite, size: 12),
                ),
              ),
            ],
          ),
          Gap(3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bonjour Rach',
                  style: TextStyle(
                    color: appColorSecond,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star_border, color: appColorSecond, size: 16),
                    Gap(1.w),
                    Text(
                      'Hôte',
                      style: TextStyle(color: appColorSecond, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomePageProprio()),
              );
            },
            child: Icon(Icons.headset_mic_outlined, color: appColorSecond),
          ),
          Gap(3.w),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.notifications_none_outlined,
              color: appColorSecond,
            ),
          ),
          Gap(3.w),
          InkWell(
            onTap: () {},
            child: Icon(Icons.menu_outlined, color: appColorSecond),
          ),
        ],
      ),
    );
  }

  // ── WALLET CARD ──
  Widget _buildWalletCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(
                            () => _balanceVisible = !_balanceVisible,
                          ),
                          child: Icon(
                            _balanceVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: appColorSecond,
                            size: 20,
                          ),
                        ),
                        Gap(2.w),
                        Text(
                          _balanceVisible ? '125 000 FCFA' : '********* FCFA',
                          style: TextStyle(
                            color: appColorSecond,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Gap(0.8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: appColorSecond,
                          size: 14,
                        ),
                        Gap(1.w),
                        Text(
                          '+19% vs le mois dernier',
                          style: TextStyle(
                            color: appColorWhite,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '594',
                    style: TextStyle(
                      color: appColorSecond,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Détails >',
                    style: TextStyle(color: appColorSecond, fontSize: 15.sp),
                  ),
                ],
              ),
            ],
          ),
          Gap(1.h),
          Row(
            children: [
              Expanded(
                child: SubmitButtonIcon(
                  "Encaisser",
                  fontSize: 15.sp,
                  couleur: appColorWhite,
                  textcouleur: appColor,
                  height: 10.w,
                  onPressed: () {},
                  icone: Icon(Icons.add_outlined, color: appColor),
                ),
              ),
              Gap(2.w),
              Expanded(
                child: SubmitButtonIcon(
                  "Voir transactions",
                  fontSize: 13.5.sp,
                  couleur: appColorWhite,
                  textcouleur: appColor,
                  height: 10.w,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TransactionPage()),
                    );
                  },
                  icone: Icon(
                    Icons.flip_camera_android_outlined,
                    color: appColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── TITRE SECTION ──
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: appColorBlack,
        ),
      ),
    );
  }

  // ── STATS CARD (donut + badges) ──
  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: appColorFondCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: .center,
        children: [
          /// Donut chart
          SizedBox(
            width: 90,
            height: 90,
            child: CustomPaint(painter: _DonutPainter()),
          ),
          Gap(2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Statistiques Rach',
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'Cocody, Riviera 3',
                  style: TextStyle(color: appColorBlack, fontSize: 14.sp),
                ),
                Gap(1.2.h),
                Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Wrap(
                    spacing: 11,
                    runSpacing: 6,
                    children: [
                      _StatBadge(
                        '594',
                        Colors.purple.shade700,
                        'Réservations\nconfirmées',
                      ),
                      _StatBadge(
                        '420',
                        appColorSecond,
                        'Réservations\nfournies',
                      ),
                      _StatBadge('220', Colors.green, 'Commandes\nreçues'),
                      _StatBadge(
                        '102',
                        Colors.grey.shade500,
                        'Commandes\nAcceptées',
                      ),
                    ],
                  ),
                ),
                Gap(1.h),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: appColorBlack, fontSize: 15.sp),
                    children: [
                      TextSpan(text: "Taux d'acceptation : "),
                      TextSpan(
                        text: '68%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── ACTIONS RAPIDES ──
  // ── ACTIONS RAPIDES ──
  Widget _buildActionsRapides(BuildContext context) {
    final actions = [
      {
        'icon': Icons.calendar_month_outlined,
        'label': 'Voir mes\nréservations',
        'onTap': () {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => ReservationsPage()));
        },
      },
      {
        'icon': Icons.qr_code_scanner,
        'label': 'Scanner &\nencaisser',
        'onTap': () {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => ScannerPage()));
        },
      },
      {
        'icon': Icons.card_giftcard_outlined,
        'label': 'Incentives &\ngestion client',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => IncentivePage()),
          );
        },
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: actions
            .map(
              (a) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: a == actions.last ? 0 : 2.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: GestureDetector(
                    onTap: a['onTap'] as VoidCallback?,
                    child: Row(
                      children: [
                        Icon(
                          a['icon'] as IconData,
                          color: appColorSecond,
                          size: 22,
                        ),
                        Gap(2.w),
                        Expanded(
                          child: Text(
                            a['label'] as String,
                            style: TextStyle(
                              color: appColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // ── CARROUSEL RÉSIDENCES ──
  Widget _buildResidenceCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 14.h,
          child: PageView.builder(
            controller: _residenceController,
            onPageChanged: (i) => setState(() => _currentResidenceIndex = i),
            itemCount: residences.length,
            itemBuilder: (context, index) {
              final r = residences[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: appColorWhite,
                    borderRadius: BorderRadius.circular(3.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 3.w,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(3.w)),
                        child: Image.asset(
                          r['image']!,
                          width: 35.w,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 35.w,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Column(
                            crossAxisAlignment: .start,
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                r['type']!,
                                style: TextStyle(
                                  color: appColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Gap(0.5.h),
                              Text(
                                r['location']!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                                maxLines: 1,
                              ),
                              Gap(2.h),
                              SubmitButton(
                                height: 9.w,
                                fontSize: 15.sp,
                                'Gérer cette résidence',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Gap(1.2.h),
        Row(
          mainAxisAlignment: .center,
          children: List.generate(
            residences.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentResidenceIndex == i ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentResidenceIndex == i
                    ? appColor
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── OUTILS ──
  Widget _buildOutils() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  _OutilTile(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Wallet &\nbanque',
                  ),
                  Gap(4.w),
                  const Expanded(child: SizedBox()),
                  Gap(4.w),
                  _OutilTile(
                    icon: Icons.group_add_outlined,
                    label: 'Sous -\ncomptes',
                  ),
                ],
              ),
              Gap(1.5.h),
              Row(
                children: [
                  _OutilTile(
                    icon: Icons.home_outlined,
                    label: 'Liste des\nespaces',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListEspacePage(),
                        ),
                      );
                    },
                  ),
                  Gap(4.w),
                  const Expanded(child: SizedBox()),
                  Gap(4.w),
                  _OutilTile(
                    icon: Icons.add_home_outlined,
                    label: 'Ajouter un\nespace',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelInfoPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // Aide au centre
          _OutilTile(icon: Icons.help_outline, label: 'Aide', size: 16.w),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  WIDGETS HELPERS
// ─────────────────────────────────────────

class _StatBadge extends StatelessWidget {
  final String value;
  final Color color;
  final String label;

  const _StatBadge(this.value, this.color, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: appColorWhite,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
        Gap(1.w),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.sp,
            color: appColorBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _OutilTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final double? size;
  final VoidCallback? onTap;

  const _OutilTile({
    required this.icon,
    required this.label,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = size ?? 30.w;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w,
        height: 15.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Icon(icon, color: appColorSecond, size: 26),
            Gap(2.w),
            Text(
              label,
              style: TextStyle(
                color: appColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  DONUT CHART PAINTER
// ─────────────────────────────────────────
class _DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 18.0;
    final rect = Rect.fromCircle(
      center: center,
      radius: radius - strokeWidth / 2,
    );

    final segments = [
      (0.45, appColor),
      (0.28, appColorSecond),
      (0.15, Colors.green),
      (0.12, Colors.grey),
    ];

    double startAngle = -pi / 2;
    const gap = 0.04;

    for (final seg in segments) {
      final sweep = seg.$1 * 2 * pi - gap;
      final paint = Paint()
        ..color = seg.$2
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += seg.$1 * 2 * pi;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
