import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:sizer/sizer.dart';

class DetailTransactionPage extends StatelessWidget {
  const DetailTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appColorFondLogin,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "50 000 FCFA (Wave)",
                      style: TextStyle(
                        color: appColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Montant de transaction",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(3.h),
              Text(
                "Statut",
                style: TextStyle(
                  color: appColorBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Effectué",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Divider(height: 2.h,),
              Text(
                "Date et heure",
                style: TextStyle(
                  color: appColorBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "11 novembre 2026 - 09:00",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Divider(height: 2.h,),
              Text(
                "ID de la commande",
                style: TextStyle(
                  color: appColorBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "MP27T44567383",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
