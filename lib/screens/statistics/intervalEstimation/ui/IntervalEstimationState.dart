

import 'package:flutter/cupertino.dart';

class IntervalEstimationState {
  bool typeCalcSample = true;
  TextEditingController sampleController=TextEditingController();
  TextEditingController populationController= TextEditingController();
  TextEditingController meanController=TextEditingController();
  TextEditingController deviationSigmaController=TextEditingController();
  TextEditingController iCController=TextEditingController();
  String currentResponse="";
  String currentResponseInfo="";
}