

import 'package:fisicapf/models/ErrorModel.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/history/domain/HistoryRepository.dart';
import 'package:fisicapf/screens/history/ui/HistoryEvent.dart';

class HistoryViewModel extends EventViewModel {
  HistoryViewModel(this.repository);
  HistoryRepository repository;

  void getInitialData(){
    repository.getAllHistory().then((value) {
      if(value is ErrorModel){
        notify(ShowSimpleAlert("${value.message} ${value.exception}"));
      }else {
        notify(SetHistory(value));
        notify(SetLoadingScreen(false));
      }
    });
  }
}