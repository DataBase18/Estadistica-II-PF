

import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/data/InferenceAboutSampleConstants.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleEvent.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleState.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleViewModel.dart';
import 'package:fisicapf/widgets/ComboBox/SimpleComboBox.dart';
import 'package:fisicapf/widgets/inputBasic/InputBasic.dart';
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
                const BackButton(),
                SizedBox(height: height*0.01,),
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
                InputBasic(
                  label: InferenceAboutSampleConstants.h2MLabel,
                  inputController: state.controllerInterestH2,
                  validator: (value){
                    return GlobalMetods.validatorIsDouble(value);
                  },
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
                          label: InferenceAboutSampleConstants.percentageTrustLabel,
                          inputController: state.controllerPercentageTrust,
                          validator: (value){
                            return GlobalMetods.validatorIsDouble(value);
                          },
                        ),
                    )
                  ],
                ),
                SizedBox(height: height*0.03,),
                Text(InferenceAboutSampleConstants.typeInequalityLabel),
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
                        validator: (value){
                          return GlobalMetods.validatorIsDouble(value);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: height*0.02,),
                Center(
                  child: FilledButton(
                    onPressed: (){},
                    child: Text(GlobalConstants.processTextButton),
                  ),
                ),
                SizedBox(height: height*0.05,),
                if (state.inferenceResultText.isNotEmpty) 
                  Text(
                    state.inferenceResultText
                  ) 
                else Container(),
                SizedBox(height: height*0.05,),
                _GraphGaussBellZone()
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


}



class _GraphGaussBellZone extends StatelessWidget {
  const _GraphGaussBellZone({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
