class AddressModel {
  final int id;
  final int userId;
  final Address address;
  final String addressLabel;
  final String contact;
  final String category;
  final String district;
  final String locality;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.addressLabel,
    required this.contact,
    required this.category,
    required this.district,
    required this.locality,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      address: Address.fromJson(json['address']),
      addressLabel: json['address_label'],
      contact: json['contact'],
      category: json['category'],
      district: json['district'],
      locality: json['locality'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }
}

class Address {
  final String building;
  final String place;
  final String pin;

  Address({
    required this.building,
    required this.place,
    required this.pin,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      building: json['building'],
      place: json['place'],
      pin: json['pin'],
    );
  }
}