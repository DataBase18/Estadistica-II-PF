
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/MMC/data/MMCConstants.dart';
import 'package:fisicapf/screens/statistics/MMC/domain/MMCRepository.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCEvent.dart';

class MMCViewModel extends EventViewModel {
  MMCRepository repository;
  MMCViewModel(this.repository);

  void selectedFile(bool firstRowIsTitles) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if(result!=null){
      try{
        Uint8List bytes = File(result.files.first.path??"").readAsBytesSync();
        Excel excel = Excel.decodeBytes(bytes);
        final firstTable = excel.tables.values.first;

        //utils variables
        double xSum=0;
        double ySum=0;
        double xySum=0;
        double x2Sum=0;
        List<List<dynamic>> tableResultData=[];
        int initialIndexRow = 0;

        if(firstRowIsTitles){
          initialIndexRow=1;
          tableResultData.add([]);
          tableResultData[0].add(firstTable.rows.elementAt(0).elementAt(0)?.value??"");
          tableResultData[0].add(firstTable.rows.elementAt(0).elementAt(1)?.value??"");
          tableResultData[0].add("XY");
          tableResultData[0].add("X^2");
        }

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
            double x2;
            x = double.parse(xValue.value.toString()); 
            y=  double.parse(yValue.value.toString());

            //calculates
            xy = x*y;
            x2 = pow(x, 2).toDouble();

            //setter data
            tableResultData.add([]);
            tableResultData[index].add(x);
            tableResultData[index].add(y);
            tableResultData[index].add(xy);
            tableResultData[index].add(x2);
            xSum+=x;
            ySum+=y;
            xySum+=xy;
            x2Sum+=x2;
          }
        }
        tableResultData.add([
          xSum,
          ySum,
          xySum,
          x2Sum
        ]);

      }catch(e){
        notify(ShowSimpleAlert("${MMCConstants.readExcelError}. $e"));
      }
    }
  }

  void changeFirstRowTitlesValue(bool newValue){
    notify(ChangeFirstRowTitlesCheckBox(newValue));
  }



}