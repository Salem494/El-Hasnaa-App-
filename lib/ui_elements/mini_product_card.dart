import 'package:elhasnaa/data_model/products.dart';
import 'package:elhasnaa/data_model/related_product.dart';
import 'package:elhasnaa/my_theme.dart';
import 'package:elhasnaa/screens/product_details.dart';
import 'package:flutter/material.dart';


class MiniProductCard extends StatefulWidget {
  Products relProd;

  MiniProductCard({Key? key, required this.relProd})
      : super(key: key);

  @override
  _MiniProductCardState createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {
  // RelatedProducts relatProd=widget.relProd;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(product: widget.relProd,);
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: MyTheme.light_grey, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.width - 36) / 3.5,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.zero),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: 'https://alhasnaa.site/files/' + widget.relProd.prodImg!,
                        fit: BoxFit.cover,
                      ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: Text(
                  widget.relProd.brandNameAr!,//todoLoca
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 11,
                      height: 1.2,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  widget.relProd.prodPrice!,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: MyTheme.accent_color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
              (widget.relProd.isOffer== "true")? Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  widget.relProd.prodPrice!,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      decoration:TextDecoration.lineThrough,
                      color: MyTheme.medium_grey,
                      fontSize: 9,
                      fontWeight: FontWeight.w600),
                ),
              ):Container(),
            ]),
      ),
    );
  }
}