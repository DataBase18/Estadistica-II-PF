
import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/statistics/MMC/data/MMCConstants.dart';
import 'package:fisicapf/screens/statistics/MMC/domain/MMCRepository.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCEvent.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCState.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCViewModel.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCWidgets.dart';
import 'package:fisicapf/widgets/AlertBasic.dart';
import 'package:fisicapf/widgets/TitleText.dart';
import 'package:fisicapf/widgets/inputBasic/InputBasic.dart';
import 'package:flutter/material.dart';

class MMCScreen extends StatefulWidget {
  const MMCScreen({super.key});

  @override
  State<MMCScreen> createState() => _MMCScreenState();
}

class _MMCScreenState extends State<MMCScreen> implements EventObserver {

  MMCState state = MMCState();
  MMCViewModel viewModel = MMCViewModel(MMCRepository());

  @override
  void initState(){
    super.initState();
    viewModel.subscribe(this);
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

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButton(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.02),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info),
                          SizedBox(width: width*0.02,),
                          Expanded(child: TitleText(text: MMCConstants.instructions, fontSize: 20, maxLines: 4,)),
                        ],
                      ),
                      SizedBox(height: height*0.01,),
                      Row(
                        children: [
                          Checkbox(
                            value: state.firstRowTitles,
                            onChanged: (newValue){
                              viewModel.changeFirstRowTitlesValue(newValue??true);
                            }
                          ),
                          Text(MMCConstants.firstRowTitlesCheckLabel)
                        ],
                      ),
                      SizedBox(height: height*0.01,),
                      InputBasic(
                        label: MMCConstants.projectedValueLabel,
                        inputController: state.projectedValueController,
                        validator: (value){
                          return GlobalMetods.validatorIsDouble(value);
                        },
                      ),
                      SizedBox(height: height*0.01,),
                      FilledButton(
                        onPressed: (){
                          viewModel.selectedFileAndProcessMMC(
                            state.firstRowTitles,
                            state.projectedValueController
                          );
                        },
                        child: Text(MMCConstants.selectFileAndProcessTextButton),
                      ),
                      SizedBox(height: height*0.01,),
                      if (state.table.isNotEmpty) Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TableResult(
                                state: state,
                                viewModel: viewModel,
                              ),
                              SizedBox(height: height*0.01,),
                              ResultData(state: state, viewModel: viewModel),
                              SizedBox(height: height*0.04,),
                              ScatterPlot(state: state)
                            ],
                          ) else Container(),
                      SizedBox(height: height*0.02,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    switch(event.runtimeType){
      case ShowSimpleAlert:
        _handleShowSimpleAlert(event as ShowSimpleAlert);
      case ChangeFirstRowTitlesCheckBox:
        _handleChangeFirstRowTitlesCheckBox(event as ChangeFirstRowTitlesCheckBox);
      case SetDataResults:
        _handleSetDataResults(event as SetDataResults);

    }
  }

  void _handleShowSimpleAlert(ShowSimpleAlert event) {
    showDialog(context: context, builder: (context){
      return AlertBasic(content: event.message);
    });
  }

  void _handleChangeFirstRowTitlesCheckBox(ChangeFirstRowTitlesCheckBox event) {
    setState(() {
      state.firstRowTitles=!state.firstRowTitles;
    });
  }

  void _handleSetDataResults(SetDataResults event) {
    setState(() {
      state.table=event.data;
      state.b=event.b;
      state.a=event.a;
      state.c=event.c;
      state.y=event.y;
      state.equation=event.yEquation;
      state.points=event.points;
      state.pointsToLine=event.pointsToDrawRect;
    });
  }


}
