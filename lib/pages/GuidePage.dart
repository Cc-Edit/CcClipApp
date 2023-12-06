import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

enum GuideType {
  start,
  guide,
  advertisement,
  time
}

// 引导页面
class GuidePage extends StatefulWidget {
  const GuidePage({super.key,this.type = GuideType.start});
  final GuideType type;
  @override
  State<GuidePage> createState() => GuidePageState();
}
// 小部件状态
class GuidePageState extends State<GuidePage>  with TickerProviderStateMixin {
  AnimationController? animationController; // 动画管理
  Animation<double>? colorAnim;
  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 图片缩放动画
    animationController = AnimationController(
        duration: const Duration(milliseconds: 3000),
        vsync: this
    );
    animationController?.forward();
  }

  void setColor() {
    setState(() {
      colorAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.0, 0.2,  curve: Curves.fastOutSlowIn ),
      ));
    });
    Timer(const Duration(seconds: 3), () => print('done'));
  }

  @override
  Widget build(BuildContext context) {
    // 顶部标题
    final Animation<double> titleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0.0, 0.3,  curve: Curves.fastOutSlowIn ),
    ));
    // 中间图片
    final Animation<AlignmentGeometry> LogoAnim = Tween<AlignmentGeometry>(begin: Alignment.bottomCenter, end: Alignment.center,).animate(CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0.0, 0.3,  curve: Curves.fastOutSlowIn ),
    ));
    // 下方文字
    final Animation<double> descAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0.3, 0.4,  curve: Curves.fastOutSlowIn ),
    ));
    final Animation<double> descAnim1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0.4, 0.5,  curve: Curves.fastOutSlowIn ),
    ));

    final Animation<double> descAnim2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0.5, 0.7,  curve: Curves.fastOutSlowIn ),
    ));

    return Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color(0xFF181818),
              padding: const EdgeInsets.fromLTRB(20, 80, 10, 80),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeTransition(
                    sizeFactor: titleAnim,
                    axis: Axis.horizontal,
                    axisAlignment: -1,
                    child: Text('Cc Clip', style: GoogleFonts.whisper(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[100],
                    ),
                    ),),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 260),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: AlignTransition(
                      alignment: LogoAnim,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 100),
                        height: 400,
                        child: Padding(padding: EdgeInsets.all(8),
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset('assets/guide/arabica.gif',
                                fit: BoxFit.contain,
                              ),
                            )
                        ),
                      )
                  )
            ),
            Container(
              padding: const EdgeInsets.only(top: 540),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          height: 30,
                          child: FadeTransition(
                              opacity: descAnim,
                              child: Text('发现同伴', style: GoogleFonts.zcoolKuaiLe(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100],
                              ))
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          height: 30,
                          child: FadeTransition(
                              opacity: descAnim1,
                              child: Text('发现知己', style: GoogleFonts.zcoolKuaiLe(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100],
                              ))
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 40),
                      height: 120,
                      child: FadeTransition(
                          opacity: descAnim2,
                          child: OutlinedButton(
                            style:  const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                              padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.fromLTRB(40, 6, 40, 6))
                            ),
                            onPressed: () {
                              setColor();
                            },
                            child: Text('一起出发', style: GoogleFonts.zcoolKuaiLe(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100],
                            )),
                          )

                      ),
                    ),
                  ],
                ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  padding: const EdgeInsets.only(top: 100),
                  width: MediaQuery.of(context).size.width,
                  child: colorAnim != null ? FadeTransition(
                    opacity: colorAnim!,
                    child: Image.asset('assets/guide/arabica-colorful.gif',
                      fit: BoxFit.contain,
                    )
                  ) : null,
                )
            ),
          ],
        )
    );
  }
}