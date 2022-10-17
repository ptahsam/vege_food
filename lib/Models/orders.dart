class Order {
  int? id;
  String? order_refno;
  int? payment_id;
  String? date_added;

  Order({this.id, this.order_refno, this.payment_id, this.date_added});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      order_refno: json['order_refno'],
      payment_id: json['payment_id'],
      date_added: json['date_added'],
    );
  }
}