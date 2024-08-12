import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/features/cubit/cubit_implementation/scanner_cubit.dart';
import 'package:qr_scanner/features/cubit/states/scanner_states.dart';
import 'package:qr_scanner/features/enums/enums.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey();
  Barcode? result;
  QRViewController? _controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code'), centerTitle: true),
      body: BlocProvider(
        create: (context) => ScannerCubit(),
        child: BlocBuilder<ScannerCubit, ScannerStates>(builder: (ctx, state) {
          var bloc = BlocProvider.of<ScannerCubit>(ctx);
          if (state is NotScannedState || state is DisposedScanState) {
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    overlay: QrScannerOverlayShape(borderWidth: 2),
                    key: qrKey,
                    onQRViewCreated: (controller) {
                      _onQRViewCreated(controller, bloc);
                    },
                  ),
                ),
              ],
            );
          }
          if(state is ScannedState){
            getUserRegistrationInfo(bloc);
          }
          if(state is VisitorExistsState){
            return Center(
              child: Text("Registered"),
            );
          }
          if(state is NotVisitorExistsState) {
            return Center(
              child: Text("Not Available"),
            );
          }

          return Center(
            child: Text("Retrieving data..."),
          );
        }),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, ScannerCubit cubit) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code!.isNotEmpty) {
        cubit.updateScanningState(States.LOADED);
      } else {
        cubit.updateScanningState(States.FAILED);
      }
      result = scanData;
    });
  }

  void getUserRegistrationInfo(ScannerCubit bloc) {
    bloc.retrieveVisitorData(result!.code);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
