import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vege_food/Models/cart.dart';
import 'package:vege_food/Models/orderItem.dart';

String convertToFullDate(int timestamp){
  var d = DateFormat.d().format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  var m = DateFormat.M().format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  var y = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(timestamp));

  var day = d.length == 1? '0' + d:d;
  var month = m.length == 1? '0' + m:m;

  return day + '/' + month + '/' + y;
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}

saveUserId(String userid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userid', userid);
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString('userid') != null?prefs.getString('userid')!:"";
  return userID;
}

String getTotalCartItems(List<Cart> list) {
  int sum = 0;
  for(var i = 0; i < list.length; i++){
    Cart cart = list[i];
    sum = sum + cart.items_no!;
  }
  return sum.toString();
}

String getTotalOrderItems(List<OrderItem> list) {
  int sum = 0;
  for(var i = 0; i < list.length; i++){
    OrderItem orderItem = list[i];
    sum = sum + int.parse(orderItem.items_no!);
  }
  return sum.toString();
}

String getTotalOrderAmount(List<OrderItem> list) {
  int sum = 0;
  for(var i = 0; i < list.length; i++){
    OrderItem orderItem = list[i];
    sum = (sum + (int.parse(orderItem.items_no!) * int.parse(orderItem.productItem!.product_price!))).toInt();
  }
  return sum.toString();
}

String getTotalCartAmount(List<Cart> list) {
  int sum = 0;
  for(var i = 0; i < list.length; i++){
    Cart cart = list[i];
    sum = (sum + (cart.items_no! * int.parse(cart.productItem!.product_price!))).toInt();
  }
  return sum.toString();
}