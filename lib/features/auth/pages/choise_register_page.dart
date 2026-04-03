import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/features/auth/auth.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';

class ChoiseRegisterPage extends StatefulWidget {
  String? login;

  ChoiseRegisterPage({super.key, this.login});

  @override
  State<ChoiseRegisterPage> createState() => _ChoiseRegisterPageState();
}

class _ChoiseRegisterPageState extends State<ChoiseRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              FloatingActionButton.small(
                backgroundColor: appColorSecond,
                elevation: 0,
                shape: CircleBorder(),
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: appColorWhite,
                ),
              ),
              Gap(2.h),
              Image.asset("assets/images/logo.png"),
              Gap(4.h),
              Text(
                "Quel est ton statut ?",
                style: TextStyle(
                  color: appColor,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Je choisir mon objectif sur l'application",
                style: TextStyle(
                  color: appColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Gap(4.h),
              Container(
                decoration: BoxDecoration(
                  color: appColorWhite,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(color: appColor, width: 1.2),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(3.w),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(
                          texte: "opasseur",
                          login: widget.login,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 25.w,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          mainAxisAlignment: .center,
                          children: [
                            Icon(
                              Icons.roofing_outlined,
                              color: appColorSecond,
                              size: 25.sp,
                            ),
                            Gap(1.h),
                            Text(
                              "Hôte",
                              style: TextStyle(
                                color: appColorSecond,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(2.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Je possède un hébergement / espace",
                              style: TextStyle(
                                color: appColorChoise,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Je l'enregistre et commence à accueillir des O'Passeurs",
                              style: TextStyle(
                                color: appColorChoise,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(2.h),
              Container(
                decoration: BoxDecoration(
                  color: appColorWhite,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(color: appColor, width: 1.2),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(3.w),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            RegisterPage(texte: "client", login: widget.login),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 25.w,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: Column(
                          mainAxisAlignment: .center,
                          children: [
                            Icon(
                              Icons.person_4_outlined,
                              color: appColorSecond,
                              size: 25.sp,
                            ),
                            Gap(1.h),
                            Text(
                              "O'Passeur",
                              style: TextStyle(
                                color: appColorSecond,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(2.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Je recherche un hébergement / espace",
                              style: TextStyle(
                                color: appColorChoise,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(.5.h),
                            Text(
                              "Je veux profiter d'une belle expérience "
                              "dans un établissement qui me sied",
                              style: TextStyle(
                                color: appColorChoise,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
