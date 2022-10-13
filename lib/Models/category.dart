class Categories {
  int? id;
  String? category_name;
  String? category_image;
  String? created_date;

  Categories({this.id, this.category_name, this.category_image, this.created_date});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      category_name: json['category_name'],
      category_image: json['category_image'],
      created_date: json['created_date'],
    );
  }
}