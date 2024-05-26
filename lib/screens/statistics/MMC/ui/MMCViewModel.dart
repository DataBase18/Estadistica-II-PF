
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/models/ErrorModel.dart';
import 'package:fisicapf/models/HistoryModel.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/MMC/data/MMCConstants.dart';
import 'package:fisicapf/screens/statistics/MMC/domain/MMCRepository.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCEvent.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class MMCViewModel extends EventViewModel {
  MMCRepository repository;
  MMCViewModel(this.repository);

  void processMMC(bool firstRowIsTitles, TextEditingController projectedValueController, Excel? excel) async {
    if(double.tryParse(projectedValueController.text)==null){
      notify(ShowSimpleAlert(MMCConstants.invalidProjectValueMessage));
      return;
    }
    if(excel!=null){
      try{
        final firstTable = excel.tables.values.first;

        //utils variables
        double xSum=0;
        double ySum=0;
        double xySum=0;
        double x2Sum=0;
        double y2Sum=0;
        List<List<dynamic>> tableResultData=[];
        int initialIndexRow = 0;
        double xMax = 0;
        double xMin = 0;

        if(firstRowIsTitles){
          initialIndexRow=1;
          tableResultData.add([]);
          tableResultData[0].add(firstTable.rows.elementAt(0).elementAt(0)?.value??"");
          tableResultData[0].add(firstTable.rows.elementAt(0).elementAt(1)?.value??"");
          tableResultData[0].add("XY");
          tableResultData[0].add("X^2");
          tableResultData[0].add("Y^2");
        }

        //points to graph
        List<LineChartBarData> points = [];

        for (var index=initialIndexRow; index<firstTable.rows.length;index++) {
          Data? xValue = firstTable.rows.elementAt(index).elementAt(0);
          Data? yValue = firstTable.rows.elementAt(index).elementAt(1);
          if(xValue==null){
            notify(ShowSimpleAlert("${MMCConstants.emptyXValueMessage} ${xValue?.rowIndex??0}"));
            return;
          }else if(
              xValue.value.runtimeType != DoubleCellValue &&
              xValue.value.runtimeType != IntCellValue
          ){
            notify(ShowSimpleAlert("${MMCConstants.noNumberXValueMessage}  ${xValue.rowIndex}"));
            return;
          }else if(yValue==null){
            notify(ShowSimpleAlert("${MMCConstants.emptyYValueMessage}  ${yValue?.rowIndex??0}"));
            return;
          }else if(
              yValue.value.runtimeType != DoubleCellValue &&
              yValue.value.runtimeType != IntCellValue
          ){
            notify(ShowSimpleAlert("${MMCConstants.noNumberYValueMessage} ${yValue.rowIndex}"));
            return;
          }else{
            double x = 0;
            double y = 0;
            double xy=0;
            double x2=0;
            double y2=0;
            x = double.parse(xValue.value.toString()); 
            y=  double.parse(yValue.value.toString());

            //calculates
            xy = x*y;
            x2 = pow(x, 2).toDouble();
            y2 = pow(y, 2).toDouble();

            //setter data
            tableResultData.add([]);
            tableResultData[index].add(x);
            tableResultData[index].add(y);
            tableResultData[index].add(xy);
            tableResultData[index].add(x2);
            tableResultData[index].add(y2);
            xSum+=x;
            ySum+=y;
            xySum+=xy;
            x2Sum+=x2;
            y2Sum+=y2;

            points.add(
              LineChartBarData(
                barWidth: 1.5,
                spots: [
                  FlSpot(x,y)
                ]
              )
            );

            //validator max & min
            if(xMax < x){
              xMax = x;
            }
            if(x < xMin){
              xMin = x;
            }
          }
        }
        tableResultData.add([
          xSum,
          ySum,
          xySum,
          x2Sum,
          y2Sum,
        ]);

        int n = tableResultData.length-1;
        if(firstRowIsTitles){
          n--;
        }
        //calculates
        double projectedValue=double.parse(projectedValueController.text);
        double b = ((n*xySum) - (xSum*ySum))/((n*x2Sum) - pow(xSum,2));
        double a = (ySum/n) - (b * (xSum/n));
        double c = (b*n)/ySum;
        String yEquation = "Y = ${a.toStringAsFixed(2)} + ${b.toStringAsFixed(2)}x";
        double y= a+(b*projectedValue);
        double r = ( (n*xySum)-(xSum*ySum) )/ (sqrt(((n*x2Sum)-pow(xSum,2)) * ((n*y2Sum)-pow(ySum,2))));
        String typeCorrelation = GlobalMetods.getPercentageRelation(r);
        double eS  = sqrt( (y2Sum - (a*ySum) - (b*xySum))/(n-2) );

        //calc points to draw rect
        double y1 = a+(b*xMin);
        double y2 = a+(b*xMax);

        /*Insert history*/
        HistoryModel history =  HistoryModel(
          date: DateTime.now(),
          typeDesc: MMCConstants.historyType,
          value: "Se proyecto $y para el valor $projectedValue. Se encontro la ecuación $yEquation"
        );
        repository.insertHistory(history).then((value) {
          if(value is ErrorModel){
            notify(ShowSimpleAlert("No se pudo insertar el historial"));
          }
        });
        notify(SetDataResults(
          tableResultData,
          b: b,
          a: a,
          c: c,
          y: y,
          yEquation: yEquation,
          points: points,
          pointsToDrawRect: [
            FlSpot(xMin, y1),
            FlSpot(xMax, y2)
          ],
          r:  r,
          typeCorrelation: typeCorrelation,
          eS: eS
        ));
      }catch(e){
        notify(ShowSimpleAlert("${MMCConstants.readExcelError}. $e"));
      }
    }
  }

  void changeFirstRowTitlesValue(bool newValue){
    notify(ChangeFirstRowTitlesCheckBox(newValue));
  }

  void selectedFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if(result != null){
      Uint8List bytes = File(result.files.first.path??"").readAsBytesSync();
      Excel excel = Excel.decodeBytes(bytes);
      notify(SetExcel(excel, result.files.first.name));
    }
  }


}