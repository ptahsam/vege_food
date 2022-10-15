class User {
  int? id;
  String? user_name;
  String? user_phone;
  String? user_email;
  String? user_photo;
  String? date_added;

  User({this.id, this.user_name, this.user_phone, this.user_email, this.user_photo, this.date_added});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      user_name: json['user_name'],
      user_phone: json['user_phone'],
      user_email: json['user_email'],
      user_photo: json['user_photo'],
      date_added: json['date_added'],
    );
  }
}