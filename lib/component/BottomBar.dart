import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/BottomTabData.dart';
import 'package:cc_clip_app/component/BottomTabIcon.dart';
import 'package:cc_clip_app/store/app_store.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    this.onActiveChange, this.menuClick,
  });

  final Function(int index)? onActiveChange;
  final Function()? menuClick;

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController?.forward();
  }

  // tab 选中事件
  void onTabActive(int index) {
    widget.onActiveChange?.call(index);
    appStore.changeBottomTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    // 中心块放大动画、背景撑开动画、中心块位置动画
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Curves.fastOutSlowIn
    ));
    // Stack 用来堆叠元素
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        AnimatedBuilder(animation: animationController!, builder: (BuildContext context, Widget? child) {
          return Transform(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: PhysicalShape(
              color: const Color(0xFF282828),
              elevation: 17.0,
              clipper: TabClipper(radius: animation.value * 40.0),
              child:
              Column(
                children: [
                  SizedBox(
                    height: 78,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(
                        children: [
                          ...List.generate(5, (index) {
                            if(index < 2) {
                              return  Expanded(
                                child: BottomTabIcon(iconData: BottomTabData.tabList[index], onActive: onTabActive),
                              );
                            }else if (index == 2) {
                              return SizedBox(
                                width: animation.value * 64.0,
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
                  ),
                ],
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.only(bottom: 33),
          child: SizedBox(
            width: 40 * 2, // 40 为中心圆形Radius
            height: 40 * 2,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 40 * 2,
                height: 40 * 2,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: animation,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.pink.withOpacity(0.4),
                              offset: const Offset(2.0, 8.0),
                              blurRadius: 26.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white.withOpacity(0.2),
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: widget.menuClick,
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            child: Image.asset("assets/tabIcon/menu5.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        )
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