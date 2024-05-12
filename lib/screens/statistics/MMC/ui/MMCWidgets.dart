
import 'package:fisicapf/screens/statistics/MMC/ui/MMCState.dart';
import 'package:fisicapf/screens/statistics/MMC/ui/MMCViewModel.dart';
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
