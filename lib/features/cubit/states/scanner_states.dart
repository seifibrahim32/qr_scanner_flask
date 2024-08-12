import 'package:equatable/equatable.dart';

abstract class ScannerStates extends Equatable{

  @override
  List<Object?> get props => [];

}

class NotScannedState extends ScannerStates{

  NotScannedState();

  @override
  List<Object?> get props => [];
}

class ScannedState extends ScannerStates{

  ScannedState();

  @override
  List<Object?> get props => [];
}

class DisposedScanState extends ScannerStates{

  DisposedScanState();
  @override
  List<Object?> get props => [];
}
class VisitorExistsState extends ScannerStates{

  VisitorExistsState();
  @override
  List<Object?> get props => [];
}
class NotVisitorExistsState extends ScannerStates{

  NotVisitorExistsState();
  @override
  List<Object?> get props => [];
}