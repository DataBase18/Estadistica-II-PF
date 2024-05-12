
import 'package:fisicapf/screens/statistics/MMC/data/MMCConstants.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCState.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCViewModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TableResult extends StatelessWidget {
  TableResult({super.key, required this.state, required this.viewModel});
  final MMCState state;
  final MMCViewModel viewModel;
  int currentRow = -1;
  @override
  Widget build(BuildContext context) {
    return Table(
      children: state.table.map((e) {
        currentRow++;
        List<dynamic> cells = e;
        return TableRow(
          decoration: BoxDecoration(
            color: state.firstRowTitles&&currentRow==0?
                Colors.amberAccent:currentRow==state.table.length-1?
                Colors.lightGreen:Colors.transparent,
            border: Border.all()
          ),
          children: [
            TableCell(child: Text(cells.elementAt(0).toString()), ),
            TableCell(child: Text(cells.elementAt(1).toString())),
            TableCell(child: Text(cells.elementAt(2).toString())),
            TableCell(child: Text(cells.elementAt(3).toString())),
          ]
        );
      }).toList(),
    );
  }
}


class ResultData extends StatelessWidget {
  const ResultData({super.key, required this.state, required this.viewModel});
  final MMCState state;
  final MMCViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${MMCConstants.equationResultText} ${state.equation}"),
        Text("${MMCConstants.bResultText} ${state.b}"),
        Text("${MMCConstants.aResultText} ${state.a}"),
        Text("${MMCConstants.cResultText} ${state.c}"),
        SizedBox(height: height*0.01,),
        Text("${MMCConstants.yResultText} ${state.y}"),
      ],
    );
  }
}

class ScatterPlot extends StatelessWidget {
  const ScatterPlot({super.key, required this.state});
  final MMCState state;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height*0.25,
      width: width*0.9,
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
          ),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  state.pointsToLine.first,
                  state.pointsToLine.last
                ],
                isCurved: false,
                barWidth: 1.5 ,
                dotData:const  FlDotData(show: false),
                belowBarData: BarAreaData( show: false, ),
                color: Theme.of(context).colorScheme.primary
            ),
            ...state.points
          ]
        )
      )
    );
  }
}