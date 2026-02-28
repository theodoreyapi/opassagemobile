import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:opassage/features/menu/pages/menu_page.dart';
import 'package:opassage/features/splash/pages/pages.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final bool _isAuthenticating = true;
  final String _message = 'Vérification de sécurité...';

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  /// =========================
  /// AUTH FLOW
  /// =========================
  Future<void> _checkAuth() async {
    final savedPin = await _storage.read(key: 'user_pin');

    // Aucun PIN enregistré → accès direct (cas rare)
    if (savedPin == null) {
      _navigateToHome();
      return;
    }

    try {
      final canUseBiometric =
          await _auth.canCheckBiometrics &&
              await _auth.isDeviceSupported();

      if (canUseBiometric) {
        final authenticated = await _auth.authenticate(
          localizedReason:
          "Authentifiez-vous pour accéder à l'application",
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );

        if (authenticated) {
          _navigateToHome();
          return;
        }
      }

      // 👉 fallback PIN
      _goToPinUnlock(savedPin);
    } catch (_) {
      _goToPinUnlock(savedPin);
    }
  }

  /// =========================
  /// NAVIGATION
  /// =========================
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MenuPage()),
    );
  }

  void _goToPinUnlock(String savedPin) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PinUnlockPage(
          storedPin: savedPin,
        //  onSuccess: _navigateToHome,
        ),
      ),
    );
  }

  /// =========================
  /// UI
  /// =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [appColor, appColorSecond],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 90,
                color: Colors.white,
              ),
              const SizedBox(height: 30),
              const Text(
                'Sécurisation',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                _message,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 30),
              if (_isAuthenticating)
                const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}