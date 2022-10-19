import 'dart:io';

import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/requestAssistant.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/cart.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/orderItem.dart';
import 'package:vege_food/Models/orders.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/Models/user.dart';

class AssistantMethods {

  static Future<String> updateUserDetails(context, String field, String field_value, String userid) async{
    String data = "";
    var params = {
      'updateUserDetails': '1',
      'field': '${field}',
      'field_value': '${field_value}',
      'userid': '${userid}',
    };

    var response = await RequestAssistant.getRequest(params);

    data = response.toString();

    return data;
  }

  static Future<String> addNewOrder(context, String userid) async{
    String data = "";
    var params = {
      'addNewOrder': '1',
      'userid': '${userid}',
    };

    var response = await RequestAssistant.getRequest(params);

    data = response.toString();

    return data;
  }

  static getUserData(context, String userid) async{
    var params = {
      'getUserData': '1',
      'userid': '${userid}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed" && response != "NOT_REGISTERED"){
      User user = User.fromJson(response);

      Provider.of<AppData>(context, listen: false).updateUser(user);
    }
  }

  static Future<String> loginUser(context, String identifier, String password) async{
    String data = "";
    var params = {
      'loginUser': '1',
      'identifier': '${identifier}',
      'password': '${password}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response.toString() != "failed" && response.toString() != "NOT_REGISTERED" && response.toString() != "PASSWORD_NOT_MATCHED"){

      User user = User.fromJson(response);

      Provider.of<AppData>(context, listen: false).updateUser(user);
      data = "LOGGED_IN";
    }else{
      data = response.toString();
    }
    return data;
  }

  static Future<String> addItemToCart(context, String userid, String productid, String productquantity) async{
    String data = "";
    var params = {
      'addItemToCart': '1',
      'userid': '${userid}',
      'productid': '${productid}',
      'productquantity': '${productquantity}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      data = response.toString();
    }else{
      data = "failed";
    }
    return data;
  }

  static Future<String> removeItemFromCart(context, String userid, String productid, String productquantity) async{
    String data = "";
    var params = {
      'removeItemFromCart': '1',
      'userid': '${userid}',
      'productid': '${productid}',
      'productquantity': '${productquantity}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      data = response.toString();
    }else{
      data = "failed";
    }
    return data;
  }

  static Future<String> registerUser(context, String identifier, String password) async{
    String data = "";
    var params = {
      'registerUser': '1',
      'identifier': '${identifier}',
      'password': '${password}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      data = response.toString();
    }else{
      data = "failed";
    }
    return data;
  }

  static Future<List<OrderItem>> getOrderItems(String order_no) async {
    List<OrderItem> orderItems = [];
    var params = {
      'getOrderItems': '1',
      'order_no': '${order_no}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed" && response != "NO_DATA"){
      final items = response.cast<Map<String, dynamic>>();

      List<OrderItem> orderItem = items.map<OrderItem>((json) {
        return OrderItem.fromJson(json);
      }).toList();

      orderItems = orderItem;

    }else if(response == "NO_DATA"){
      orderItems = [];
    }
    return orderItems;
  }


  static getUserOrderItems(context, String userid) async{
    List<Order> listOrders = [];
    var params = {
      'getUserOrders': '1',
      'userid': '${userid}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed" && response != "NO_DATA"){
      final items = response.cast<Map<String, dynamic>>();

      List<Order> order = items.map<Order>((json) {
        return Order.fromJson(json);
      }).toList();

      for(var i = 0; i < order.length; i++){
        Order o = order[i];
        o.listOrderItems = await getOrderItems(o.order_refno!);
        listOrders.add(o);
      }

      Provider.of<AppData>(context, listen: false).updateUserOrder(listOrders);
    }else if(response == "NO_DATA"){
      List<Order> order = [];
      Provider.of<AppData>(context, listen: false).updateUserOrder(order);
    }
  }

  static getUserCartItems(context, String userid) async{
    var params = {
      'getUserCartItems': '1',
      'userid': '${userid}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed" && response != "NO_DATA"){
      final items = response.cast<Map<String, dynamic>>();

      List<Cart> cart = items.map<Cart>((json) {
        return Cart.fromJson(json);
      }).toList();

      Provider.of<AppData>(context, listen: false).updateUserCart(cart);
    }else if(response == "NO_DATA"){
      List<Cart> cart = [];
      Provider.of<AppData>(context, listen: false).updateUserCart(cart);
    }
  }

  static getAllProducts(context) async{
    var params = {
      'getProducts': '1',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      final items = response.cast<Map<String, dynamic>>();

      List<Product> products = items.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();

      Provider.of<AppData>(context, listen: false).updateProductList(products);
    }
  }

  static getProductsByCategory(context, String category_id) async{
    var params = {
      'getProductsByCategory': '1',
      'category_id': '${category_id}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      final items = response.cast<Map<String, dynamic>>();

      List<Product> products = items.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();

      Provider.of<AppData>(context, listen: false).updateCategoryProductsList(products);
    }
  }

  static getTopProducts(context) async{
    var params = {
      'getTopProducts': '1',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      final items = response.cast<Map<String, dynamic>>();

      List<Product> products = items.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();

      Provider.of<AppData>(context, listen: false).updateTopProductList(products);
    }
  }

  static getAllCategories(context) async{
    var params = {
      'getCategories': '1',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      final items = response.cast<Map<String, dynamic>>();

      List<Categories> categories = items.map<Categories>((json) {
        return Categories.fromJson(json);
      }).toList();

      Provider.of<AppData>(context, listen: false).updateCategoriesList(categories);
    }
  }
}
