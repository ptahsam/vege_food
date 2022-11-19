import 'package:flutter/foundation.dart';
import 'package:vege_food/Models/category.dart';

class Product {
  int? id;
  int? category_id;
  String? product_name;
  String? product_price;
  String? product_quantity;
  String? product_photo;
  String? product_description;
  Categories? productCategory;
  String? date_added;

  Product({this.id, this.category_id, this.product_name, this.product_price, this.product_quantity, this.product_photo, this.product_description, this.productCategory, this.date_added});

  factory Product.fromJson(Map<String, dynamic> json) {

    Categories category = Categories();
    category.id = json["category_id"];
    category.category_name = json["category_name"];
    category.category_image = json["category_image"];

    return Product(
      id: json['id'],
      category_id: json["category_id"],
      product_name: json['product_name'],
      product_price: json['product_price'],
      product_quantity: json['product_quantity'],
      product_photo: json['product_photo'],
      product_description: json['product_description'],
      productCategory: category,
      date_added: json['date_added'],
    );
  }
}
