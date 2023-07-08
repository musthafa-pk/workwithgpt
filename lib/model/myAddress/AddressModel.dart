class AddressBookEntry {
  final int id;
  final String addressLabel;
  final String category;
  final String contact;
  final String district;
  final double latitude;
  final double longitude;
  final String locality;
  final int userId;

  AddressBookEntry({
    required this.id,
    required this.addressLabel,
    required this.category,
    required this.contact,
    required this.district,
    required this.latitude,
    required this.longitude,
    required this.locality,
    required this.userId,
  });
}