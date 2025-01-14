import 'dart:async';
import 'package:ecommerce_app/core/app_export.dart';
import 'package:ecommerce_app/presentation/MainScreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/provider_model.dart';
import '../After Spalsh Screen/after_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ModelProvider>(context,listen: false).getProducts();
    Provider.of<ModelProvider>(context,listen: false).getPrefsData('userId');
    new Future.delayed(
        const Duration(seconds: 3),
            () async{
           var _provider =  await Provider.of<ModelProvider>(context,listen: false).getPrefsData('userId');
           if(Provider.of<ModelProvider>(context,listen: false).userId==0||
               Provider.of<ModelProvider>(context,listen: false).userId==null) {
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => AfterSplash()),
             );
           }else{
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => MainScreen()),
             );
           }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 29.v),
          child: Column(
            children: [
             const Spacer(
                flex: 34,
              ),
              Text(
                "AliCtrone",
                style: theme.textTheme.displaySmall,
              ),
              SizedBox(height: 1.v),
              Text(
                "للإجهزة الكهربائية والمنزلية",
                style: CustomTextStyles.titleLargeOnPrimaryBold,
              ),
             const Spacer(
                flex: 65,
              ),
              Text(
                "سورايزون",
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
