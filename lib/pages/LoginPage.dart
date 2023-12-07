import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  ScrollController? scrollController;
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
    animationController = AnimationController(duration: const Duration(milliseconds: 1600), vsync: this);
    animationController?.forward();
    // 渲染完成后
    WidgetsBinding.instance.addPostFrameCallback((_) => startAnimation());
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0, 1,  curve: Curves.fastOutSlowIn ),
    ));
    return AnimatedBuilder(animation: animationController!, builder: (BuildContext context, Widget? child) {
      return Stack(
        children: [
          SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 2,
                  child: Column(
                    children: [
                      // 第一屏
                      Container(
                        color: const Color(0XFF181818),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      // 第二屏
                      Container(
                        color: Colors.grey[800],
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      )
                    ],
                  )
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: PhysicalShape(
                  // color: Colors.yellow,
                    color: const Color(0XFF181818),
                    clipper: TabClipper(radius: animation.value * 80.0),
                    child: const SizedBox()
                )
            ),
          )
        ],
      );
    });
  }
}


// 自定义剪切路径，通过指令绘制图形
class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 50.0});

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