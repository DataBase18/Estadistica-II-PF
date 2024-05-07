
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/history/data/HistoryConstants.dart';
import 'package:fisicapf/screens/history/domain/HistoryRepository.dart';
import 'package:fisicapf/screens/history/ui/HistoryEvent.dart';
import 'package:fisicapf/screens/history/ui/HistoryState.dart';
import 'package:fisicapf/screens/history/ui/HistoryViewModel.dart';
import 'package:fisicapf/widgets/AlertBasic.dart';
import 'package:fisicapf/widgets/NoDataList.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}
class _HistoryScreenState extends State<HistoryScreen> implements EventObserver{

  final state = HistoryState();
  final viewModel = HistoryViewModel(
      HistoryRepository()
  );

  @override
  void initState(){
    super.initState();
    viewModel.subscribe(this);
    viewModel.getInitialData();
  }

  @override
  void dispose(){
    viewModel.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.01),
        child: state.loadingScreen ? const Center(child: CircularProgressIndicator(),) :
        state.history.isNotEmpty?
            Column(
              children: [
                Text(HistoryConstants.title)
              ],
            ):NoDataList(text: HistoryConstants.noDataText,)
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    switch(event.runtimeType){
      case ShowSimpleAlert:
        _showSimpleAlert(event as ShowSimpleAlert);
        break;
      case SetHistory:
        _setHistory(event as SetHistory);
        break;
      case SetLoadingScreen:
        _setLoadingScreen(event as SetLoadingScreen);
        break;
    }
  }

  void _showSimpleAlert(ShowSimpleAlert event) {
    showDialog(context: context, builder: (context){
      return AlertBasic(content: event.message);
    });
  }

  void _setHistory(SetHistory event) {
    setState(() {
      state.history=event.history;
    });
  }

  void _setLoadingScreen(SetLoadingScreen event) {
    setState(() {
      state.loadingScreen=event.newState;
    });
  }
}
