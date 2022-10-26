import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/cart.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({Key? key}) : super(key: key);

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Edit Cart",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Provider.of<AppData>(context).userCart != null?Container(
            padding: EdgeInsets.only(right: 12.0),
            child: Align(
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  getTotalCartItems(Provider.of<AppData>(context).userCart!),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ):SizedBox.shrink(),
        ],
      ),
      body: Provider.of<AppData>(context).userCart != null?Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(top: 20.0),
              itemCount: Provider.of<AppData>(context).userCart!.length,
              itemBuilder: (ctx, int index){
                Cart cart = Provider.of<AppData>(context).userCart![index];
                return ListTile(
                  leading: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        width: 1.0,
                        color: Palette.greyBorder,
                      ),
                    ),
                    child: ExtendedImage.network(
                      "${ApiConstants.baseUrl}/images/products/${cart.productItem!.product_photo!}",
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  title: Text(
                    cart.productItem!.product_name!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () async {
                            String res = await AssistantMethods.removeItemFromCart(context, await getUserId(), cart.productItem!.id!.toString(), "1");
                            if(res == "SUCCESSFULLY_REMOVED"){
                              AssistantMethods.getUserCartItems(context, await getUserId());
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200]!,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Icon(
                                  MdiIcons.minus,
                                  size: 24.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () async {
                            String res = await AssistantMethods.addItemToCart(context, await getUserId(), cart.productItem!.id!.toString(), "1");
                            if(res == "SUCCESSFULLY_ADDED"){
                              AssistantMethods.getUserCartItems(context, await getUserId());
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.primaryColor.withOpacity(0.2),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 24.0,
                                  color: Palette.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "KES. ${int.parse(cart.productItem!.product_price!) * cart.items_no!}.00",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.redAccent
                        ),
                      ),
                      Text(
                        "${cart.items_no}",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.black6,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100]!,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width) - 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            'KES. ${getTotalCartAmount(Provider.of<AppData>(context).userCart!)}.00',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    InkWell(
                      onTap: () async {
                        if(Provider.of<AppData>(context).user != null){
                          String res = await AssistantMethods.addNewOrder(context, await getUserId());
                          if(res == "SUCCESSFULLY_ADDED"){
                            AssistantMethods.getUserCartItems(context, await getUserId());
                            AssistantMethods.getUserOrderItems(context, await getUserId());
                            Navigator.pop(context);
                          }else{
                            displayToastMessage("An error occurred. Please try again later", context);
                          }
                        }
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width) - 24,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
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
                        child: Center(
                          child: Text(
                            "Place Order",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
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
      ):Container(
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.grey[200]!,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.cartOff,
                    color: Colors.black,
                    size: 28.0,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "No items in cart.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Palette.black6,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Palette.primaryColor,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        "Begin Shopping",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
