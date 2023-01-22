import 'package:flutter/cupertino.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  carregaScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans];
    notifyListeners();
  }

  esborrarTots() async {
    final scans = await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  esborrarPerId(int id) async {
    final scans = await DBProvider.db.deleteScan(id);
    this.scans.removeAt(scans);
    notifyListeners();
  }
}
