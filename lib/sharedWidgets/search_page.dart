import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/single_product_card.dart';
import 'package:vege_food/sharedWidgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  late FocusNode myFocusNode;

  List<Product> searchProductList = [];
  List<Categories> searchCategoryList = [];
  TextEditingController textSearchEditingController = TextEditingController();
  bool _iconIsVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textSearchEditingController.addListener(search);
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
  }

  search(){
    if(textSearchEditingController.value.text.isNotEmpty){

      List<Product> resultProduct = Provider.of<AppData>(context, listen: false).productList!.where((Product product)
      => product.product_name!.toLowerCase().contains(textSearchEditingController.value.text.toLowerCase())
          || product.product_description!.toLowerCase().contains(textSearchEditingController.value.text.toLowerCase())
      ).toSet().toList();

      List<Categories> resultCategory = Provider.of<AppData>(context, listen: false).categoriesList!.where((Categories category)
      => category.category_name!.toLowerCase().contains(textSearchEditingController.value.text.toLowerCase())
      ).toSet().toList();

      setState(() {
        searchProductList = resultProduct.toSet().toList();
        searchCategoryList = resultCategory.toSet().toList();
        _iconIsVisible = true;
      });

    }else{
      setState(() {
        searchProductList.clear();
        searchCategoryList.clear();
        _iconIsVisible = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
    textSearchEditingController.dispose();
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
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100]!,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: myFocusNode,
                          controller: textSearchEditingController,
                          onChanged: (input){

                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Type to search ...",
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),

                        ),
                      ),
                      Visibility(
                        visible: _iconIsVisible,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              searchProductList.clear();
                              searchCategoryList.clear();
                              textSearchEditingController.text = "";
                              _iconIsVisible = false;
                            });
                          },
                          child: Icon(
                              Icons.close
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              searchProductList.isNotEmpty?Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.0,
                      margin: EdgeInsets.only(right: 3.0),
                      color: Palette.greyBorder,
                    ),
                  ),
                  Text(
                    "Products",
                    style: TextStyle(
                      color: Palette.textColor1,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.0,
                      margin: EdgeInsets.only(right: 3.0),
                      color: Palette.greyBorder,
                    ),
                  ),
                ],
              ):SizedBox.shrink(),
              searchProductList.isNotEmpty?Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                margin: EdgeInsets.only(bottom: 20.0),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 20.0),
                  itemCount: searchProductList.length,
                  itemBuilder: (ctx, int index){
                    Product product = searchProductList[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: ProductDetails(product: product,), type: PageTransitionType.rightToLeft));
                      },
                      child: SingleProductCard(product: product),
                    );
                  },
                ),
              ):SizedBox.shrink(),
              searchCategoryList.isNotEmpty?Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.0,
                      margin: EdgeInsets.only(right: 3.0),
                      color: Palette.greyBorder,
                    ),
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: Palette.textColor1,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.0,
                      margin: EdgeInsets.only(right: 3.0),
                      color: Palette.greyBorder,
                    ),
                  ),
                ],
              ):SizedBox.shrink(),
              searchProductList.isNotEmpty?Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
                  itemCount: searchCategoryList.length,
                  itemBuilder: (ctx, int index){
                    Categories category = searchCategoryList[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: CategoryItems(category: category,), type: PageTransitionType.rightToLeft));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExtendedNetworkImageProvider(
                                  "${ApiConstants.baseUrl}/images/categories/${category.category_image!}",
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
                          SizedBox(width: 10.0,),
                          Text(
                            category.category_name!,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ):SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
