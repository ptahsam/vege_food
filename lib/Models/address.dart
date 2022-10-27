class Address {
  int? id;
  String? address;
  String? county;
  String? city;

  Address({this.id, this.address, this.county, this.city});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      address: json['address'],
      county: json['county'],
      city: json['city'],
    );
  }
}