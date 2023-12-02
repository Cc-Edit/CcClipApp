import 'package:flutter/material.dart';

class BottomTabData {
  BottomTabData({
    this.index = 0,
    this.isActive = false,
    this.imagePath = '',
    this.title = '',
    this.activeImagePath = '',
    this.animationController,
  });

  int index;
  bool isActive;
  String title;
  String imagePath;
  String activeImagePath;
  AnimationController? animationController;

  static List<BottomTabData> tabList = <BottomTabData>[
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_1.png',
      activeImagePath: 'assets/tabIcon/tab_1a.png',
      title: '剪辑',
      index: 0,
      isActive: true,
      animationController: null,
    ),
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_2.png',
      activeImagePath: 'assets/tabIcon/tab_2a.png',
      title: '消息',
      index: 1,
      isActive: false,
      animationController: null,
    ),
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_3.png',
      activeImagePath: 'assets/tabIcon/tab_3a.png',
      title: '模板',
      index: 2,
      isActive: false,
      animationController: null,
    ),
    BottomTabData(
      imagePath: 'assets/tabIcon/tab_4.png',
      activeImagePath: 'assets/tabIcon/tab_4a.png',
      title: '我的',
      index: 3,
      isActive: false,
      animationController: null,
    ),
  ];
}