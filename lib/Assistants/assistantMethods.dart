import 'dart:io';

import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/requestAssistant.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/Models/user.dart';

class AssistantMethods {
  static Future<String> loginUser(context, String identifier, String password) async{
    String data = "";
    var params = {
      'loginUser': '1',
      'identifier': '${identifier}',
      'password': '${password}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response.toString() != "failed" && response.toString() != "NOT_REGISTERED" && response.toString() != "PASSWORD_NOT_MATCHED"){
      final items = response.cast<Map<String, dynamic>>();

      User user = User.fromJson(items);

      Provider.of<AppData>(context, listen: false).updateUser(user);
      data = "LOGGED_IN";
    }else{
      data = response.toString();
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
