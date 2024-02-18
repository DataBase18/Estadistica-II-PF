
import 'package:flutter/material.dart';

class InputBasic extends StatelessWidget {
  InputBasic(
      {super.key,
        this.label,
        this.leftIcon,
        this.placeholderHelp,
        this.rigthIcon,
        this.inTextHelper,
        this.downTextHelper,
        this.validator,
        this.onChange,
        this.inputController,
        this.isPassword,
        this.enabled,
        this.maxLines = 1,
        this.focusController,
        this.autoFocus,
        this.onSubmit,
        this.controllerSelector,
        this.internPadding, this.fontSize, this.keyboard, this.onTabLeftIcon, this.onTabRigthIcon, this.readOnly = false, this.onTab});

  final String? label;
  final Widget? leftIcon;
  final Function? onTabLeftIcon;
  final String? placeholderHelp;
  final Widget? rigthIcon;
  final Function? onTabRigthIcon;
  final String? inTextHelper;
  final String? downTextHelper;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final TextEditingController? inputController;
  final bool? isPassword;
  final bool? enabled;
  final int? maxLines;
  final bool? autoFocus;
  final Function()? onSubmit;
  final TextSelectionControls? controllerSelector;
  final EdgeInsetsGeometry? internPadding;
  final double? fontSize;
  final TextInputType? keyboard;
  final bool readOnly;
  final Function()? onTab;
  FocusNode? focusController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ,
      keyboardType: keyboard,
      style: TextStyle(
          fontSize: fontSize
      ),
      onFieldSubmitted: (String data) async {
        if(onSubmit!=null){
          await onSubmit!();
        }
      },
      onTap: onTab,
      selectionControls: controllerSelector,
      autofocus: autoFocus??false,
      maxLines: maxLines,
      enabled: enabled,
      obscureText: isPassword ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: inputController,
      onChanged: onChange,
      validator: validator,
      focusNode: focusController,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          hintText: placeholderHelp,
          contentPadding: internPadding,
          suffixIcon: rigthIcon!= null?GestureDetector(
            child: SizedBox(
              width: 50,
              child: rigthIcon,
            ),
            onTap:(){
              if(onTabRigthIcon!=null){
                onTabRigthIcon!();
              }
            },
          ):null,
          prefixIcon: leftIcon!=null? GestureDetector(
            child: SizedBox(width: 50,child: leftIcon,),
            onTap: (){
              if(onTabLeftIcon!=null){
                onTabLeftIcon!();
              }
            },
          ):null
      ),
    );
  }
}