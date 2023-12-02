import 'package:flutter/material.dart';

class BottomTabData {
  BottomTabData({
    this.index = 0,
    this.isActive = false,
    this.imagePath = '',
    this.activeImagePath = '',
    this.animationController,
  });

  int index;
  bool isActive;
  String imagePath;
  String activeImagePath;
  AnimationController? animationController;

  static List<BottomTabData> tabList = <BottomTabData>[
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_1.png',
      activeImagePath: 'assets/tabIcon/tab_1s.png',
      index: 0,
      isActive: true,
      animationController: null,
    ),
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_2.png',
      activeImagePath: 'assets/tabIcon/tab_2s.png',
      index: 1,
      isActive: false,
      animationController: null,
    ),
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_3.png',
      activeImagePath: 'assets/tabIcon/tab_3s.png',
      index: 2,
      isActive: false,
      animationController: null,
    ),
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_4.png',
      activeImagePath: 'assets/tabIcon/tab_4s.png',
      index: 3,
      isActive: false,
      animationController: null,
    ),
  ];
}