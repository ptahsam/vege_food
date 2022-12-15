import 'package:collection/collection.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/cart.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/screens/navbar_screen.dart';
import 'package:vege_food/sharedWidgets/cart_details.dart';
import 'package:vege_food/sharedWidgets/category_items.dart';
import 'package:vege_food/sharedWidgets/product_details.dart';
import 'package:vege_food/sharedWidgets/search_page.dart';
import 'package:vege_food/sharedWidgets/single_product_card.dart';
import 'package:vege_food/sharedWidgets/view_quick_orders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> categories = [];
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _cardHeight = 300.0;
  bool isAddingProduct = false;

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    getInternetConnection(context);
    getData();
    //displayInternetCard();
  }

  getData() async{
    AssistantMethods.getAllProducts(context);
    AssistantMethods.getAllCategories(context);
    AssistantMethods.getTopProducts(context);
    AssistantMethods.getUserCartItems(context, await getUserId());
    AssistantMethods.getUserOrderItems(context, await getUserId());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    internetconnection! .cancel();
  }

  @override
  Widget build(BuildContext context) {
    bool isOffline = Provider.of<AppData>(context).isoffline;
    List<Product> pList = Provider.of<AppData>(context).productList!=null?Provider.of<AppData>(context).productList!:[];
    var newMap = groupBy(pList, (Product product) => product.category_id);
    if(!isOffline){
      //getData();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: (){
            return Future.delayed(
              Duration(seconds: 1), () async {
              getData();
            },
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                pinned: false,
                floating: true,
                title: Text(
                  "VegeFood",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    color: Palette.primaryColor,
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: (){
                      showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(pList)
                      );
                      //Navigator.push(context, PageTransition(child: SearchPage(), type: PageTransitionType.rightToLeft));
                    },
                    child:  Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(right: 15.0, top: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.search_rounded,
                            size: 28.0,
                            color: Palette.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //Navigator.pushReplacementNamed(context, '/');
                      //Navigator.push(context, PageTransition(child: NavBarScreen(isNavigate: true, navigateIndex: 1,), type: PageTransitionType.rightToLeft));
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(right: 15.0, top: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_basket,
                            size: 28.0,
                            color: Palette.primaryColor,
                          ),
                        ),
                        Positioned(
                          right: 5.0,
                          top: 5.0,
                          child: Provider.of<AppData>(context).userOrder != null?Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                Provider.of<AppData>(context).userOrder!.length.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ):SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: CartDetails(), type: PageTransitionType.rightToLeft));
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(right: 12.0, top: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            size: 28.0,
                            color: Palette.primaryColor,
                          ),
                        ),
                        Positioned(
                          right: 5.0,
                          top: 5.0,
                          child: Provider.of<AppData>(context).userCart != null?Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                '${int.parse(getTotalCartItems(Provider.of<AppData>(context).userCart!)) > 9?"9+":getTotalCartItems(Provider.of<AppData>(context).userCart!)}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ):SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Provider.of<AppData>(context).categoriesList != null?Container(
                  height: 120.0,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: Provider.of<AppData>(context).categoriesList!.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, int index){
                      if(index == 0){
                        return Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette.greyBorder,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.green,
                                  ),
                                ),
                                child: Image.asset(
                                  "images/grocery_icon.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              Expanded(
                                child: Text(
                                  "Groceries",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Palette.textColor1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }else{
                        Categories categories = Provider.of<AppData>(context).categoriesList![index - 1];
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: CategoryItems(category: categories,), type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ExtendedNetworkImageProvider(
                                        "${ApiConstants.baseUrl}/images/categories/${categories.category_image!}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color: Palette.orange1.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Expanded(
                                  child: Text(
                                    categories.category_name!,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: Palette.textColor1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ):Container(
                  height: 120.0,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20),
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, int index){
                      return Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            FadeShimmer.round(
                              size: 60,
                              fadeTheme: FadeTheme.light,
                            ),
                            SizedBox(height: 10.0,),
                            Expanded(
                              child: FadeShimmer(
                                height: 4.0,
                                width: 60,
                                radius: 4,
                                highlightColor: Color(0xffF9F9FB),
                                baseColor: Color(0xffE6E8EB),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    newMap.isNotEmpty?Container(
                      margin: EdgeInsets.only(top: 30.0),
                      padding: EdgeInsets.only(top: 20),
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Palette.accentColor.withOpacity(0.4),
                        border: Border(
                          top: BorderSide(
                            color: Palette.greyBorder,
                            width: 1,
                          ),
                        ),
                      ),
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: newMap.length,
                        itemBuilder: (context, position){
                          return _buildPageItem(position, newMap);
                        },
                      ),
                    ):Container(
                      height: 400.0,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                      child: FadeShimmer(
                        radius: 15.0,
                        height: 340,
                        width: MediaQuery.of(context).size.width - 24,
                        highlightColor: Color(0xffF9F9FB),
                        baseColor: Color(0xffE6E8EB),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 15,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "Quick Orders",
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: newMap.isNotEmpty?DotsIndicator(
                        dotsCount: newMap.length,
                        position: _currPageValue,
                        decorator: DotsDecorator(
                          size: Size.square(9.0),
                          activeSize: Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          activeColor: Palette.primaryColor.withOpacity(0.5),
                        ),
                      ):Center(
                        child: FadeShimmer(
                          width: 60.0,
                          height: 20.0,
                          highlightColor: Color(0xffF9F9FB),
                          baseColor: Color(0xffE6E8EB),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Provider.of<AppData>(context).productTopList != null?Stack(
                  children: [
                    Container(
                      height: 300,
                      margin: EdgeInsets.only(top: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Palette.accentColor,
                        border: Border(
                          top: BorderSide(
                            color: Palette.greyBorder,
                            width: 1,
                          ),
                          /*bottom: BorderSide(
                            color: Palette.greyBorder,
                            width: 1,
                          ),*/
                        ),
                        shape: BoxShape.rectangle
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: Provider.of<AppData>(context).productTopList!.length,
                        itemBuilder: (context, int index){
                          Product product = Provider.of<AppData>(context).productTopList![index];
                          return Container(
                            margin: EdgeInsets.only(right: 10.0),
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Banner(
                              message: "20% off !!",
                              location: BannerLocation.topEnd,
                              color: index.isOdd?Palette.primaryColor.withOpacity(0.7):Colors.red.withOpacity(0.7),
                              child: Container(
                                width: 270.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Palette.greyBorder,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: [
                                    ExtendedImage.network(
                                      "${ApiConstants.baseUrl}/images/products/${product.product_photo!}",
                                      height: 150.0,
                                      width: double.infinity,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    product.product_name!,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "KES. ${product.product_price!}.00",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.redAccent
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 7.0,),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, PageTransition(child: ProductDetails(product: product,), type: PageTransitionType.rightToLeft));
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(25.0),
                                                        color: Palette.orange1.withOpacity(0.7),
                                                      ),
                                                      child: Text("Get Offer"),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: (){

                                                  },
                                                  child: Text(
                                                    "Add to cart",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                    Positioned(
                      left: 12.0,
                      top: 15,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          "Top Picks",
                          style: TextStyle(
                            color: Palette.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ):Stack(
                  children: [
                    Container(
                      height: 300,
                      margin: EdgeInsets.only(top: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Palette.accentColor,
                          border: Border(
                            top: BorderSide(
                              color: Palette.greyBorder,
                              width: 1,
                            ),
                          ),
                          shape: BoxShape.rectangle
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (ctx, int index){
                          return Container(
                            margin: EdgeInsets.only(right: 10.0),
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Container(
                              width: 250.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Palette.greyBorder,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: FadeShimmer(
                                      width: 250 - 24,
                                      height: 150,
                                      highlightColor: Color(0xffF9F9FB),
                                      baseColor: Color(0xffE6E8EB),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: FadeShimmer(
                                                  width: 95,
                                                  height: 20,
                                                  highlightColor: Color(0xffF9F9FB),
                                                  baseColor: Color(0xffE6E8EB),
                                                ),
                                              ),
                                              SizedBox(width: 10.0,),
                                              FadeShimmer(
                                                width: 45,
                                                height: 20,
                                                highlightColor: Color(0xffF9F9FB),
                                                baseColor: Color(0xffE6E8EB),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: Center(
                                            child: FadeShimmer(
                                              width: double.infinity,
                                              height: 20,
                                              highlightColor: Color(0xffF9F9FB),
                                              baseColor: Color(0xffE6E8EB),
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                            color: Palette.greyBorder
                        ),
                      ),
                    ),
                    Text(
                      "Shop for groceries",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Palette.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                            color: Palette.greyBorder
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Provider.of<AppData>(context).productList != null?SliverAnimatedList(
                initialItemCount: Provider.of<AppData>(context).productList!.length,
                itemBuilder: (ctx, int index, Animation){
                  Product product = Provider.of<AppData>(context).productList![index];
                  return Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0, top: index == 0?20.0:0.0, bottom: index == (Provider.of<AppData>(context).productList!.length - 1)?20.0:0.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: ProductDetails(product: product,), type: PageTransitionType.rightToLeft));
                      },
                      child: SingleProductCard(product: product,),
                    ),
                  );
                }
              ):SliverAnimatedList(
                //padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                initialItemCount: 10,
                itemBuilder: (ctx, int index, Animation){
                  return Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0, top: index == 0?20.0:0.0, bottom: index == (10 - 1)?20.0:0.0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          width: 1.0,
                          color: Palette.greyBorder,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            FadeShimmer(
                              radius: 5.0,
                              height: 150.0,
                              width: 150.0,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: FadeShimmer(
                                      height: 20.0,
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      highlightColor: Color(0xffF9F9FB),
                                      baseColor: Color(0xffE6E8EB),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: FadeShimmer(
                                      height: 20.0,
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      highlightColor: Color(0xffF9F9FB),
                                      baseColor: Color(0xffE6E8EB),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: FadeShimmer(
                                          height: 20.0,
                                          width: 40,
                                          highlightColor: Color(0xffF9F9FB),
                                          baseColor: Color(0xffE6E8EB),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25.0),
                                            color: Palette.accentColor
                                        ),
                                        child: FadeShimmer(
                                          height: 20.0,
                                          width: 40,
                                          highlightColor: Color(0xffF9F9FB),
                                          baseColor: Color(0xffE6E8EB),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageItem(int index, Map<int?, List<Product>> newMap,){
    Matrix4 matrix = Matrix4.identity();
    if(index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _cardHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor() + 1){
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _cardHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor() - 1){
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _cardHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _cardHeight * (1 - _scaleFactor) / 2, 0);
    }

    List pList = [];
    newMap.forEach((k,v) => pList.add(v));

    List<Product> productList = pList[index];

    return Transform(
      transform: matrix,
      child: OrderCard(productList: productList, index: index),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Product> searchTerms;

  CustomSearchDelegate(this.searchTerms);

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (var product in searchTerms) {
      if (product.product_name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                width: 1.0,
                color: Palette.greyBorder,
              ),
            ),
            child: ExtendedImage.network(
              "${ApiConstants.baseUrl}/images/products/${result.product_photo!}",
              height: 40.0,
              width: 40.0,
            ),
          ),
          title: Text(result.product_name!),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];

    for (var product in searchTerms) {
      if (product.product_name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, PageTransition(child: ProductDetails(product: result,), type: PageTransitionType.rightToLeft));
          },
          child: ListTile(
            leading: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  width: 1.0,
                  color: Palette.greyBorder,
                ),
              ),
              child: ExtendedImage.network(
                "${ApiConstants.baseUrl}/images/products/${result.product_photo!}",
                height: 40.0,
                width: 40.0,
              ),
            ),
            title: Text(result.product_name!),
          ),
        );
      },
    );
  }
}

class OrderCard extends StatefulWidget {
  final List<Product> productList;
  final int index;
  const OrderCard({
    Key? key,
    required this.productList,
    required this.index
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  bool isAddingQuickOrder = false;
  int j = 0;
  int itemsNo = 0;
  String status = "";

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
    return Stack(
      children: [
        widget.productList.isNotEmpty?InkWell(
          onTap: (){
            Navigator.push(context, PageTransition(child: ViewQuickOrders(productList: widget.productList,), type: PageTransitionType.rightToLeft));
          },
          child: Container(
            height: 250,
            margin: EdgeInsets.only(left: 10, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: widget.index.isEven?Palette.orange1.withOpacity(0.5):Palette.primaryColor.withOpacity(0.5),
            ),
            child: widget.productList.length == 1?Stack(
              children: [
                Positioned.fill(
                  child: ExtendedImage.network(
                    "${ApiConstants.baseUrl}/images/products/${widget.productList[0].product_photo!}",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ):widget.productList.length == 2?Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 40,
                  child: ExtendedImage.network(
                    "${ApiConstants.baseUrl}/images/products/${widget.productList[0].product_photo!}",
                    width: (MediaQuery.of(context).size.width * 0.90)*0.5,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 40,
                  child: ExtendedImage.network(
                    "${ApiConstants.baseUrl}/images/products/${widget.productList[1].product_photo!}",
                    width: (MediaQuery.of(context).size.width * 0.90)*0.5,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ):widget.productList.length >= 3?Stack(
              children: [
                Positioned.fill(
                  child: ExtendedImage.network(
                    "${ApiConstants.baseUrl}/images/products/${widget.productList[0].product_photo!}",
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 20,
                  child: ExtendedImage.network(
                    "${ApiConstants.baseUrl}/images/products/${widget.productList[1].product_photo!}",
                    width: (MediaQuery.of(context).size.width * 0.90)*0.5,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 20,
                  child: ExtendedImage.network(
                    "${ApiConstants.baseUrl}/images/products/${widget.productList[2].product_photo!}",
                    width: (MediaQuery.of(context).size.width * 0.90)*0.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ):SizedBox.shrink(),
          ),
        ):SizedBox.shrink(),
        Provider.of<AppData>(context).productList != null?Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 150.0,
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 5.0,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: ViewQuickOrders(productList: widget.productList,), type: PageTransitionType.rightToLeft));
                    },
                    child: Text(
                      "${widget.productList.length == 1?widget.productList[0].product_name!
                          :widget.productList.length == 2?widget.productList[0].product_name!+", "+ widget.productList[1].product_name!
                          :widget.productList.length >= 3?widget.productList[0].product_name!+", "+widget.productList[1].product_name!+", "+widget.productList[2].product_name!
                          :""}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: widget.productList.length > 1?2:1,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.blueGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "A discount of 20% will be applied.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.red.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "KES. ${getTotalProductAmount(widget.productList)}",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Palette.orange1,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.primaryColor.withOpacity(0.7),
                        ),
                        onPressed: () async {
                          setState(() {
                            isAddingQuickOrder = true;
                          });
                          User user = Provider.of<AppData>(context, listen: false).user!;
                          for(var i = 0; i < itemsNo; i++){
                            String res = await AssistantMethods.addItemToCart(context, user.id!.toString(), widget.productList[i].id!.toString(), "1");
                            if(res == "SUCCESSFULLY_ADDED"){
                              setState((){
                                j = i;
                                status = "SUCCESSFULLY_ADDED";
                              });
                            }else{
                              displayToastMessage("An error occurred. Please try again later.", context);
                            }
                          }
                          if(j == (itemsNo - 1) && status == "SUCCESSFULLY_ADDED"){
                            setState(() {
                              isAddingQuickOrder = false;
                            });
                            AssistantMethods.getUserCartItems(context, user.id!.toString());
                          }
                        },
                        child: isAddingQuickOrder?Row(
                          children: [
                            Container(
                              height: 14.0,
                              width: 14.0,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5,),
                            ),
                            SizedBox(width: 4.0,),
                            Text(
                              "Adding ...",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ):Text(
                          "Add item${widget.productList.length > 1?"s":""} to cart",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ):SizedBox.shrink(),
      ],
    );
  }
}





