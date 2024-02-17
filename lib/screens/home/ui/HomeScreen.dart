

import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/conversions/data/ConversionConstants.dart';
import 'package:fisicapf/screens/conversions/ui/ConversionScreen.dart';
import 'package:fisicapf/screens/home/data/HomeConstants.dart';
import 'package:fisicapf/screens/home/ui/HomeEvent.dart';
import 'package:fisicapf/screens/home/ui/HomeState.dart';
import 'package:fisicapf/screens/home/ui/HomeViewModel.dart';
import 'package:fisicapf/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  final HomeState state = HomeState(
    currentPage:  ConversionScreen(),
    currentIndexPage: 0
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements EventObserver {

  final HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState(){
    super.initState();
    homeViewModel.subscribe(this);
  }

  @override
  void dispose(){
    homeViewModel.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: DrawerMenu(
          state: widget.state,
          viewModel:homeViewModel ,
          menus: HomeConstants.drawerMenus,
        ),
        body: widget.state.currentPage
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    if(event is SetCurrentMenu){
      setState(() {
        widget.state.currentPage=event.currentPage;
        widget.state.currentIndexPage=event.currentIndex;
      });
    }
  }

}
