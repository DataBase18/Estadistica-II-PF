


import 'package:awesome_icons/awesome_icons.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/data/IntervalEstimationConstants.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/domain/IntervalEstimationRepository.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/ui/IntervalEstimationEvent.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/ui/IntervalEstimationState.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/ui/IntervalEstimationViewModel.dart';
import 'package:fisicapf/widgets/BasicAlertDialog.dart';
import 'package:fisicapf/widgets/TitleText.dart';
import 'package:fisicapf/widgets/inputBasic/InputBasic.dart';
import 'package:flutter/material.dart';

class IntervalEstimationScreen extends StatefulWidget {
  const IntervalEstimationScreen({super.key});

  @override
  State<IntervalEstimationScreen> createState() => _IntervalEstimationScreenState();
}

class _IntervalEstimationScreenState extends State<IntervalEstimationScreen> implements EventObserver{

  final IntervalEstimationViewModel viewModel = IntervalEstimationViewModel(
    IntervalEstimationRepository()
  );
  final IntervalEstimationState state = IntervalEstimationState();

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              Center(child:  TitleText(text: IntervalEstimationConstants.title,fontSize: 25,),),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.02),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(IntervalEstimationConstants.typeCalcSample),
                        SizedBox(width: width*0.03,),
                        Switch(
                          value: state.typeCalcSample,
                          onChanged: (value){
                            notify(ChangeTypeCalcSample(value));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.01,),
                    Row(
                      children: [
                        SizedBox(
                          width: width*0.1,
                          child: Text(
                                IntervalEstimationConstants.populationLabel
                          )
                        ),
                        SizedBox(width: width*0.02,),
                        Expanded(
                          child: InputBasic(
                            label: IntervalEstimationConstants.sizePopulationInputLabel,
                            rigthIcon: const Icon(Icons.people_alt),
                            inputController: state.populationController,
                            validator: (value){
                              if(double.tryParse(value??"") ==null){
                                return IntervalEstimationConstants.invalidValueMessage;
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height*0.01,),
                    Row(
                      children: [
                        SizedBox(
                            width: width*0.1,
                            child: Text(
                                IntervalEstimationConstants.sampleLabel
                            )
                        ),
                        SizedBox(width: width*0.02,),
                        Expanded(
                          child: InputBasic(
                            label: IntervalEstimationConstants.sizeSampleInputLabel,
                            rigthIcon: const Icon(Icons.people_alt),
                            inputController: state.sampleController,
                            validator: (value){
                              if(double.tryParse(value??"") ==null){
                                return IntervalEstimationConstants.invalidValueMessage;
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    Row(
                      children: [
                        SizedBox(
                            width: width*0.1,
                            child: Text(
                                IntervalEstimationConstants.meanLabel
                            )
                        ),
                        SizedBox(width: width*0.02,),
                        Expanded(
                          child: InputBasic(
                            label: state.typeCalcSample ?
                            IntervalEstimationConstants.meanSampleInputLabel:
                            IntervalEstimationConstants.meanPopulationInputLabel,
                            inputController: state.meanController,
                            rigthIcon: const Icon(Icons.close),
                            validator: (value){
                              if(double.tryParse(value??"") ==null){
                                return IntervalEstimationConstants.invalidValueMessage;
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    Row(
                      children: [
                        SizedBox(
                            width: width*0.1,
                            child: Text(
                              state.typeCalcSample?
                                IntervalEstimationConstants.standardDeviationLabel:
                                  IntervalEstimationConstants.sigmaLabel,
                            )
                        ),
                        SizedBox(width: width*0.02,),
                        Expanded(
                          child: InputBasic(
                            label: state.typeCalcSample ?
                            IntervalEstimationConstants.standardDeviationInputLabel:
                            IntervalEstimationConstants.sigmaInputLabel,
                            inputController: state.deviationSigmaController,
                            rigthIcon: const Icon(Icons.device_hub),
                            validator: (value){
                              if(double.tryParse(value??"") ==null){
                                return IntervalEstimationConstants.invalidValueMessage;
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    Row(
                      children: [
                        SizedBox(
                            width: width*0.1,
                            child: Text(IntervalEstimationConstants.iCLabel )
                        ),
                        SizedBox(width: width*0.02,),
                        Expanded(
                          child: InputBasic(
                            label:   IntervalEstimationConstants.iCInputLabel,
                            rigthIcon: const Icon(Icons.percent),
                            inputController: state.iCController,
                            validator: (value){
                              if(double.tryParse(value??"") ==null){
                                return IntervalEstimationConstants.invalidValueMessage;
                              }
                              return null;
                            },
                            maxLength: 5,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height*0.04,),
                    FilledButton(
                      onPressed: (){
                        viewModel.calculate(
                          isSampleCalcType: state.typeCalcSample,
                          nController: state.sampleController,
                          populationController: state.populationController,
                          icController: state.iCController,
                          sOrSigmaController: state.deviationSigmaController,
                          xController: state.meanController,
                        );
                      },
                      child: Text(IntervalEstimationConstants.calcTextButton),
                    ),
                    SizedBox(height: height*0.035,),
                    state.currentResponse.isNotEmpty?
                    SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            IntervalEstimationConstants.resultTitle,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.green
                            ),
                          ),
                          SizedBox(height: height*0.02,),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              state.currentResponse,
                              style: const TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(height: height*0.02,),
                          state.currentResponseInfo.isNotEmpty?
                          Text(
                            IntervalEstimationConstants.explicationInfo,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.green
                            ),
                          ):Container(),
                          SizedBox(height: height*0.02,),
                          state.currentResponseInfo.isNotEmpty?
                          Text(
                            state.currentResponseInfo,
                            style: const TextStyle(
                                fontSize: 18
                            ),
                          ):Container(),
                        ],
                      ),
                    ):Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    switch (event.runtimeType){
      case ChangeTypeCalcSample:
        _handleChangeTypeCalcSample(event as ChangeTypeCalcSample);
        break;
      case ShowSimpleAlert:
        _handleShowSimpleAlert(event as ShowSimpleAlert);
        break;
      case SetResponseResult:
        _handleSetResponseResult(event as SetResponseResult);
        break;
    }
  }

  void _handleChangeTypeCalcSample(ChangeTypeCalcSample event) {
    setState(() {
      state.typeCalcSample=event.newStatus;
    });
  }

  void _handleShowSimpleAlert(ShowSimpleAlert event) {
    showDialog(context: context, builder: (context)=> BasicAlertDialog(content: event.message));
  }

  void _handleSetResponseResult(SetResponseResult event) {
    setState(() {
      state.currentResponse=event.result;
      state.currentResponseInfo=event.infoResult;
    });
  }
}
