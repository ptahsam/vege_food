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
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          widget.category.category_name!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 10.0, bottom: 10.0),
            child: IconButton(
              onPressed: (){
                List<Product> listProduct = Provider.of<AppData>(context, listen: false).categoryProductsList!;
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(listProduct)
                );
              },
              icon: Icon(
                Icons.search_rounded,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
          title: Text(result.product_name!),
          ),
        );
      },
    );
  }
}

