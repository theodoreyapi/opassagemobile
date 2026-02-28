import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opassage/features/intro/pages/intro_page.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import 'auth_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double loadingValue = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      _updateLoadingProgress();
    });
  }

  void _updateLoadingProgress() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (loadingValue >= 1) {
        _navigateToNextScreen();
        return;
      }
      loadingValue += 0.1;
      setState(() {});
      _updateLoadingProgress();
    });
  }

  Future<void> _navigateToNextScreen() async {
    String? nom = SharedPreferencesHelper().getString('username');
    if (nom != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    } else {
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IntroPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Image.asset("assets/images/logo.png"),
            Gap(1.h),
            Text(
              "On tape jahin poto !",
              style: TextStyle(
                color: appColorWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
