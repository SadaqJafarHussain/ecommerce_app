import 'package:ecommerce_app/Provider/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildNavItem(icon: Icons.home, index: 0, activeColor:const Color(0xff514EB7)),
          buildNavItem(icon: Icons.category_outlined, index: 1, activeColor:const Color(0xff514EB7)),
          buildNavItem(icon: Icons.delivery_dining_outlined, index: 2,activeColor: const Color(0xff514EB7)),
          buildNavItem(icon: Icons.favorite, index: 3, activeColor:const Color(0xff514EB7)),

        ],
      ),
    );
  }

  Widget buildNavItem({required IconData icon, required int index, Color activeColor = Colors.black}) {
    var _provider=Provider.of<ModelProvider>(context);
    bool isSelected = _provider.screenIndex == index;
    return GestureDetector(
      onTap: () => _provider.updateScreen(index),
      child: AnimatedContainer(
        duration:const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset:const Offset(0, 3),
            ),
          ]
              : [],
        ),
        child: Icon(
          icon,
          color: isSelected ? activeColor : Colors.grey,
          size: isSelected ? 30 : 24, // Increase size for selected item
        ),
      ),
    );
  }
}