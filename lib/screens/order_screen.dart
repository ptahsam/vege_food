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

  int _selectedIndex = 0;

  getData() async{
    AssistantMethods.getUserOrderItems(context, await getUserId());
  }

  @override
  Widget build(BuildContext context) {
    List<Order> orders = Provider.of<AppData>(context).userOrder!=null?Provider.of<AppData>(context).userOrder!:[];
    List<Order> paidOrders = orders.isNotEmpty?manageOrders(orders, "paid"):[];
    List<Order> unpaidOrders = orders.isNotEmpty?manageOrders(orders, "unpaid"):[];
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: RefreshIndicator(
          onRefresh: (){
            return Future.delayed(
              Duration(seconds: 1), () async {
              getData();
            },
            );
          },
          child: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (context, bool s) => [
              SliverAppBar(
                leadingWidth: 0,
                floating: true,
                pinned: true,
                snap: true,
                elevation: 30.0,
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
                bottom: TabBar(
                  onTap: (index){
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Palette.primaryColor,
                        width: 3.0,
                      ),
                    ),
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Orders",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          unpaidOrders.isNotEmpty?Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Palette.primaryColor.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              unpaidOrders.length.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ):SizedBox.shrink(),
                        ]
                      ),
                    ),
                    Tab(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "History",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                              paidOrders.isNotEmpty?Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Palette.primaryColor.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  paidOrders.length.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ):SizedBox.shrink(),
                          ]
                      ),
                    ),
                  ],
                ),
              ),
            ],
            body: IndexedStack(
              index: _selectedIndex,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: unpaidOrders.isNotEmpty?ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                          itemCount: unpaidOrders.length,
                          itemBuilder: (ctx, int index){
                            Order order = unpaidOrders[index];
                            return OrderData(order: order);
                          },
                        ):Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "To create orders, First add items to cart then make your order.",
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Palette.textColor2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: paidOrders.isNotEmpty?ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: paidOrders.length,
                          itemBuilder: (ctx, int index){
                            Order order = paidOrders[index];
                            return OrderData(order: order);
                          },
                        ):Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
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
                                    "No orders history.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Palette.black6,
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "To create orders, First add items to cart then make your order.",
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Palette.textColor2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      )
    );
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
    //AssistantMethods.getOrderItems(context, widget.order.order_refno!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Banner(
      message: widget.order.payment_id != null && widget.order.payment_id !=""?"Paid":"Unpaid",
      location: BannerLocation.topStart,
      color: widget.order.payment_id != null && widget.order.payment_id !=""?Palette.primaryColor.withOpacity(0.7):Colors.red.withOpacity(0.7),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
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
                    getTotalOrderItems(widget.order.listOrderItems!),
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
                    'KES. ${getTotalOrderAmount(widget.order.listOrderItems!)}.00',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: widget.order.payment_id != null && widget.order.payment_id !=""?MainAxisAlignment.end:MainAxisAlignment.spaceBetween,
                children: [
                  /*widget.order.payment_id != null && widget.order.payment_id !=""?SizedBox.shrink():Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Palette.orange1.withOpacity(0.7),
                    ),
                    child: Text(
                      "Pay Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0
                      ),
                    ),
                  ),*/
                  InkWell(
                    onTap: (){
                      List<OrderItem> items = widget.order.listOrderItems!;
                      Navigator.push(context, PageTransition(child: ViewOrder(order: widget.order, item: items), type: PageTransitionType.rightToLeft));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Palette.primaryColor,
                      ),
                      child: Text(
                        "View Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


