import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/category_items.dart';
import 'package:vege_food/sharedWidgets/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> categories = [];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AssistantMethods.getAllProducts(context);
    AssistantMethods.getAllCategories(context);
    AssistantMethods.getTopProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Text(
              "VegeFood",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
              ),
            ),
            actions: [
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(right: 15.0),
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
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(right: 15.0),
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
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(right: 12.0),
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
            ],
          ),
          SliverToBoxAdapter(
            child: Provider.of<AppData>(context).categoriesList != null?Container(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20),
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
                            height: 100,
                            width: 100,
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
                                fontSize: 22.0,
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
                              height: 100.0,
                              width: 100.0,
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
                                    color: Palette.greyBorder
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Expanded(
                              child: Text(
                                categories.category_name!,
                                style: TextStyle(
                                  fontSize: 22.0,
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
            ):SizedBox.shrink(),
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
                          color: Palette.primaryColor,
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
                                            Text(
                                              product.product_name!,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                            Text(
                                              "KES. ${product.product_price!}.00",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.redAccent
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.0,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, PageTransition(child: ProductDetails(product: product,), type: PageTransitionType.rightToLeft));
                                        },
                                        child: Center(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25.0),
                                              color: Palette.primaryColor,
                                            ),
                                            child: Text("Get Offer"),
                                          ),
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
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ],
            ):SizedBox.shrink(),
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
                    fontSize: 22.0,
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
                Container(
                  height: 1.0,
                  decoration: BoxDecoration(
                      color: Palette.greyBorder
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Provider.of<AppData>(context).productList != null?Container(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: Provider.of<AppData>(context).productList!.length,
                itemBuilder: (ctx, int index){
                  Product product = Provider.of<AppData>(context).productList![index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: ProductDetails(product: product,), type: PageTransitionType.rightToLeft));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          width: 1.0,
                          color: Palette.greyBorder,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Image.network(
                              "${ApiConstants.baseUrl}/images/products/${product.product_photo!}",
                              height: 150.0,
                              width: double.infinity,
                              fit: BoxFit.scaleDown,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.product_name!,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueGrey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Palette.accentColor
                                  ),
                                  child: Text(
                                    "KES.${product.product_price!}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.redAccent
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ):Align(
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

