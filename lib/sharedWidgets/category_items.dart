import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/category.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/sharedWidgets/product_details.dart';
import 'package:vege_food/sharedWidgets/widgets.dart';

class CategoryItems extends StatefulWidget {
  final Categories category;
  const CategoryItems({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AssistantMethods.getProductsByCategory(context, widget.category.id!.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          widget.category.category_name!,
        ),
        centerTitle: false,
        flexibleSpace: FlexibleSpaceBar(
          background: ExtendedImage.network(
            "${ApiConstants.baseUrl}/images/categories/${widget.category.category_image!}",
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Provider.of<AppData>(context).categoryProductsList != null?ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        itemCount: Provider.of<AppData>(context).categoryProductsList!.length,
        itemBuilder: (BuildContext context, int index){
          Product product = Provider.of<AppData>(context).categoryProductsList![index];
          return InkWell(
            onTap: (){
              Navigator.push(context, PageTransition(child: ProductDetails(product: product,), type: PageTransitionType.rightToLeft));
            },
            child: SingleProductCard(product: product,),
          );
        },
      ):Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
