import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/cart.dart';
import 'package:vege_food/Models/orderItem.dart';
import 'package:vege_food/Models/product.dart';

StreamSubscription? internetconnection;

getInternetConnection(BuildContext context){
  internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    // whenevery connection status is changed.
    if(result == ConnectivityResult.none){
      //there is no any connection
      Provider.of<AppData>(context, listen: false).updateOfflineStatus(true);
    }else if(result == ConnectivityResult.mobile){
      //connection is mobile data network
      Provider.of<AppData>(context, listen: false).updateOfflineStatus(false);
    }else if(result == ConnectivityResult.wifi){
      //connection is from wifi
      Provider.of<AppData>(context, listen: false).updateOfflineStatus(false);
    }
  });
}

Widget buildOfflineCard(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
    child: Text("No internet connection"),
  );
}

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

String getTotalProductAmount(List<Product> list) {
  int sum = 0;
  for(var i = 0; i < list.length; i++){
    Product product = list[i];
    sum = (sum + int.parse(product.product_price!)).toInt();
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