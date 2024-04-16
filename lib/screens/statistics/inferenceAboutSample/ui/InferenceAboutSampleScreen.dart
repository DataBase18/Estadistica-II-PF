

import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/data/InferenceAboutSampleConstants.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleEvent.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleState.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleViewModel.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleWidget.dart';
import 'package:fisicapf/widgets/BasicAlertDialog.dart';
import 'package:fisicapf/widgets/ComboBox/SimpleComboBox.dart';
import 'package:fisicapf/widgets/TitleText.dart';
import 'package:fisicapf/widgets/inputBasic/InputBasic.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InferenceAboutSampleScreen extends StatefulWidget {
  const InferenceAboutSampleScreen({super.key});

  @override
  State<InferenceAboutSampleScreen> createState() => _InferenceAboutSampleScreenState();
}

class _InferenceAboutSampleScreenState extends State<InferenceAboutSampleScreen> implements EventObserver {

  final InferenceAboutSampleState state = InferenceAboutSampleState();
  final InferenceAboutSampleViewModel viewModel = InferenceAboutSampleViewModel();

  @override
  void initState(){
    super.initState();
    viewModel.subscribe(this);
  }

  @override void dispose() {
    viewModel.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: height*0.01, horizontal: width*0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const BackButton(),
                    SizedBox(width: width*0.01,),
                    TitleText(text: InferenceAboutSampleConstants.title, fontSize: 22, bold: true,),
                  ],
                ),

                InputBasic(
                  label: InferenceAboutSampleConstants.interestParameterLabel ,
                  inputController: state.controllerInterestParameter,
                ),
                SizedBox(height: height*0.01,),
                InputBasic(
                  label: InferenceAboutSampleConstants.h1MLabel,
                  inputController: state.controllerInterestH1,
                  validator: (value){
                    return GlobalMetods.validatorIsDouble(value);
                  },
                ),
                SizedBox(height: height*0.01,),
                Text(InferenceAboutSampleConstants.h2MLabel),
                SizedBox(height: height*0.01,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SimpleComboBox(
                        currentValue: state.currentTypeInequality,
                        items: state.typeInequalityList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChange: (value){
                          viewModel.changeItemTypeInequality(value as String);
                        },
                      ),
                    ),
                    SizedBox(width: width*0.05,),
                    Expanded(
                      child: InputBasic(
                        inputController: state.controllerInterestH2,
                        validator: (value){
                          return GlobalMetods.validatorIsDouble(value);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: height*0.01,),
                Text(InferenceAboutSampleConstants.knowAlphaValueTextInfo),
                SizedBox(height: height*0.01,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Switch(
                      value: state.knowAlphaValue,
                      onChanged: (newValue){
                        viewModel.changeKnowAlphaSwitch(newValue);
                      },
                    ),
                    SizedBox(width: width*0.05,),
                    if (state.knowAlphaValue)
                      Expanded(
                        child: InputBasic(
                          label: InferenceAboutSampleConstants.alphaValueLabel,
                          inputController: state.controllerAlphaValue,
                          validator: (value){
                            return GlobalMetods.validatorIsDouble(value);
                          },
                        ),
                    ) else
                      Expanded(
                        child: InputBasic(
                          label: InferenceAboutSampleConstants.criticValueLabel,
                          inputController: state.controllerCriticValue,
                          validator: (value){
                            return GlobalMetods.validatorIsDouble(value);
                          },
                        ),
                    )
                  ],
                ),
                SizedBox(height: height*0.03,),
                TitleText(text: InferenceAboutSampleConstants.typeCalcLabel, fontSize: 18,),
                RadioListTile(
                  value: 1,
                  groupValue: state.currentTypeCalcSelected,
                  title: Text(InferenceAboutSampleConstants.populationExperimentLabel),
                  onChanged: (val) {
                    viewModel.changeCurrentTypeCalc(val!);
                  },
                  activeColor: Colors.red,
                  selected: state.currentTypeCalcSelected == 1,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: state.currentTypeCalcSelected,
                  title: Text(InferenceAboutSampleConstants.sampleExperimentLabel),
                  onChanged: (val) {
                    viewModel.changeCurrentTypeCalc(val!);
                  },
                  activeColor: Colors.red,
                  selected: state.currentTypeCalcSelected == 2,
                ),
                RadioListTile(
                  value: 3,
                  groupValue: state.currentTypeCalcSelected,
                  title: Text(InferenceAboutSampleConstants.proportionExperimentLabel),
                  onChanged: (val) {
                    viewModel.changeCurrentTypeCalc(val!);
                  },
                  activeColor: Colors.red,
                  selected: state.currentTypeCalcSelected == 3,
                ),
                SizedBox(height: height*0.02,),
                state.currentTypeCalcSelected == 1 ||
                state.currentTypeCalcSelected == 2 ?
                    PopulationOrSampleExperimentWidgets(viewModel: viewModel, state: state):
                    Container(),
                SizedBox(height: height*0.02,),
                InputBasic(
                  label:  InferenceAboutSampleConstants.sampleSizeLabel,
                  inputController: state.controllerSample,
                  validator: (value){
                    return GlobalMetods.validatorIsDouble(value);
                  },
                ),
                SizedBox(height: height*0.02,),
                Center(
                  child: FilledButton(
                    onPressed: (){
                      viewModel.calculate(
                        interestParameterController: state.controllerInterestParameter,
                        h1Controller: state.controllerInterestH1,
                        h2Controller: state.controllerInterestH2,
                        typeInequality: state.currentTypeInequality,
                        knowAlphaValue: state.knowAlphaValue,
                        criticValueController: state.controllerCriticValue,
                        alphaValueController: state.controllerAlphaValue,
                        typeCalc: state.currentTypeCalcSelected,
                        meanController: state.controllerMean,
                        sigmaController: state.controllerSigma,
                        sampleController: state.controllerSample,
                        deviationSController: state.controllerS
                      );
                    },
                    child: Text(GlobalConstants.processTextButton),
                  ),
                ),
                SizedBox(height: height*0.05,),
                if (state.inferenceResultText.isNotEmpty) 
                  InferenceWidgets(state: state)
                else Container(),
                SizedBox(height: height*0.02,),
                if(state.pointsGauss.isNotEmpty)
                _GraphGaussBellZone(
                  state: state,
                  viewModel: viewModel,
                )else Container(),
                SizedBox(height: height*0.05,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    switch(event.runtimeType){
      case ChangeKnowAlphaEvent:
        _handleChangeKnowAlphaValue(event as ChangeKnowAlphaEvent);
        break;
      case ChangeCurrentTypeInequalityH2:
        _handleChangeCurrentTypeInequalityH2(event as ChangeCurrentTypeInequalityH2);
        break;
      case ChangeCurrentTypeCalc:
        _handleChangeCurrentTypeCalc(event as ChangeCurrentTypeCalc);
        break;
      case ShowSimpleAlert:
        _handleShowSimpleAlert(event as ShowSimpleAlert);
        break;
      case SetLeftCriticValue:
        _handleSetLeftCriticValue(event as SetLeftCriticValue);
        break;
      case SetRightCriticValue:
        _handleSetRightCriticValue(event as SetRightCriticValue);
        break;
      case SetZValue:
        _handleSetZValue(event as SetZValue);
        break;
      case SetInferenceText:
        _handleSetInferenceText(event as SetInferenceText);
        break;
      case SetGaussBellPoints:
        _handleSetGaussBellPoints(event as SetGaussBellPoints);
        break;
      case SetFunctionLeftInterval:
        _handleSetFunctionLeftInterval(event as SetFunctionLeftInterval);
        break;
      case SetFunctionRightInterval:
        _handleSetFunctionRightInterval(event as SetFunctionRightInterval);
        break;
      case SetRectPointsToZResult:
        _handleSetRectPointsToZResult(event as SetRectPointsToZResult);
        break;
    }
  }

  void _handleChangeKnowAlphaValue(ChangeKnowAlphaEvent event) {
    setState(() {
      state.knowAlphaValue = event.newValue;
    });
  }

  void _handleChangeCurrentTypeInequalityH2(ChangeCurrentTypeInequalityH2 event) {
    setState(() {
      state.currentTypeInequality=event.newValue;
    });
  }

  void _handleChangeCurrentTypeCalc(ChangeCurrentTypeCalc event) {
    setState(() {
      state.currentTypeCalcSelected = event.newType;
    });
  }

  void _handleShowSimpleAlert(ShowSimpleAlert event) {
    showDialog(context: context, builder: (context){
      return BasicAlertDialog(content: event.message);
    });
  }

  void _handleSetLeftCriticValue(SetLeftCriticValue event) {
    setState(() {
      state.leftCriticalValue = event.leftValue;
    });
  }

  void _handleSetRightCriticValue(SetRightCriticValue event) {
    setState(() {
      state.rightCriticalValue = event.rightValue;
    });
  }

  void _handleSetZValue(SetZValue event) {
    setState(() {
      state.zValue=event.zValue;
    });
  }

  void _handleSetInferenceText(SetInferenceText event) {
    setState(() {
      state.inferenceResultText =event.result;
    });
  }

  void _handleSetGaussBellPoints(SetGaussBellPoints event) {
    setState(() {
      state.pointsGauss = event.points;
    });
  }

  void _handleSetFunctionLeftInterval(SetFunctionLeftInterval event) {
    setState(() {
      state.pointsLeftIntervalFunction=event.points;
    });
  }

  void _handleSetFunctionRightInterval(SetFunctionRightInterval event) {
    setState(() {
      state.pointsRightIntervalFunction=event.points;
    });
  }

  void _handleSetRectPointsToZResult(SetRectPointsToZResult event) {
    setState(() {
      state.pointsToRectZResult= event.points;
    });
  }


}



