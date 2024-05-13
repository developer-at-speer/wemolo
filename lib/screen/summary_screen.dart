import 'package:flutter/material.dart';
import 'package:parking/models/parking_lot.dart';
import 'package:parking/screen/details_screen.dart';
import 'package:parking/utils/parking_utils.dart';

class SummaryScreen extends StatefulWidget {
  final List<ParkingLot> favoriteLots;
  final List<ParkingLot> dismissedLots;

  const SummaryScreen(
      {required this.favoriteLots, required this.dismissedLots, super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<ParkingLot> displayedList = [];
  bool showingFavorites = true;

  @override
  void initState() {
    super.initState();
    displayedList = widget.favoriteLots;
  }

  void toggleList(bool isFavorites) {
    setState(() {
      showingFavorites = isFavorites;
      displayedList = isFavorites ? widget.favoriteLots : widget.dismissedLots;
    });
  }

  void filterActive() {
    var originalList =
        showingFavorites ? widget.favoriteLots : widget.dismissedLots;
    setState(() {
      displayedList = ParkingLotUtils.filterByStatus(originalList, 'active');
    });
  }

  void sortByName() {
    var originalList =
        showingFavorites ? widget.favoriteLots : widget.dismissedLots;
    setState(() {
      displayedList = ParkingLotUtils.sortByName(originalList);
    });
  }

  void sortByType() {
    var originalList =
        showingFavorites ? widget.favoriteLots : widget.dismissedLots;
    setState(() {
      displayedList = ParkingLotUtils.sortByType(originalList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Summary"),
      ),
      body: Column(
        children: [
          ToggleButtons(
            fillColor: Colors.transparent,
            renderBorder: false,
            onPressed: (int index) {
              toggleList(index == 0);
            },
            isSelected: [showingFavorites, !showingFavorites],
            children: const <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Favorite Lots')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Dismissed Lots')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: filterActive,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Filter Active',
                      style: TextStyle(fontSize: 12)),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: sortByName,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Sort by Name',
                      style: TextStyle(fontSize: 12)),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: sortByType,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Sort by Type',
                      style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedList.length,
              itemBuilder: (context, index) {
                final parkingLot = displayedList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return DetailsScreen(
                        parkingLot: parkingLot,
                      );
                    }));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Image.network(
                          parkingLot.imageURL ?? "",
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${parkingLot.name}",
                                  style: const TextStyle(fontSize: 12)),
                              Text("Address: ${parkingLot.address}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12)),
                              Text("Size: ${parkingLot.size.toString()}",
                                  style: const TextStyle(fontSize: 12)),
                              Text("Live-date: ${parkingLot.liveDate}",
                                  style: const TextStyle(fontSize: 12)),
                              Text("Type: ${parkingLot.type}",
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
