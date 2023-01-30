import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/orderItem.dart';
import 'package:vege_food/Models/orders.dart';
import 'package:vege_food/Models/user.dart';
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
    User? user = Provider.of<AppData>(context).user != null?Provider.of<AppData>(context).user!:null;
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
              color: Colors.white,
            ),
            child: Icon(
              Icons.close,
              color: Colors.black,
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
          InkWell(
            onTap: (){
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                ),
                context: context,
                builder: (context) => buildOrderOptions(),
              );
            },
            child: Container(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
              ),
            ),
          ),
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
            widget.order.payment_id != null && widget.order.payment_id != ""?SizedBox.shrink():InkWell(
              onTap: () async{
                if(user!.user_phone != null && user.user_phone != "") {
                  var res = await Navigator.push(context, PageTransition(
                      child: MpesaPayment(
                        userphone: "254${user.user_phone!.length>9?
                        user.user_phone!.substring(1):
                        user.user_phone}", orderid: widget.order
                          .order_refno!.toUpperCase(), amount: double.parse(
                        getTotalOrderAmount(widget.item),),),
                      type: PageTransitionType.rightToLeft));
                  if (res != null) {
                    AssistantMethods.getUserOrderItems(
                        context, await getUserId());
                    Navigator.pop(context);
                  }
                }else{
                  displayToastMessage("Please add payment number to your account", context);
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
                    "Make Payment",
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
    );
  }

  Widget buildOrderOptions() {
    return Container(
      padding: const EdgeInsets.only(left: 12.0, top: 30.0, right: 12.0, bottom: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              String res = await AssistantMethods.removeOrder(context, widget.order.order_refno!);
              if(res == "SUCCESSFULLY_REMOVED"){
                AssistantMethods.getUserOrderItems(context, await getUserId());
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    iconSize: 22.0,
                    onPressed: () => {},
                  ),
                ),
                const SizedBox(width: 14.0,),
                const Text(
                  "Remove this order",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              String res = await AssistantMethods.generateOrder(context, widget.order.order_refno!, await getUserId());
              Navigator.pop(context);
              Navigator.push(context, PageTransition(child: ViewaGeneratedOrder(ordername: res,), type: PageTransitionType.rightToLeft));
              /*showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                ),
                context: context,
                builder: (context) => buildOrderDownload(res),
              );*/
              //displayToastMessage(res, context);
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.print,
                      color: Colors.blue,
                    ),
                    iconSize: 22.0,
                    onPressed: () => {},
                  ),
                ),
                const SizedBox(width: 14.0,),
                const Text(
                  "Generate and email order",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderDownload(String res) {
    return Container(
      padding: const EdgeInsets.only(left: 12.0, top: 30.0, right: 12.0, bottom: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  res,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5.0,),
              InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    //add more permission to request here.
                  ].request();

                  if(statuses[Permission.storage]!.isGranted){
                    Directory directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first;
                    if(directory != null){
                      String savePath =  directory.path + "/${res}";
                      //output:  /storage/emulated/0/Download/banner.png

                      try {
                        await Dio().download(
                            "${ApiConstants.baseUrl}/reports/${res}",
                            savePath,
                            onReceiveProgress: (received, total) {
                              if (total != -1) {
                                print((received / total * 100).toStringAsFixed(0) + "%");
                                //you can build progressbar feature too
                              }
                            });
                        print("File is saved to download folder.");
                      } on DioError catch (e) {
                        print(e.message);
                      }
                    }
                  }else{
                    print("No permission to read and write.");
                  }
                },
                child: Icon(
                  Icons.download,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
