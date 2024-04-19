

import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fisicapf/screens/statistics/sizeSampleCalc/data/SizeSampleConstants.dart';
import 'package:fisicapf/screens/statistics/sizeSampleCalc/ui/SizeSampleCalcState.dart';
import 'package:fisicapf/screens/statistics/sizeSampleCalc/ui/SizeSampleCalcViewModel.dart';
import 'package:fisicapf/widgets/ComboBox/SimpleComboBox.dart';
import 'package:fisicapf/widgets/TitleText.dart';
import 'package:fisicapf/widgets/inputBasic/InputBasic.dart';
import 'package:flutter/material.dart';

import 'SizeSampleCalcEvent.dart';

class SizeSampleCalcScreen extends StatefulWidget {
  SizeSampleCalcScreen({super.key});

  final SizeSampleCalcState state = SizeSampleCalcState();


  @override
  State<SizeSampleCalcScreen> createState() => _SizeSampleCalcScreenState();
}

class _SizeSampleCalcScreenState extends State<SizeSampleCalcScreen> implements EventObserver{

  final SizeSampleCalcViewModel viewModel  = SizeSampleCalcViewModel();

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

  TextEditingController controllerZ = TextEditingController();
  TextEditingController controllerP = TextEditingController();
  TextEditingController controllerQ = TextEditingController();
  TextEditingController controllerN = TextEditingController();
  TextEditingController controllerE = TextEditingController();
  List zs = List.generate(10, (index) => index+90);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.01),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                Center(child: TitleText(text: SizeSampleConstants.title, fontSize: 25)),
                SizedBox(height: height*0.01,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InputBasic(
                        label: SizeSampleConstants.pLabel,
                        inputController: controllerP,
                        maxLength: 2,
                        validator: GlobalMetods.validatorIsDouble,
                        onChange: (value){
                           if(int.tryParse(value) != null){
                             int qValue = 100 - int.parse(value);
                             controllerQ.text = "$qValue %";
                           }
                        },
                      ),
                    ),
                    SizedBox(width: width*0.02,),
                    Expanded(
                      child: InputBasic(
                        readOnly: true,
                        inputController: controllerQ,
                        placeholderHelp: SizeSampleConstants.qLabel,
                        label: SizeSampleConstants.qLabel,
                      ),
                    )
                  ],
                ),
                SizedBox(height: height*0.01,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InputBasic(
                        label: SizeSampleConstants.eLabel,
                        inputController: controllerE,
                        maxLength: 2,
                        validator: GlobalMetods.validatorIsDouble,
                      ),
                    ),
                    SizedBox(width: width*0.02,),
                    Expanded(
                      child: InputBasic(
                        inputController: controllerN,
                        label: SizeSampleConstants.nnLabel,
                        validator: GlobalMetods.validatorIsNumber,
            
                      ),
                    )
                  ],
                ),
                SizedBox(height: height*0.01,),
                Text(SizeSampleConstants.zLabel),
                SimpleComboBox(
                  onChange: (value){
                    viewModel.changeCurrentZ(int.parse("$value"));
                  },
                  items: zs.map((item)  {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.toString()),
                    );
                  }).toList(),
                  currentValue: widget.state.zTrustCurrentValue,
                ),
                SizedBox(height: height*0.01,),
                widget.state.currentSampleCalc != null?
                    Text("${SizeSampleConstants.resultText} ${widget.state.currentSampleCalc}") : Container(),
                SizedBox(height: height*0.01,),
                FilledButton(
                  onPressed: (){
                    viewModel.calcSample(
                      N: int.tryParse(controllerN.text),
                      zTempValue: widget.state.zTrustCurrentValue,
                      PTemp: int.tryParse(controllerP.text),
                      QTemp: int.tryParse(controllerQ.text),
                      ETemp: int.tryParse(controllerE.text)
                    );
                  },
                  child: Text(GlobalConstants.processTextButton),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    if(event is SetCurrentZIndex){
      setState(() {
        widget.state.zTrustCurrentValue = event.newIndex;
      });
    }else if(event is SetSample){
      setState(() {
        widget.state.currentSampleCalc = event.sample;
      });
    }
  }
}
