import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vege_food/Models/cart.dart';

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

String getTotalCartAmount(List<Cart> list) {
  int sum = 0;
  for(var i = 0; i < list.length; i++){
    Cart cart = list[i];
    sum = (sum + (cart.items_no! * int.parse(cart.productItem!.product_price!))).toInt();
  }
  return sum.toString();
}