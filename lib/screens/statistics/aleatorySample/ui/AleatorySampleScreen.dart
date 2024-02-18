
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/data/AleatorySampleConstants.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/ui/AleatorySampleEvent.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/ui/AleatorySampleState.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/ui/AleatorySampleViewModel.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/ui/AleatorySampleWidgets.dart';
import 'package:fisicapf/widgets/BasicAlertDialog.dart';
import 'package:flutter/material.dart';

class AleatorySampleScreen extends StatefulWidget {

  AleatorySampleScreen({super.key});

  final AleatorySampleState state = AleatorySampleState();

  @override
  State<AleatorySampleScreen> createState() => _AleatorySampleScreenState();
}

class _AleatorySampleScreenState extends State<AleatorySampleScreen> implements EventObserver {

  final AleatorySampleViewModel aleatorySampleViewModel = AleatorySampleViewModel();

  @override
  void initState(){
    super.initState();
    aleatorySampleViewModel.subscribe(this);
  }

  @override
  void dispose(){
    aleatorySampleViewModel.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom:  TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.format_list_numbered),
                      Text(AleatorySampleConstants.tabSequenceIntervalTitle),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.input),
                      Text(AleatorySampleConstants.tabManualDataTitle),
                    ],
                  ),
                )
              ],
            ),
            title: Center(child: Text(AleatorySampleConstants.title)),
          ),
          body:  TabBarView(
            children: [
              ByIntervalTab(
                viewModel: aleatorySampleViewModel,
                state: widget.state,
              ),
              ByManuallyInput(
                viewModel: aleatorySampleViewModel,
                state: widget.state,
              ),
            ],
          )
        ),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    if(event is SetInterval){
      setState(() {
        widget.state.intervalPopulation = List.generate(event.b-event.a, (index) => event.a+index);
      });
    }else if(event is ShowSimpleDialog){
      showDialog(context: context, builder: (context){
        return BasicAlertDialog(content: event.message);
      });
    }else if(event is AddValueManuallyToList){
      setState(() {
        widget.state.valuesManuallyList ??= [];
        widget.state.valuesManuallyList!.add(event.value);
      });
    }
  }
}
