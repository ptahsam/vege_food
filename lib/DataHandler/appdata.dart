import 'package:flutter/foundation.dart';
import 'package:vege_food/Models/cart.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/Models/user.dart';

class AppData extends ChangeNotifier
{
  List<Product>? productList;
  List<Product>? productTopList;
  List<Product>? categoryProductsList;
  List<Categories>? categoriesList;
  List<Cart>? userCart;
  User? user;

  void updateProductList(List<Product> listProduct)
  {
    productList = listProduct;
    notifyListeners();
  }

  void updateTopProductList(List<Product> listProduct)
  {
    productTopList = listProduct;
    notifyListeners();
  }

  void updateCategoryProductsList(List<Product> categoryListProducts)
  {
    categoryProductsList = categoryListProducts;
    notifyListeners();
  }

  void updateCategoriesList(List<Categories> listCategories)
  {
    categoriesList = listCategories;
    notifyListeners();
  }

  void updateUserCart(List<Cart> listCart)
  {
    if(listCart.isNotEmpty){
      userCart = listCart;
    }else{
      userCart = null;
    }
    notifyListeners();
  }

  void updateUser(User loggedUser)
  {
    user = loggedUser;
    notifyListeners();
  }
}
