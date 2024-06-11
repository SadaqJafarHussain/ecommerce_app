import 'package:ecommerce_app/Models/product_model.dart';
import 'package:ecommerce_app/core/app_export.dart';
import 'package:ecommerce_app/presentation/ItemDetails/item_details.dart';
import 'package:ecommerce_app/presentation/Sign%20up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_model.dart';
class ProductItem extends StatelessWidget {
    final ProductModel model;
   ProductItem({required this.model,
    super.key});

  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ItemDetails(model: model,)));
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:const BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                  child: FadeInImage.assetNetwork(
                    height: 300.h,
                      fadeInDuration: const Duration(seconds: 1),
                      fit: BoxFit.fill,
                      fadeInCurve: Curves.bounceIn,
                      image: model.productImage,
                      placeholder:'assets/images/loading.png'),
                ),
                Positioned(
                  top: 5.0,
                  right: 5.0,
                  child:  CircleAvatar(
                    backgroundColor:const Color(0xffCECECE),
                    child: IconButton(
                      onPressed: () async{
                        if(_provider.userId==0){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));

                        }else {
                          Provider.of<ModelProvider>(context,listen: false).manageWishList(model);
                        }
                      },
                      icon: Icon(model.iswish=='yes'?Icons.favorite:Icons.favorite_border,color: Color(0xff514EB7),),
                    ),
                  ),),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration:const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0,top: 5.0),
                          child: Text(
                            'IQD ${model.productPrice}',style: TextStyle(
                              fontSize: 18.fSize,
                              color:const Color(0xffFFFFFF),
                              fontFamily: 'Cairo'),),
                        ),
                        InkWell(
                          onTap: () async{
                            if(_provider.userId==0){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));

                            }else {
                              Provider.of<ModelProvider>(context,listen: false).addCartProducts(model);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 45.h,
                            decoration:const BoxDecoration(
                              color: Color(0xff514EB7),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                            ),
                            child:const Icon(
                              Icons.shopping_cart_outlined,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            
            ),
          ),
          SizedBox(height: 5
            ,),
          Text(
            '${model.productTitle}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.fSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo'),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
