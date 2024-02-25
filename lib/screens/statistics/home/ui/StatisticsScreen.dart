
import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/statistics/home/data/StatisticsConstants.dart';
import 'package:fisicapf/screens/statistics/home/ui/StatisticsState.dart';
import 'package:fisicapf/screens/statistics/home/ui/StatisticsViewModel.dart';
import 'package:fisicapf/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({super.key});

  StatisticsState state = StatisticsState();

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>  implements EventObserver{

  final StatisticsViewModel viewModel = StatisticsViewModel();

  @override
  void initState(){
    super.initState();
    viewModel.subscribe(this);
  }

  @override
  void dispose (){
    viewModel.unsubscribe(this);
    super.dispose();
  }

  List<MenuModel> menus = [
    MenuModel(
      title: StatisticsConstants.aleatorySampleTitle,
      description: StatisticsConstants.aleatorySampleDescription,
      screenPath: GlobalConstants.aleatorySampleScreen
    ),
    MenuModel(
        title: StatisticsConstants.sizeSampleCalcTitle,
        description: StatisticsConstants.sizeSampleCalcDescription,
        screenPath: GlobalConstants.sizeSampleCalcScreen
    ),
  ];

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height  = MediaQuery.of(context).size.height;

    return Column(
      children: [
        TitleText(text: StatisticsConstants.title),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: width*0.02),
            itemCount: menus.length,
            itemBuilder: (context, index){
              return MenuItemCard(
                item: menus.elementAt(index),
                onTab: () => Navigator.pushNamed(context, menus.elementAt(index).screenPath ?? GlobalConstants.homeScreenPath),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  void notify(ViewEvent event) {
    // TODO: implement notify
  }
}