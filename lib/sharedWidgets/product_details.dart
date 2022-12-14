import 'dart:ffi';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/auth/auth.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  int _itemsCount = 1;
  double _totalPrice = 0;
  bool isAddingItemsToCart = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _totalPrice = double.parse(widget.product.product_price!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 12.0),
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                "${widget.product.productCategory!.category_name!} > ${widget.product.product_name!}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: false,
              floating: true,
              automaticallyImplyLeading: true,
              snap: true,
              elevation: 40.0,
              expandedHeight: MediaQuery.of(context).size.height,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    ExtendedImage.network(
                      "${ApiConstants.baseUrl}/images/categories/${widget.product.productCategory!.category_image!}",
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: 12.0,
                      left: 12.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Palette.textColor1.withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ExtendedImage.network(
                              "${ApiConstants.baseUrl}/images/products/${widget.product.product_photo!}",
                              width: double.infinity,
                              height: 200.0,
                              fit: BoxFit.scaleDown,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.product_name!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    "KES. ${widget.product.product_price}.00",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28.0,
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    widget.product.product_description!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.2,
                      right: MediaQuery.of(context).size.width * 0.2,
                      left: MediaQuery.of(context).size.width * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              if(_itemsCount > 1){
                                setState(() {
                                  _itemsCount = _itemsCount - 1;
                                  _totalPrice = (double.parse(widget.product.product_price!) * _itemsCount);
                                });
                              }
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200]!,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Icon(
                                    MdiIcons.minus,
                                    size: 28.0,
                                    color: _itemsCount > 1?Colors.black:Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${_itemsCount}",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(int.parse(widget.product.product_quantity!) >= _itemsCount) {
                                  _itemsCount = _itemsCount + 1;
                                  _totalPrice = (double.parse(widget.product.product_price!) * _itemsCount);
                                }
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.primaryColor.withOpacity(0.2),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 28.0,
                                    color: Palette.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.10,
                      right: 12.0,
                      left: 12.0,
                      child: InkWell(
                        onTap: Provider.of<AppData>(context).user == null?() async {
                          String res = await Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
                          if(res == "LOGGED_IN"){
                            setState(() {
                              isAddingItemsToCart = true;
                            });
                            addItemsToCart();
                          }
                        }:() async {
                          setState(() {
                            isAddingItemsToCart = true;
                          });
                          addItemsToCart();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Palette.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Palette.textColor1.withOpacity(0.6),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: isAddingItemsToCart?Row(
                            children: [
                              Container(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0,),
                              ),
                              SizedBox(width: 15.0,),
                              Text(
                                "Add to cart ...",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ):Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                                size: 26.0,
                              ),
                              SizedBox(width: 15.0,),
                              Text(
                                "Add for KES. ${_totalPrice}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addItemsToCart() async {
    User user = Provider.of<AppData>(context, listen: false).user!;
    String res = await AssistantMethods.addItemToCart(context, user.id!.toString(), widget.product.id!.toString(), _itemsCount.toString());
    if(res == "SUCCESSFULLY_ADDED"){
      setState(() {
        isAddingItemsToCart = false;
      });
      Navigator.pop(context);
    }else{
      setState(() {
        isAddingItemsToCart = false;
      });
      displayToastMessage("An error occurred. Please try again later.", context);
    }
  }
}
