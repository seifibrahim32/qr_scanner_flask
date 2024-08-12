import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/features/api/network.dart';
import 'package:qr_scanner/features/cubit/states/scanner_states.dart';
import 'package:qr_scanner/features/enums/enums.dart';

class ScannerCubit extends Cubit<ScannerStates> {
  ScannerCubit() : super(NotScannedState());

  var visitorRegistrationInfo = MongoDBDataSource();

  void updateScanningState(States state) {
    if (state == States.LOADED) {
      emit(ScannedState());
    } else {
      emit(DisposedScanState());
    }
  }

  void retrieveVisitorData(String? userId) {
    if (userId!.isNotEmpty){
      visitorRegistrationInfo.getVisitorsInfo(userId).then((isRegistered) {
        String message = isRegistered;
        if(message.isNotEmpty) {
          emit(VisitorExistsState());
        }
        else {
          emit(NotScannedState());
        }
      });
    }
    else {
      emit(NotVisitorExistsState());
    }
  }
}
