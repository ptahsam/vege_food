import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/orderItem.dart';
import 'package:vege_food/Models/orders.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/view_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          "Orders",
        ),
        centerTitle: false,
        actions: [
          Provider.of<AppData>(context).userOrder != null?Container(
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
                  Provider.of<AppData>(context).userOrder!.length.toString(),
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
        child: Provider.of<AppData>(context).userOrder != null?ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          itemCount: Provider.of<AppData>(context).userOrder!.length,
          itemBuilder: (ctx, int index){
            Order order = Provider.of<AppData>(context).userOrder![index];
            return OrderData(order: order);
          },
        ):Align(
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
                    "No orders.",
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
    );;
  }
}

class OrderData extends StatefulWidget {
  final Order order;
  const OrderData({
    Key? key,
    required this.order
  }) : super(key: key);

  @override
  State<OrderData> createState() => _OrderDataState();
}

class _OrderDataState extends State<OrderData> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AssistantMethods.getOrderItems(context, widget.order.order_refno!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Palette.accentColor,
        border: Border.all(
          width: 1.0,
          color: Palette.greyBorder,
        ),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Column(
        children: [
          Text(
            'ORDER ID: ${widget.order.order_refno!.toUpperCase()}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  '${convertToFullDate(int.parse(widget.order.date_added!) * 1000)}',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  Provider.of<AppData>(context).orderItem != null?
                  '${getTotalOrderItems(Provider.of<AppData>(context).orderItem!)}':"",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
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
                  Provider.of<AppData>(context).orderItem != null?
                  'KES. ${getTotalOrderAmount(Provider.of<AppData>(context).orderItem!)}.00':"",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              List<OrderItem> items = Provider.of<AppData>(context, listen: false).orderItem!;
              Navigator.push(context, PageTransition(child: ViewOrder(order: widget.order, item: items), type: PageTransitionType.rightToLeft));
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Palette.primaryColor,
              ),
              child: Text(
                "View Order",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


