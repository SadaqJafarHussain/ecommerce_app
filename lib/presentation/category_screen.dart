
import 'package:ecommerce_app/core/app_export.dart';
import 'package:ecommerce_app/presentation/sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_model.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({ super.key});

  @override
  Widget build(BuildContext context) {
    final _provider=Provider.of<ModelProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const SizedBox(height: 10,),
          _provider.categories.length==0?
          Center(child: Column(
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
          ))
              :Expanded(
            child: GridView.builder(
                physics:const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.2,
                  crossAxisCount: 3, // number of items in each row
                  mainAxisSpacing: 4.0, // spacing between rows
                  crossAxisSpacing: 1.0,
                  // spacing between columns
                ),
                itemCount: _provider.categories.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()async{
                      await _provider.getSubCategories(_provider.categories[index].id!);
                      var data=await _provider.getPrefsData('userId');
                      print(data);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SubCategoryScreen(categoryModel: _provider.categories[index],)));
                    },
                    child: Column(
                      children: [
                        Text(_provider.categories[index].name!,overflow: TextOverflow.ellipsis, style:const TextStyle(
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
                                  image: _provider.categories[index].image!,
                                  placeholder:'assets/images/loading.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

}
