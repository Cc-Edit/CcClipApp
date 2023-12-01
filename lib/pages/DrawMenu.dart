import 'package:flutter/material.dart';
import 'package:cc_clip_app/pages/PageContainer.dart';

// 侧边栏小组件
class DrawMenu extends StatefulWidget {
  const DrawMenu({
    super.key,
    this.pageName,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.pageView,
    this.drawerIsOpen,
    this.animatedIconData,
    this.menuView
  });

  final PageName? pageName;
  final double drawerWidth;
  final Function(PageName)? onDrawerCall;
  final Widget? pageView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;


  @override
  DrawMenuState createState() => DrawMenuState();
}

class DrawMenuState extends State<DrawMenu> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('123');
  }
}