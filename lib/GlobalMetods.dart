
import 'package:fisicapf/GlobalConstants.dart';

class GlobalMetods {

  static String? validatorIsNumber (String? value) {
    if(int.tryParse(value ?? "") == null){
      return GlobalConstants.inputValidatorNumberError;
    }
    return null;
  }

  static String? validatorEmpty (String? value){
    if(value == null || value.isEmpty){
      return GlobalConstants.invalidValueError;
    }
    return null;
  }
}