import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/config/palette.dart';

class ViewQuickOrders extends StatefulWidget {
  final List<Product> productList;
  const ViewQuickOrders({
    Key? key,
    required this.productList
  }) : super(key: key);

  @override
  State<ViewQuickOrders> createState() => _ViewQuickOrdersState();
}

class _ViewQuickOrdersState extends State<ViewQuickOrders> {

  int itemsNo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.productList.length == 1){
      itemsNo = 1;
    }else if(widget.productList.length == 2){
      itemsNo = 2;
    }else if(widget.productList.length >= 3){
      itemsNo = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
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
        actions: [
          ElevatedButton(
            onPressed: (){

            },
            child: Text(
              "Add item${widget.productList.length > 1?"s":""} to cart",
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: itemsNo,
              itemBuilder: (ctx, int position){
                Product product = widget.productList[position];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0,),
                      Text(
                        product.product_name!,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.blueGrey
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Center(
                        child: ExtendedImage.network(
                          "${ApiConstants.baseUrl}/images/products/${product.product_photo!}",
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "KES. ${product.product_price}",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Palette.orange1,
                            ),
                          ),
                          Text(
                            "Available ${product.product_quantity}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Palette.textColor2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
