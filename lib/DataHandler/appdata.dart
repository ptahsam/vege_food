import 'package:flutter/foundation.dart';
import 'package:vege_food/Models/cart.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/orderItem.dart';
import 'package:vege_food/Models/orders.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/Models/user.dart';

class AppData extends ChangeNotifier
{
  List<Product>? productList;
  List<Product>? productTopList;
  List<Product>? categoryProductsList;
  List<Categories>? categoriesList;
  List<Cart>? userCart;
  List<Order>? userOrder;
  List<OrderItem>? orderItem;
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

  void updateUserOrder(List<Order> listOrder)
  {
    if(listOrder.isNotEmpty){
      userOrder = listOrder;
    }else{
      userOrder = null;
    }
    notifyListeners();
  }

  void updateOrderItem(List<OrderItem> listOrderItem)
  {
    if(listOrderItem.isNotEmpty){
      orderItem = listOrderItem;
    }else{
      orderItem = null;
    }
    notifyListeners();
  }

  void updateUser(User loggedUser)
  {
    user = loggedUser;
    notifyListeners();
  }
}
