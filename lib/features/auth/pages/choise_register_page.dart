import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:opassage/features/auth/auth.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';

class ChoiseRegisterPage extends StatefulWidget {
  const ChoiseRegisterPage({super.key});

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
              Row(
                children: [
                  FloatingActionButton.small(
                    backgroundColor: appColorWhite,
                    elevation: 0,
                    shape: CircleBorder(),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back, color: appColorBlack),
                  ),
                  Image.asset("assets/images/logo_color.png"),
                ],
              ),
              Gap(4.h),
              Text(
                "Quel est ton statut ?",
                style: TextStyle(
                  color: appColor,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Choisissez votre objectif sur la plateforme",
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
                  border: Border.all(color: appColor, width: 1),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(3.w),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(texte: "Client"),
                      ),
                    );
                  },
                  title: Text(
                    "Je recherche un logement",
                    style: TextStyle(
                      color: appColorChoise,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Recherchez et réservez un hôtel, appartement "
                    "ou villa pour votre séjour ",
                    style: TextStyle(
                      color: appColorChoise,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: Image.asset("assets/images/hom.png"),
                ),
              ),
              Gap(2.h),
              Container(
                decoration: BoxDecoration(
                  color: appColorWhite,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(color: appColor, width: 1),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(3.w),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(texte: "Propriétaire"),
                      ),
                    );
                  },
                  title: Text(
                    "Je suis propriétaire",
                    style: TextStyle(
                      color: appColorChoise,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Enregistrez votre établissement et commencez "
                    "à acceuillir des clients ",
                    style: TextStyle(
                      color: appColorChoise,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  leading: Image.asset("assets/images/home.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
