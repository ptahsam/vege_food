import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/product.dart';

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
      body: Stack(
        children: [
          PageView.builder(
            itemCount: itemsNo,
            itemBuilder: (ctx, int position){
              Product product = widget.productList[position];
              return ExtendedImage.network(
                "${ApiConstants.baseUrl}/images/products/${product.product_photo!}",
              );
            },
          ),
        ],
      ),
    );
  }
}
