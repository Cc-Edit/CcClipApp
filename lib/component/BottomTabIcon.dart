import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cc_clip_app/model/BottomTabData.dart';
import 'package:cc_clip_app/store/app_store.dart';

class BottomTabIcon extends StatefulWidget {
  const BottomTabIcon({super.key, required this.iconData, this.onActive});

  final BottomTabData iconData;
  final Function(int index)? onActive;

  @override
  State<StatefulWidget> createState() => BottomTabIconState();
}
class BottomTabIconState extends State<BottomTabIcon> with TickerProviderStateMixin {
  @override
  void initState() {
    // 向按钮添加动画
    widget.iconData?.animationController =  AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        widget.onActive!(widget.iconData!.index);
        widget.iconData?.animationController?.reverse();
      }
    });
    super.initState();
  }

  void setAnimation() {
    widget.iconData?.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 图片缩放动画
    final imageScaleAnimation = Tween<double>(begin: 0.88, end: 1.0).animate(CurvedAnimation(
            parent: widget.iconData!.animationController!,
            curve: const Interval(0.1, 1.0, curve: Curves.fastOutSlowIn)));
    // 装饰动画
    final circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.iconData!.animationController!,
            curve: const Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));
    final circleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.iconData!.animationController!,
            curve: const Interval(0.5, 0.8, curve: Curves.fastOutSlowIn)));
    final circleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.iconData!.animationController!,
            curve: const Interval(0.5, 0.6, curve: Curves.fastOutSlowIn)));
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: Observer(
          builder: (_) => InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              // 按钮未激活执行动画
              if (appStore.activeBottomTabIndex != widget.iconData.index) {
                setAnimation();
              }
            },
            child: IgnorePointer(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  ScaleTransition(
                    alignment: Alignment.center,
                    scale: imageScaleAnimation,
                    child: Image.asset(appStore.activeBottomTabIndex == widget.iconData.index ? widget.iconData!.activeImagePath : widget.iconData!.imagePath),
                  ),
                  Positioned(
                    top: 4,
                    left: 6,
                    right: 0,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 6,
                    bottom: 8,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation1,
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 8,
                    bottom: 0,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation2,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}