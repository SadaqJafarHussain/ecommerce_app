import 'package:ecommerce_app/Provider/provider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CategoryModel{
   int? id;
   String? name;
   String? image;
  CategoryModel({
     this.name,
     this.id,
     this.image
});

  factory CategoryModel.fromJson(Map<String,dynamic> json,bool noImage)=>CategoryModel(
      name: json['name'].toString(),
      id: json['id'],
      image:json['url_image'].toString(),
  );
}