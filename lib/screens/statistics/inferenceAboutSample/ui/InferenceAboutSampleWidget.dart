

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
