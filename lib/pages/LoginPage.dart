import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? starAnimationController;
  AnimationController? pageAnimationController;
  AnimationController? animationController;

  @override
  void initState(){
    super.initState();
    // 滑动控制
    scrollController = ScrollController(initialScrollOffset: 0);
    scrollController!.addListener(() {
      // final double offset = scrollController!.offset;
    });
    // 动画
    pageAnimationController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    starAnimationController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    pageAnimationController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);

    Timer(const Duration(milliseconds: 600), () => {
      starAnimationController?.repeat(reverse: true),
      pageAnimationController?.forward(),
      animationController?.forward(),
      // 渲染完成后
      WidgetsBinding.instance.addPostFrameCallback((_) => startAnimation())
    });
  }

  void startAnimation() {
    scrollController?.animateTo(
      MediaQuery.of(context).size.height - 200,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose(){
    scrollController?.dispose();
    animationController?.dispose();
    pageAnimationController?.dispose();
    starAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageAnimationController!,
      curve: const Interval(0, 1,  curve: Curves.fastOutSlowIn ),
    ));
    final textAnimation = Tween<double>(begin: 0.1, end: 1).animate(CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0, 0.4,  curve: Curves.fastOutSlowIn ),
    ));
    // 装饰动画
    final circleAnimation = Tween<double>(begin: 0.0, end: 1).animate(CurvedAnimation(
        parent:starAnimationController!,
        curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn)
    ));
    final circleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent:starAnimationController!,
        curve: const Interval(0.3, 0.8, curve: Curves.fastOutSlowIn)
    ));
    final circleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent:starAnimationController!,
        curve: const Interval(0.5, 0.7, curve: Curves.fastOutSlowIn)
    ));
    final circleAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent:starAnimationController!,
        curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn)
    ));
    final circleAnimation4 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent:starAnimationController!,
        curve: const Interval(0.7, 0.9, curve: Curves.fastOutSlowIn)
    ));
    return Stack(
      children: [
        SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
                width: width,
                height: height * 2,
                child: Column(
                  children: [
                    // 第一屏
                    Container(
                      color: const Color(0XFF181818),
                      height: height,
                      width: width,
                    ),
                    // 第二屏
                    Container(
                      color: Colors.grey[800],
                      height: height,
                      width: width,
                    )
                  ],
                )
            )
        ),
        Padding(
            padding: const EdgeInsets.only(top: 120),
            child:  AnimatedBuilder(animation: pageAnimationController!, builder: (BuildContext context, Widget? child) {
              return SizedBox(
                  width: width,
                  height: 200,
                  child: PhysicalShape(
                    // color: Colors.yellow,
                      color: const Color(0XFF181818),
                      clipper: HeadClipper(radius: animation.value * 80.0),
                      child: const SizedBox()
                  )
              );
            })
        ),
        Container(
          width: width,
          height: 400,
          child: AnimatedBuilder(animation: animationController!, builder: (BuildContext context, Widget? child) {
            return IgnorePointer(
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Positioned(
                    top: -200,
                    right: 50,
                    bottom: 30,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -160,
                    left: 170,
                    bottom: 30,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation1,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -20,
                    right: 50,
                    bottom: 20,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation2,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 150,
                    bottom: 0,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation3,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -120,
                    left: 20,
                    bottom: 0,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation4,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ]
              )
            );
          })
        ),

        SizedBox(
          width: width,
          height: height,
          child: AnimatedBuilder(animation: animationController!, builder: (BuildContext context, Widget? child) {
            return Transform(
                transform: Matrix4.translationValues(0, 0 - (textAnimation.value * 260), 0.0),
                child: Center(
                  child: Text('Cc Clip', style: GoogleFonts.akayaKanadaka(
                    fontSize: 100 - (textAnimation.value * 50),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    color: Colors.grey[100],
                  ),
                  ),
                )
            );
          })
        ),
      ],
    );
  }
}


// 自定义剪切路径，通过指令绘制图形
class HeadClipper extends CustomClipper<Path> {
  HeadClipper({this.radius = 50.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double v = radius * 2;
    path.arcTo(Rect.fromLTWH(0, 0, size.width, v), degreeToRadians(0), degreeToRadians(180), true);
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