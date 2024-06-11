import 'package:ecommerce_app/Models/category_model.dart';
import 'package:ecommerce_app/core/app_export.dart';
import 'package:ecommerce_app/presentation/MainScreen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_model.dart';

class SubCategoryScreen extends StatelessWidget {
 final CategoryModel categoryModel;
  const SubCategoryScreen({required this.categoryModel,super.key});

  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.name!,
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 20.h,
          ),),
      ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              physics:const NeverScrollableScrollPhysics(),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.2,
                crossAxisCount: 3, // number of items in each row
                mainAxisSpacing: 4.0, // spacing between rows
                crossAxisSpacing: 1.0,
                // spacing between columns
              ),
              itemCount: _provider.subCategories.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: ()async{
                    await _provider.getSubProducts(_provider.subCategories[index].id!);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductsScreen(slider: false, moreText: false)));
                  },
                  child:_provider.subCategories.length==0? Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset('assets/images/nocat.png'),
                      const Text(
                        "لاتوجد تصنيفات",
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                      ),
                      const Text("يبدو ان المالك لم يقم باضافة تصنيفات",style: TextStyle(
                          fontFamily: 'Cairo'
                      ),),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )) : Column(
                    children: [
                      Text(_provider.subCategories[index].name!,overflow: TextOverflow.ellipsis, style:const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 10,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius:const BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                            child: FadeInImage.assetNetwork(
                                height: 100.h,
                                fadeInDuration: const Duration(seconds: 1),
                                fit: BoxFit.fill,
                                fadeInCurve: Curves.bounceIn,
                                image:_provider.subCategories[index].image!,
                                placeholder:'assets/images/loading.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ),
        ),
    );
  }
}
