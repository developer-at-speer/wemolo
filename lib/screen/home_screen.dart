import 'package:flutter/material.dart';
import 'package:parking/models/parking_lot.dart';
import 'package:parking/screen/summary_screen.dart';
import 'package:parking/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<ParkingLot> parkingLots = [];
  List<ParkingLot> favoriteLots = [];
  List<ParkingLot> dismissedLots = [];
  var cardIndex = 0;
  var offset = 0;
  final limit = 5;
  var error = false;

  @override
  void initState() {
    super.initState();
    loadParkingLots(limit, offset);
  }

  Future<void> loadParkingLots(int limit, int offset) async {
    try {
      List<ParkingLot> loadedParkingLots =
          await fetchParkingLots(limit: limit, offset: offset);
      setState(() {
        parkingLots = loadedParkingLots;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load parking lots")));
    }
    setState(() {
      error = true;
    });
  }

  Future<void> getNextSetParkingLots() async {
    int newOffset = offset + limit;
    List<ParkingLot> newLots =
        await fetchParkingLots(limit: limit, offset: newOffset);
    setState(() {
      parkingLots.addAll(newLots);
      offset = newOffset;
      cardIndex = 0;
    });
  }

  Future<void> addFavorites(ParkingLot lot) async {
    bool isLastCard = cardIndex == parkingLots.length - 1;

    setState(() {
      favoriteLots.add(lot);
      if (!isLastCard) {
        cardIndex++;
      }
    });

    if (isLastCard) {
      await getNextSetParkingLots();
    }
  }

  Future<void> addDismissed(ParkingLot lot) async {
    bool isLastCard = cardIndex == parkingLots.length - 1;

    setState(() {
      dismissedLots.add(lot);
      if (!isLastCard) {
        cardIndex++;
      }
    });

    if (isLastCard) {
      await getNextSetParkingLots();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = const Center(
      child: CircularProgressIndicator(),
    );

    if (error) {
      loadingWidget = const Center(
        child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
        "Error: Failed to load parking lots",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
      );
    }

    Widget parkingCard = parkingLots.isNotEmpty &&
            cardIndex < parkingLots.length
        ? SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${parkingLots[cardIndex].name}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.network(parkingLots[cardIndex].imageURL ?? "",
                    fit: BoxFit.cover, height: 400),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address: ${parkingLots[cardIndex].address}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      const Divider(),
                      Text(
                        "Size: ${parkingLots[cardIndex].size.toString()}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      const Divider(),
                      Text(
                        "Live-date: ${parkingLots[cardIndex].liveDate}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      const Divider(),
                      Text(
                        "Type: ${parkingLots[cardIndex].type}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          addDismissed(parkingLots[cardIndex]);
                        },
                        icon: const Icon(Icons.thumb_down_outlined),
                        label: const Text("Bad"),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          addFavorites(parkingLots[cardIndex]);
                        },
                        icon: const Icon(Icons.thumb_up_outlined),
                        label: const Text("Good"),
                        style: const ButtonStyle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : loadingWidget;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Wemolo"),
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return SummaryScreen(
                        favoriteLots: favoriteLots,
                        dismissedLots: dismissedLots);
                  }));
                },
                icon: const Icon(
                  Icons.list_outlined,
                  size: 40,
                ))
          ],
        ),
        body: parkingCard);
  }
}
