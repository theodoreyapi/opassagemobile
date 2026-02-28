import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:opassage/features/reservation/reservation.dart';
import 'package:opassage/features/splash/spalsh.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/constants.dart';
import 'core/themes/app_color.dart';
import 'core/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper().init();
  await initializeDateFormatting('fr_FR', null);
  runApp(const MyApp());
}

// ✅ UNE SEULE déclaration du navigatorKey, ici dans main.dart
// Les autres fichiers l'importent depuis ici
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription? _linkSub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() {
    // ✅ Ce listener dans main sert de FALLBACK
    // si l'app est lancée depuis un état "terminated" via deep link
    _linkSub = _appLinks.uriLinkStream.listen((Uri uri) {
      debugPrint("DeepLink global reçu: $uri");

      // Les écrans eux-mêmes (PaymentWaitingScreen) gèrent leur propre deep link
      // Ce handler global ne gère que les cas où aucun écran n'est actif
    });
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: AppConstants.appName,
          navigatorKey: navigatorKey, // ✅ INDISPENSABLE
          debugShowCheckedModeBanner: false,
          routes: {
            '/payment-waiting': (context) {
              final paymentId =
              ModalRoute.of(context)!.settings.arguments as int;
              return PaymentWaitingScreen(paymentId: paymentId);
            },
            '/payment-success': (context) {
              final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
              return ReservationSummaryScreen(
                amount: args['amount'],
                promoCode: args['promoCode'],
                residence: args['residence'],
              );
            },
            '/payment-error': (context) => PaymentErrorScreen(),
            '/reservation-confirmed': (context) => ReservationConfirmeScreen(),
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: appColor),
            textTheme: GoogleFonts.interTextTheme(),
            useMaterial3: true,
          ),
          home: SplashPage(),
        );
      },
    );
  }
}