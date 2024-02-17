
import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/widgets/drawer/Constants.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key});

  List<MenuModel> menus = [
    MenuModel(
      title: DrawerMenuConstants.physicsMenuItem,
      icon: Icons.accessibility_new_outlined,
      screenPath: GlobalConstants.homeScreenPath,
      description: ""
    ),
    MenuModel(
        title: DrawerMenuConstants.statisticsMenuItem,
        icon: Icons.add_chart_rounded,
        description: ""
    ),

    MenuModel(
        title: DrawerMenuConstants.statisticsMenuItem,
        icon: Icons.add_chart_rounded,
        description: ""
    ),
    MenuModel(
        title: DrawerMenuConstants.statisticsMenuItem,
        icon: Icons.add_chart_rounded,
        description: ""
    )
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: height*0.05, horizontal: width*0.03),
        separatorBuilder: (context, index) => const Divider(height: 2,),
        itemCount: menus.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: Icon(menus.elementAt(index).icon),
            trailing: const Icon(Icons.navigate_next),
            title: Text(menus.elementAt(index).title),
            onTap: (){
              Navigator.pushReplacementNamed(context, menus.elementAt(index).screenPath ?? GlobalConstants.homeScreenPath);
            },
          );
        },
      )
    );
  }
}
