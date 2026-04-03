import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:opassage/core/themes/themes.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/utils.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final player = AudioPlayer();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      try {
        await controller.pauseCamera();

        final code = scanData.code?.trim();

        if (code == null || code.isEmpty) {
          throw Exception("Code vide");
        }

        final decryptedValue = CryptoHelper.decryptData(code);

        await player.play(AssetSource('sounds/beep.mp3'));

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Container(),
            /* MobileAmountPage(
              phoneNumber: decryptedValue,
              type: "trans",
            )*/
          ),
        ).then((_) async {
          await controller.resumeCamera();
          setState(() {
            result = null;
          });
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("QR Code invalide ou corrompu"),
              backgroundColor: Colors.red,
            ),
          );
        }

        // Attendre un peu avant de relancer la caméra
        await Future.delayed(const Duration(seconds: 2));
        await controller.resumeCamera();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFondLogin,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.transparent,
                    // on cache le border par défaut
                    overlayColor: Colors.black.withValues(alpha: 0.6),
                    borderRadius: 10,
                    cutOutSize: 250,
                  ),
                ),

                // 🟣 CONTOUR VIOLET (extérieur)
                Center(
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      border: Border.all(color: appColor, width: 12),
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                  ),
                ),

                // 🟡 CONTOUR JAUNE (intérieur)
                Center(
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      border: Border.all(color: appColorSecond, width: 1),
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Scanne le code QR pour encaisser et recevoir l'O'Passeur",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
