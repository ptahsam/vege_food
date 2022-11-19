import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/product.dart';
import 'package:vege_food/config/palette.dart';

class SingleProductCard extends StatelessWidget {
  final Product product;
  const SingleProductCard({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ExtendedImage.network(
              "${ApiConstants.baseUrl}/images/products/${product.product_photo!}",
              height: 150.0,
              width: 150.0,
              fit: BoxFit.scaleDown,
              cache: true,
              mode: ExtendedImageMode.gesture,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      product.product_name!,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      product.product_description!,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Palette.textColor1,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          product.product_quantity!,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Palette.primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Palette.accentColor
                        ),
                        child: Text(
                          "KES.${product.product_price!}",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.redAccent
                          ),
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
    );
  }
}
