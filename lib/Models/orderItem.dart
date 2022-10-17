import 'package:vege_food/Models/product.dart';

class OrderItem{
  int? id;
  String? items_no;
  String? date_added;
  Product? productItem;

  OrderItem({this.id, this.items_no, this.date_added, this.productItem});

  factory OrderItem.fromJson(Map<String, dynamic> json) {

    Product product = Product();
    product.id =  json['product_id'];
    product.product_name = json['product_name'];
    product.product_price = json['product_price'];
    product.product_quantity = json['product_quantity'];
    product.product_photo = json['product_photo'];
    product.product_description = json['product_description'];

    return OrderItem(
      id: json['id'],
      productItem: product,
      items_no: json['items_no'],
      date_added: json['date_added'],
    );
  }
}