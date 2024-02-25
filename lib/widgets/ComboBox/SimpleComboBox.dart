

import 'package:flutter/material.dart';

class SimpleComboBox extends StatelessWidget {
  const SimpleComboBox({super.key, this.onChange, this.value, this.items, this.currentValue});

  final Function(Object?)? onChange;
  final Object? value;
  final List<DropdownMenuItem<dynamic>>? items;
  final dynamic currentValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary
          ),
          borderRadius: BorderRadius.circular(5)
      ),
      child: DropdownButton(
        isExpanded: true,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        underline: Container(),
        onChanged: (value){
          if(onChange!=null){
            onChange!(value);
          }
        },
        value: currentValue,
        items: items,
      ),
    );
  }
}
