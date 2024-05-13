class ParkingLot {
  ParkingLot({
    required this.id,
    this.address,
    this.imageURL,
    this.liveDate,
    this.name,
    this.size,
    this.status,
    this.type,
  });

  String id;
  String? address;
  String? imageURL;
  String? liveDate;
  String? name;
  int? size;
  String? status;
  String? type;

  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      id: json['id'],
      address: json['address'],
      imageURL: json['image'],
      liveDate: json['live_date'],
      name: json['name'],
      size: json['size'] != null ? int.tryParse(json['size'].toString()) : null,
      status: json['status'],
      type: json['type'],
    );
  }
}
