import 'package:flutter_test/flutter_test.dart';
import 'package:parking/utils/parking_utils.dart';
import 'package:parking/models/parking_lot.dart';

void main() {
  group('ParkingLotUtils Tests', () {
    // Sample parking lot data
    List<ParkingLot> mockParkingLots = [
      ParkingLot(id: '1', name: 'Lot A', type: 'Public', status: 'Open', size: 150),
      ParkingLot(id: '2', name: 'Lot B', type: 'Private', status: 'Closed', size: 200),
      ParkingLot(id: '3', name: 'Lot C', type: 'Public', status: 'Open', size: 100),
      ParkingLot(id: '4', name: 'Lot D', type: 'Public', status: 'Maintenance', size: 120),
    ];

    test('Filter by status "Open"', () {
      var openLots = ParkingLotUtils.filterByStatus(mockParkingLots, 'Open');
      expect(openLots.length, 2);
      expect(openLots.every((lot) => lot.status == 'Open'), isTrue);
    });

    test('Sort parking lots by name ascending', () {
      var sortedByName = ParkingLotUtils.sortByName(mockParkingLots);
      expect(sortedByName[0].name, 'Lot A');
      expect(sortedByName[1].name, 'Lot B');
      expect(sortedByName[2].name, 'Lot C');
      expect(sortedByName[3].name, 'Lot D');
    });

    test('Sort parking lots by type descending', () {
      var sortedByType = ParkingLotUtils.sortByType(mockParkingLots, ascending: false);
      expect(sortedByType[0].type, 'Public');
      expect(sortedByType[1].type, 'Public');
      expect(sortedByType[2].type, 'Public');
      expect(sortedByType[3].type, 'Private');
    });

    test('Group parking lots by type', () {
      var groupedByType = ParkingLotUtils.groupByType(mockParkingLots);
      expect(groupedByType.keys.length, 2);
      expect(groupedByType['Public']?.length, 3);
      expect(groupedByType['Private']?.length, 1);
    });
  });
}
