

import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/data/InferenceAboutSampleConstants.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleState.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleViewModel.dart';
import 'package:fisicapf/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PopulationOrSampleExperimentWidgets extends StatelessWidget {
  const PopulationOrSampleExperimentWidgets({super.key, required this.viewModel, required this.state});
  final InferenceAboutSampleViewModel viewModel;
  final InferenceAboutSampleState state;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        InputBasic(
          label: InferenceAboutSampleConstants.meanValueLabel,
          inputController: state.controllerMean,
          validator: (value){
            return GlobalMetods.validatorIsDouble(value);
          },
        ),
        SizedBox(height: height*0.02,),
        state.currentTypeCalcSelected == 1?
        InputBasic(
          label: InferenceAboutSampleConstants.sigmaValueLabel,
          inputController: state.controllerSigma,
          validator: (value){
            return GlobalMetods.validatorIsDouble(value);
          },
        ):
        InputBasic(
          label: InferenceAboutSampleConstants.standardDValueLabel,
          inputController: state.controllerS,
          validator: (value){
            return GlobalMetods.validatorIsDouble(value);
          },
        ),
      ],
    );
  }
}

class InferenceWidgets extends StatelessWidget {
  const InferenceWidgets({super.key, required this.state});
  final InferenceAboutSampleState state;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: InferenceAboutSampleConstants.inferenceText, fontSize: 16, bold: true, ),
          SizedBox(height: height*0.01,),
          Text(state.inferenceResultText),
          SizedBox(height: height*0.01,),
          if(state.leftCriticalValue!=null)
            Wrap(
              children: [
                Text(InferenceAboutSampleConstants.leftCriticalValueText, style: const TextStyle(fontWeight: FontWeight.bold),),
                Text(state.leftCriticalValue!.toStringAsFixed(4).toString())
              ],
            )else Container(),
          if(state.rightCriticalValue!=null)
            Wrap(
              children: [
                Text(InferenceAboutSampleConstants.rightCriticalValueText, style: const TextStyle(fontWeight: FontWeight.bold),),
                Text(state.rightCriticalValue!.toStringAsFixed(4).toString()),
              ],
            ) else Container(),
          Wrap(
            children: [
              Text(InferenceAboutSampleConstants.zValueText, style: const TextStyle(fontWeight: FontWeight.bold),),
              Text(state.zValue?.toStringAsFixed(4).toString()??""),
            ],
          ),
        ],
      ),
    );
  }
}
