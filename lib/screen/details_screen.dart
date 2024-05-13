import 'package:flutter/material.dart';
import 'package:parking/models/parking_lot.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({required this.parkingLot, super.key});
  final ParkingLot parkingLot;

  @override
  Widget build(BuildContext context) {
    Widget parkingCard = SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${parkingLot.name}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Image.network(parkingLot.imageURL ?? "",
              fit: BoxFit.cover, height: 400),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address: ${parkingLot.address}",
                  style: const TextStyle(fontSize: 13),
                ),
                const Divider(),
                Text(
                  "Size: ${parkingLot.size.toString()}",
                  style: const TextStyle(fontSize: 13),
                ),
                const Divider(),
                Text(
                  "Live-date: ${parkingLot.liveDate}",
                  style: const TextStyle(fontSize: 13),
                ),
                const Divider(),
                Text(
                  "Type: ${parkingLot.type}",
                  style: const TextStyle(fontSize: 13),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          elevation: 1,
        ),
        body: parkingCard);
  }
}
