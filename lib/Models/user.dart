import 'package:vege_food/Models/address.dart';

class User {
  int? id;
  String? user_name;
  String? user_phone;
  String? user_email;
  String? user_photo;
  String? date_added;
  Address? address;

  User({this.id, this.user_name, this.user_phone, this.user_email, this.user_photo, this.date_added, this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    Address address = Address();
    address.id = json["address_id"];
    address.address = json["address"];
    address.county = json["county"];
    address.city = json["city"];

    return User(
      id: json['id'],
      user_name: json['user_name'],
      user_phone: json['user_phone'],
      user_email: json['user_email'],
      user_photo: json['user_photo'],
      date_added: json['date_added'],
      address: address,
    );
  }
}