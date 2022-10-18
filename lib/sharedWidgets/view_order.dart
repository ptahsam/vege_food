import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/orderItem.dart';
import 'package:vege_food/Models/orders.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/widgets.dart';

class ViewOrder extends StatefulWidget {
  final Order order;
  final List<OrderItem> item;
  const ViewOrder({
    Key? key,
    required this.order,
    required this.item
  }) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
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
          widget.item != null?Container(
            margin: EdgeInsets.only(right: 12.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Palette.accentColor,
              shape: BoxShape.circle,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  //getTotalOrderItems(widget.item),
                  widget.item.length.toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ):SizedBox.shrink(),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${convertToFullDate(int.parse(widget.order.date_added!) * 1000)}',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total amount:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'KES. ${getTotalOrderAmount(widget.item)}.00',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ref no:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.order.order_refno!.toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Expanded(
              child: ListView.builder(
                itemCount: widget.item.length,
                itemBuilder: (ctx, int index){
                  OrderItem item = widget.item[index];
                  return InkWell(
                    onTap: (){
                      //Navigator.push(context, PageTransition(child: ProductDetails(product: item.productItem!,), type: PageTransitionType.rightToLeft));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Palette.greyBorder,
                          ),
                          bottom: widget.item.length == index + 1?BorderSide(
                            width: 1,
                            color: Palette.greyBorder,
                          ):BorderSide.none,
                        ),
                      ),
                      child: ListTile(
                        leading: Stack(
                          children: [
                            Container(
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
                                "${ApiConstants.baseUrl}/images/products/${item.productItem!.product_photo!}",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Palette.accentColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(25.0)
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Text(
                                      '${index+1}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          item.productItem!.product_name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                            fontSize: 18.0,
                          ),
                        ),
                        subtitle: Text(
                          item.productItem!.product_description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Palette.black6
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "KES. ${int.parse(item.productItem!.product_price!) * int.parse(item.items_no!)}.00",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent
                              ),
                            ),
                            Text(
                              "${item.items_no}",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Palette.black6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
