
import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/data/AleatorySampleConstants.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/ui/AleatorySampleState.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/ui/AleatorySampleViewModel.dart';
import 'package:fisicapf/widgets/inputBasic/InputBasic.dart';
import 'package:flutter/material.dart';

class ByIntervalTab extends StatelessWidget {

  ByIntervalTab({super.key, required this.viewModel, required this.state});

  final AleatorySampleViewModel viewModel;
  final AleatorySampleState state;

  TextEditingController controllerFrom = TextEditingController();
  TextEditingController controllerTo = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*0.02, horizontal: width*0.03),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InputBasic(
                  validator: GlobalMetods.validatorIsNumber,
                  label: AleatorySampleConstants.fromLabel,
                  inputController: controllerFrom,
                ),
              ),
              SizedBox(width: width*0.01 ,),
              Expanded(
                child: InputBasic(
                  validator: GlobalMetods.validatorIsNumber,
                  label: AleatorySampleConstants.toLabel,
                  inputController: controllerTo,
                )
              ),
            ],
          ),
          SizedBox(height: height*0.02 ,),
          state.loading?
              const CircularProgressIndicator():
          FilledButton(
            onPressed: (){
              viewModel.setInterval(controllerFrom, controllerTo);
            },
            child: Text(GlobalConstants.processTextButton),
          ),
          SizedBox(height: height*0.02 ,),

          state.intervalPopulation == null ? Container():
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text(AleatorySampleConstants.sequenceColumnName)),
                  DataColumn(label: Text(AleatorySampleConstants.selectThisRowColumnName))
                ],
                rows: state.intervalPopulation!.map((value) {
                  return DataRow(
                    cells: [
                      DataCell(Text(value.toString())),
                      DataCell(Text(viewModel.getAleatorySelection()))
                    ]
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