class _GraphGaussBellZone extends StatelessWidget {
  const _GraphGaussBellZone({super.key, required this.state, required this.viewModel});
  final InferenceAboutSampleViewModel viewModel ;
  final InferenceAboutSampleState state  ;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height*0.25,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false
                )
            ),
            rightTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false
                )
            ),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false
                )
            ),
            bottomTitles:AxisTitles(
              drawBelowEverything: false,
                sideTitles: SideTitles(
                  showTitles: true,
                )
            ),
          ),
          lineBarsData: [
            state.pointsToRectZResult.isNotEmpty?
            LineChartBarData(
                spots: state.pointsToRectZResult,
                isCurved: false,
                barWidth: 1.4,
                dotData:const  FlDotData(show: false),
                belowBarData: BarAreaData( show: false, ),
                color: Theme.of(context).colorScheme.primary
            ):LineChartBarData(),

            LineChartBarData(
              spots: state.pointsGauss,
              isCurved: true,
              barWidth: 1.2,
              dotData:const  FlDotData(show: false),
              belowBarData: BarAreaData( show: false, ),
            ),

            state.pointsLeftIntervalFunction.isNotEmpty?
            LineChartBarData(
              spots: state.pointsLeftIntervalFunction,
              isCurved: true,
              barWidth: 1,
              dotData:const  FlDotData(show: false),
              belowBarData: BarAreaData( show: true, ),
            ):LineChartBarData(),

            state.pointsRightIntervalFunction.isNotEmpty?
            LineChartBarData(
              spots: state.pointsRightIntervalFunction,
              isCurved: true,
              barWidth: 1,
              dotData:const  FlDotData(show: false),
              belowBarData: BarAreaData( show: true, ),
            ):LineChartBarData(),


          ],
        ),
      ),
    );
  }
}

