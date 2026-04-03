import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/models/abonnement_model.dart';
import 'package:opassage/services/abonne_service.dart';
import 'package:sizer/sizer.dart';

import '../premium.dart';

class PremiumSubscriptionScreen extends StatefulWidget {
  @override
  _PremiumSubscriptionScreenState createState() =>
      _PremiumSubscriptionScreenState();
}

class _PremiumSubscriptionScreenState extends State<PremiumSubscriptionScreen> {
  List<AbonnementModel> plans = [];
  AbonnementModel? selectedPlan;
  bool isLoading = true;

  late final DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    try {
      final result = await SubscriptionApi.fetchSubscriptions();
      setState(() {
        plans = result;
        selectedPlan = plans.isNotEmpty ? plans.first : null;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  int getDurationInMonths(String? durationType) {
    switch (durationType) {
      case 'monthly':
        return 1;
      case 'quarterly':
        return 3;
      case 'semiannual':
        return 6;
      case 'yearly':
        return 12;
      default:
        return 1;
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM', 'fr').format(date);
  }

  String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy', 'fr').format(date);
  }

  int get durationMonths {
    return getDurationInMonths(selectedPlan?.durationType);
  }

  DateTime get endDate {
    return DateTime(
      startDate.year,
      startDate.month + durationMonths,
      startDate.day,
    );
  }

  String formatPrice(String? price) {
    if (price == null) return '';

    final number = double.tryParse(price) ?? 0;
    final formatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: 'FCFA',
      decimalDigits: 0,
    );

    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FE),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Ma formule",
          style: TextStyle(color: appColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card Premium
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: appColorSecond,
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "PRIME",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: appColorSecond
                      ),
                    ),
                  ),
                  Gap(1.h),
                  Text(
                    "O'passeur Prime",
                    style: TextStyle(
                      color: appColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(1.h),
                  Text(
                    "Tu auras droit",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: appColor, fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Section Avantages
            _buildSectionTitle("Vos avantages exclusifs"),
            _buildBenefitItem(
              "Choix entre commande classique et commande expresse",
            ),
            _buildBenefitItem(
              "Réduction accordée dans les hôtels et résidences",
            ),
            _buildBenefitItem("Apparition des noms des établissements"),
            _buildBenefitItem("Traitement commande en priorité"),
            _buildBenefitItem("Etc"),

            Gap(1.h),

            // Section Formules
            _buildSectionTitle("Choisissez votre formule"),

            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: plans.map((plan) {
                  final isSelected =
                      selectedPlan?.idSubscriptionPlan ==
                      plan.idSubscriptionPlan;

                  return _buildPlanOption(plan, isSelected);
                }).toList(),
              ),

            SizedBox(height: 30),

            // Section Période de validité
            _buildSectionTitle("Période"),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.purple,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Durée Sélectionnée",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        getDurationLabel(selectedPlan?.durationType),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(height: 30),
                  Text(
                    formatMonthYear(startDate),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Valable du ${formatDate(startDate)} au ${formatDate(endDate)}",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Bouton de paiement
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: selectedPlan == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubscriptionSuccessScreen(),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                ),
                child: Text(
                  "Payer ${formatPrice(selectedPlan?.price)}",
                  style: TextStyle(
                    color: appColorSecond,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String getDurationLabel(String? type) {
    switch (type) {
      case 'monthly':
        return '1 Mois';
      case 'quarterly':
        return '3 Mois';
      case 'semiannual':
        return '6 Mois';
      case 'yearly':
        return '12 Mois';
      default:
        return '';
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: appColor,
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, color: appColor, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOption(AbonnementModel plan, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedPlan = plan),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
            color: isSelected ? appColorSecond : appColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              plan.name ?? '',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Text(
                  formatPrice(plan.price),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? appColor : Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
