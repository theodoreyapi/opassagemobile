import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:opassage/core/constants/constants.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/core/utils/utils.dart';
import 'package:opassage/features/auth/pages/login_page.dart';
import 'package:sizer/sizer.dart';

class CreatePinPage extends StatefulWidget {
  String? username;
  String? login;
  String? role;
  String? password;

  CreatePinPage({
    super.key,
    this.username,
    this.login,
    this.role,
    this.password,
  });

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage>
    with SingleTickerProviderStateMixin {
  final List<int> _pin = [];
  final storage = const FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();

  String firstPin = '';
  bool isConfirmStep = false;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _shakeAnimation = Tween(begin: -12.0, end: 12.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  /// =========================
  /// PIN LOGIC
  /// =========================
  void _addDigit(int digit) async {
    if (_pin.length < 4) {
      setState(() => _pin.add(digit));

      if (_pin.length == 4) {
        final enteredPin = _pin.join();

        await Future.delayed(const Duration(milliseconds: 200));

        if (!isConfirmStep) {
          firstPin = enteredPin;
          isConfirmStep = true;
          _pin.clear();
          setState(() {});
        } else {
          if (enteredPin == firstPin) {
            await storage.write(key: 'user_pin', value: enteredPin);
            registerUser(context, enteredPin);
          } else {
            _errorPin();
          }
        }
      }
    }
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() => _pin.removeLast());
    }
  }

  void _errorPin() {
    HapticFeedback.vibrate();
    _shakeController.forward(from: 0);
    _pin.clear();
    setState(() {});
  }

  /// =========================
  /// BIOMETRIE
  /// =========================
  Future<void> _authenticate() async {
    try {
      final canAuth = await auth.canCheckBiometrics;
      if (!canAuth) return;

      final didAuth = await auth.authenticate(
        localizedReason: 'Authentifiez-vous',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (didAuth) {
        final savedPin = await storage.read(key: 'user_pin');
        if (savedPin != null) {
          registerUser(context, savedPin);
        }
      }
    } catch (_) {}
  }

  /// =========================
  /// UI
  /// =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8E2A8B),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(width: 24),
                  Row(
                    children: [
                      Icon(Icons.headset_mic, color: Colors.white),
                      Gap(8),
                      Text("Service client",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// TITRE
            Text(
              isConfirmStep
                  ? "Confirmer le code"
                  : "Créer un code de sécurité",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            Gap(4.h),

            /// PIN DOTS (SHAKE)
            AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_shakeAnimation.value, 0),
                  child: child,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isActive = index < _pin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? Colors.yellow
                          : Colors.white.withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ),

            Gap(5.h),

            /// KEYPAD
            _buildKeyboard(),

            const Spacer(),

            TextButton(
              onPressed: () {},
              child: const Text(
                "J’ai oublié mon code",
                style: TextStyle(color: Colors.white70),
              ),
            ),

            Gap(2.h),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// CLAVIER
  /// =========================
  Widget _buildKeyboard() {
    return Column(
      children: [
        for (var row in [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9],
        ])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map(_buildKey).toList(),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIconKey(Icons.fingerprint, _authenticate),
            _buildKey(0),
            _buildIconKey(Icons.backspace, _removeDigit),
          ],
        ),
      ],
    );
  }

  Widget _buildKey(int number) {
    return GestureDetector(
      onTap: () => _addDigit(number),
      child: SizedBox(
        width: 70,
        height: 70,
        child: Center(
          child: Text(
            "$number",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconKey(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        height: 70,
        child: Center(
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  /// =========================
  /// API REGISTER
  /// =========================
  Future<void> registerUser(BuildContext context, String pin) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: appColor,
        content: Row(
          children: [
            CircularProgressIndicator(color: appColorWhite),
            const SizedBox(width: 20),
            Text("Création du compte...",
                style: TextStyle(color: appColorWhite)),
          ],
        ),
      ),
    );

    try {
      HttpClient().badCertificateCallback =
          (cert, host, port) => true;

      final response = await http.post(
        Uri.parse(ApiUrls.postAuthRegister),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': widget.username,
          'login': widget.login,
          'role': widget.role,
          'password': widget.password,
          'code': pin,
        }),
      );

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      Navigator.pop(context);

      if (response.statusCode == 200) {
        SnackbarHelper.showSuccess(context, data['message']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
              (_) => false,
        );
      } else {
        SnackbarHelper.showError(context, _parseMessage(data['message']));
      }
    } catch (_) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion");
    }
  }

  String _parseMessage(dynamic message) {
    if (message is List) return message.join('\n');
    return message.toString();
  }
}
