


import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/home/ui/HomeEvent.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel  extends EventViewModel{

  void changeCurrentPage ({required Widget newPage,required int newIndexPage}){
    notify(SetCurrentMenu(currentPage: newPage, currentIndex: newIndexPage));
  }
}