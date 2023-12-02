import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/BottomTabData.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    this.changeActive,
    this.bottomTabData
  });

  final Function(int index)? changeActive;
  final List<BottomTabData>? bottomTabData;

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController?.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Stack 用来堆叠元素
    return const Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [],
    );
  }
}