

import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/screens/home/data/ConversionConstants.dart';
import 'package:fisicapf/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<MenuModel> menus = [
    MenuModel(
      title: ConversionConstants.conversionMenuTitle,
      description: ConversionConstants.conversionMenuDescription,
      imageLottiePath: ConversionConstants.conversionMenuLottiePath
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: DrawerMenu(),
        body: Column(
          children: [
            Center(child: TitleText(text: ConversionConstants.homeTitle, fontSize: 25,)),
            SizedBox(height: height*0.01,),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width*0.035),
                itemCount: menus.length,
                itemBuilder: (context, index){
                  return MenuItemCard(
                    item: menus.elementAt(index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}
