import 'package:flutter/material.dart';
import 'package:qr_scanner/features/home/home_screen.dart';
import 'package:qr_scanner/features/scanner/scanner_screen.dart';

class EtisalApp extends StatelessWidget {
  const EtisalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/scanner-screen': (context) => const QRScannerScreen()
        },
        title: 'Etisal Event QR Scanner',
        home: const MainScreen()
    );
  }
}
