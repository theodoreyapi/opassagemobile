import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      // Fond gris très clair comme sur l'image
      body: SingleChildScrollView(
        child: Column(
          children: [_buildTopSection(), _buildTransactionsSection()],
        ),
      ),
    );
  }

  // Combine le header et la carte avec un fond violet qui déborde
  Widget _buildTopSection() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 2.5.h),
          decoration: BoxDecoration(
            color: appColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Row(
            children: [
              Gap(3.w),
              Expanded(
                child: Text(
                  'Mon Wallet',
                  style: TextStyle(
                    color: appColorSecond,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.notifications_none_rounded,
                color: appColorSecond,
                size: 26,
              ),
              Gap(4.w),
              Icon(Icons.menu_rounded, color: appColorSecond, size: 26),
            ],
          ),
        ),
        _walletCard(),
      ],
    );
  }

  Widget _walletCard() {
    return Container(
      margin: EdgeInsets.all(3.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: appColor,
        // Violet légèrement différent ou sombre
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Compte courant",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          Gap(1.h),
          Row(
            children: [
              Text(
                "560 000 FCFA",
                style: TextStyle(
                  color: appColorSecond,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(2.w),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Gap(1.h),
          Row(
            crossAxisAlignment: .end,
            children: [
              // Statistiques Avril/Mai
              Column(
                crossAxisAlignment: .start,
                children: [
                  _statRow("Avril : 300 000 FCFA", "↗ +19%", Colors.green),
                  Gap(.5.w),
                  _statRow("Mai : 250 000 FCFA", "↘ -8%", Colors.red),
                ],
              ),
              const Spacer(),
              // Bouton Retrait
              Column(
                crossAxisAlignment: .end,
                children: [
                  SizedBox(
                    height: 3.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColorSecond,
                        foregroundColor: appColor,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                      ),
                      child: Text(
                        "+ Demande de retrait",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Gap(.5.h),
                  GestureDetector(
                    onTap: (){},
                    child: Text(
                      "Information retour de fond >",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statRow(String label, String percent, Color color) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
        const SizedBox(width: 5),
        Text(
          percent,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transactions récentes",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: appColor,
            ),
          ),
          const SizedBox(height: 15),
          // Barre de recherche
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Recherche",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.w),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: const Icon(Icons.tune, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Liste blanche
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                _transactionItem(
                  Icons.card_giftcard,
                  "Avantage commercial",
                  "+ 500 FCFA",
                  "Bonus Akwaba",
                  isPositive: true,
                ),
                _transactionItem(
                  Icons.card_giftcard,
                  "Avantage commercial",
                  "+ 1 000 FCFA",
                  "Ristourne Réalisation",
                  isPositive: true,
                ),
                _transactionItem(
                  Icons.card_giftcard,
                  "Avantage commercial",
                  "+ 10 000 FCFA",
                  "Parrainage O'Passage",
                  isPositive: true,
                ),
                _transactionItem(
                  Icons.account_balance_wallet,
                  "Demande de retrait",
                  "- 100 000 FCFA",
                  "Retrait de Fond",
                  isPositive: false,
                ),
                _transactionItem(
                  Icons.history,
                  "Retour de fond",
                  "- 25 000 FCFA",
                  "Reversement O'Passage",
                  isPositive: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(
    IconData icon,
    String title,
    String amount,
    String sub, {
    required bool isPositive,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Icon(icon, color: appColor),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: appColor,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.black : Colors.black87,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                sub,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          onTap: () {},
        ),
        const Divider(height: 1, indent: 70),
      ],
    );
  }
}
