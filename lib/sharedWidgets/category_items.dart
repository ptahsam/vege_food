import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/category.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
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
        ],
      ),
    );
  }
}
