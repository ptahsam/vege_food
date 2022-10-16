import 'package:vege_food/Models/product.dart';

class Cart {
  int? id;
  Product? productItem;
  int? items_no;

  Cart({this.id, this.productItem, this.items_no});

  factory Cart.fromJson(Map<String, dynamic> json) {

    Product product = Product();
    product.id =  json['product_id'];
    product.product_name = json['product_name'];
    product.product_price = json['product_price'];
    product.product_quantity = json['product_quantity'];
    product.product_photo = json['product_photo'];
    product.product_description = json['product_description'];

    return Cart(
      id: json['id'],
      productItem: product,
      items_no: json['items_no'],
    );
  }
}