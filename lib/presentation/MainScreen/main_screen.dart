import 'dart:async';

import 'package:ecommerce_app/Models/cart_model.dart';
import 'package:ecommerce_app/core/app_export.dart';
import 'package:ecommerce_app/presentation/CartScreen/cart_screen.dart';
import 'package:ecommerce_app/presentation/MainScreen/drawer_screen.dart';
import 'package:ecommerce_app/presentation/MainScreen/products_screen.dart';
import 'package:ecommerce_app/presentation/MainScreen/wishlist_screen.dart';
import 'package:ecommerce_app/presentation/Sign%20up/sign_up.dart';
import 'package:ecommerce_app/presentation/category_screen.dart';
import 'package:ecommerce_app/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../Provider/provider_model.dart';
import '../../widgets/search_bar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  Future<List<CartModel>>? _cartItemsFuture;
  String title='الصفحه الرئيسية';
  @override
  void initState() {
    Provider.of<ModelProvider>(context,listen: false).getUserInfo();
    Provider.of<ModelProvider>(context,listen: false).getCategory();
    _cartItemsFuture= Provider.of<ModelProvider>(context,listen: false).getCartItems();

    super.initState();
  }
  List<String> titles=[
    'الصفحه الرئيسية',
    'التصنيفات',
    'الطلبات المكتمله',
    'سلة الأمنيات',
  ];

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ModelProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          drawer:_provider.userId==0?null: DrawerScreen(userModel:_provider.userModel),
          backgroundColor: const Color(0xffFFFFFF),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(titles[_provider.screenIndex],
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Cairo',
                fontSize: 20.h,
              ),),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: CustomSearchBar(products: _provider.products));
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 40.v,
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if(_provider.userId==0||_provider.userId==null){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        }else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const CartScreen()));
                        }
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                        size: 35.v,
                      )),
                  Positioned(
                    top: 2.0,
                    left: 4.0,
                    child: FutureBuilder<List<CartModel>> (
                      future: _provider.getCartItems(),
                      builder: (ctx,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(
                            child:  Container(),
                          );
                        }
                        else if(snapshot.data!.isNotEmpty){
                       List<CartModel> models=snapshot.data!;
                       return notTag(models);
                        }
                       else{
                         return Container();
                       }
                      },
                    )
                  )
                ],
              ),
            ],
          ),
          body: screens[_provider.screenIndex],
          bottomNavigationBar:CustomBottomNavigationBar()
          /* SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i){
              setState(()=>_currentIndex=i);
              if(_currentIndex==3&&_provider.userId==0){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
              }
            },
            items: [
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                title: Text("الرئيسية",style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.layerGroup),
                title: Text("التصنيفات",style: TextStyle(
                    fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.truckFast),
                title: Text("الطلبيات",style: TextStyle(
                    fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
              SalomonBottomBarItem(
                icon: FaIcon(FontAwesomeIcons.heart),
                title: Text("قائمة الامنيات",style: TextStyle(
                    fontFamily: 'Cairo',
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.bold,
                ),),
                selectedColor:Color(0xff514EB7),
              ),
            ],
          ),*/
        ),
      ),

    );
  }

 Widget notTag(List<CartModel> models){
    return   CircleAvatar(
      backgroundColor: Color(0xff514EB7),
      radius: 12.v,
      child: FittedBox(
        child: Text(
          '${models.first.count}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  List<dynamic> screens=[
    ProductsScreen(slider: true,moreText: true,),
    CategoryScreen(),
    Container(),
    WishListScreen(),
  ];

}
