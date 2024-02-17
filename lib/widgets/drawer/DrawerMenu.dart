
import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/screens/conversions/ui/ConversionScreen.dart';
import 'package:fisicapf/screens/home/ui/HomeState.dart';
import 'package:fisicapf/screens/home/ui/HomeViewModel.dart';
import 'package:fisicapf/widgets/drawer/Constants.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key, required this.viewModel, required this.state, required this.menus});

  final HomeViewModel viewModel;
  final HomeState state;
  final List<MenuModel> menus;


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
            selected: index == state.currentIndexPage,
            selectedColor: Theme.of(context).colorScheme.primary,
            trailing: const Icon(Icons.navigate_next),
            title: Text(menus.elementAt(index).title),
            onTap: (){
              viewModel.changeCurrentPage(
                newPage: menus.elementAt(index).screenContent ?? ConversionScreen(),
                newIndexPage: index
              );
              Scaffold.of(context).closeDrawer();
            },
          );
        },
      )
    );
  }
}
