import 'package:parking/models/parking_lot.dart';

class ParkingLotUtils {
  static List<ParkingLot> filterByStatus(
      List<ParkingLot> lots, String? status) {
    return lots.where((lot) => lot.status == status).toList();
  }

  static List<ParkingLot> sortByName(List<ParkingLot> lots,
      {bool ascending = true}) {
    lots.sort((a, b) {
      int result = a.name?.compareTo(b.name ?? '') ?? -1;
      return ascending ? result : -result;
    });
    return lots;
  }

  static List<ParkingLot> sortByType(List<ParkingLot> lots,
      {bool ascending = true}) {
    lots.sort((a, b) {
      int result = a.type?.compareTo(b.type ?? '') ?? -1;
      return ascending ? result : -result;
    });
    return lots;
  }

  static Map<String, List<ParkingLot>> groupByType(List<ParkingLot> lots) {
    Map<String, List<ParkingLot>> grouped = {};
    for (var lot in lots) {
      String key = lot.type ?? "Other";
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]?.add(lot);
    }
    return grouped;
  }
}
