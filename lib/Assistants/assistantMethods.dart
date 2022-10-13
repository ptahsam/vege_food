import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/requestAssistant.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/product.dart';

class AssistantMethods {
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
