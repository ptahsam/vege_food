import 'package:vege_food/Models/orderItem.dart';

class Order {
  int? id;
  String? order_refno;
  String? payment_id;
  List<OrderItem>? listOrderItems;
  String? date_added;

  Order({this.id, this.order_refno, this.payment_id, this.listOrderItems, this.date_added});

  factory Order.fromJson(Map<String, dynamic> jsonOrder) {

    return Order(
      id: jsonOrder['id'],
      order_refno: jsonOrder['order_refno'],
      payment_id: jsonOrder['payment_id'],
      date_added: jsonOrder['date_added'],
    );
  }
}