import 'package:ecommerce_app/Models/product_model.dart';
import 'package:ecommerce_app/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/provider_model.dart';
import '../presentation/ItemDetails/item_details.dart';
class SearchItem extends StatelessWidget {
  final ProductModel model;
  int index;
  SearchItem({
    required this.index,
    required this.model,
    super.key});

  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ItemDetails(model:_provider.products.where((element) => element.productId==model.productId).first,)));
      },
      child: SizedBox(
        height: 120.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          color: Color(0xffFFFFFF),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 150.h,
                  width: 150.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(model.productImage),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '${model.productTitle}',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.08,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        'IQD ${model.productPrice}',style: TextStyle(
                          fontSize: 15.fSize,
                          color: Colors.black,
                          fontFamily: 'Cairo'),),
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }}

