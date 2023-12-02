import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/BottomTabData.dart';
import 'package:cc_clip_app/component/BottomTabIcon.dart';
import 'package:cc_clip_app/store/app_store.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    this.onActiveChange,
  });

  final Function(int index)? onActiveChange;

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

  // tab 选中事件
  void onTabActive(int index) {
    widget.onActiveChange?.call(index);
    appStore.changeBottomTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    // Stack 用来堆叠元素
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        AnimatedBuilder(animation: animationController!, builder: (BuildContext context, Widget? child) {
          // 初始化旋转动画
          final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animationController!,
                  curve: Curves.fastOutSlowIn
          ));
          // 匀速变宽
          final centerBoxAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController!,
              curve: Curves.fastOutSlowIn
          ));
          return Transform(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: PhysicalShape(
              color: Colors.orange,
              elevation: 10.0,
              clipper: TabClipper(radius: animation.value * 40.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 62,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(
                        children: [
                          ...List.generate(5, (index) {
                            if(index < 2) {
                              return  Expanded(
                                child: BottomTabIcon(iconData: BottomTabData.tabList[index], onActive: onTabActive),
                              );
                            }else if (index == 2) {
                              return SizedBox(
                                width: centerBoxAnimation.value * 64.0,
                              );
                            }else {
                              return Expanded(
                                child: BottomTabIcon(iconData: BottomTabData.tabList[index-1], onActive: onTabActive),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}

// 自定义剪切路径，通过指令绘制图形
class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180), degreeToRadians(90), false);
    path.arcTo(Rect.fromLTWH(((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(70), false);
    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);
    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
  // 角度转换弧度
  double degreeToRadians(double degree) {
    return (pi / 180) * degree;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}