
import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/screens/screens.dart';
import 'package:fisicapf/screens/home/data/HomeConstants.dart';
import 'package:flutter/material.dart';

class HomeState{


  Widget currentPage;
  int currentIndexPage;


  HomeState({
    required this.currentIndexPage,
    required this.currentPage
  });
}