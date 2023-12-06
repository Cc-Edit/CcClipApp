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
  AnimationController? baseAnimationController; // 标题动画
  AnimationController? pageOneAnimationController; // 第一屏幕动画
  AnimationController? pageTwoAnimationController; // 第二屏幕动画
  AnimationController? pageThreeAnimationController; // 第三屏幕动画
  bool showColor = false; // 点击完成后的礼花
  bool isEnd = false; // 动画全部完成
  int activePage = 1; // 当前激活页面

  late Animation<double> titleAnim;
  late Animation<AlignmentGeometry> logoAnim;
  late Animation<double> logoFadeAnim;
  late Animation<double> descAnim;
  late Animation<double> descAnim1;
  late Animation<double> descAnim2;

  late Animation<AlignmentGeometry> logoAnim_1;
  late Animation<double> logoFadeAnim_1;
  late Animation<double> descAnim_1;
  late Animation<double> descAnim1_1;
  late Animation<double> descAnim2_1;

  late Animation<AlignmentGeometry> logoAnim_2;
  late Animation<double> logoFadeAnim_2;
  late Animation<double> descAnim_2;
  late Animation<double> descAnim1_2;
  late Animation<double> descAnim2_2;

  @override
  void dispose(){
    baseAnimationController?.dispose();
    pageOneAnimationController?.dispose();
    pageTwoAnimationController?.dispose();
    pageThreeAnimationController?.dispose();
    super.dispose();
  }
  // 主要维护标题动画
  void initBaseAnim(){
    // 图片缩放动画
    baseAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this
    );
    // 顶部标题
    titleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: baseAnimationController!,
      curve: const Interval(0.0, 1,  curve: Curves.fastOutSlowIn ),
    ));
    // 标题动画结束后开始首屏进入
    titleAnim.addStatusListener((AnimationStatus status) {
      if(status == AnimationStatus.completed){
        pageOneAnimationController?.forward();
      }
    });
    baseAnimationController?.forward();
  }
  // 首屏动画初始化
  void initPageOneAnim(){
    pageOneAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    );
    // 中间图片
    logoAnim = Tween<AlignmentGeometry>(begin: Alignment.bottomCenter, end: Alignment.center,).animate(CurvedAnimation(
      parent: pageOneAnimationController!,
      curve: const Interval(0.0, 0.5,  curve: Curves.fastOutSlowIn ),
    ));
    logoFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageOneAnimationController!,
      curve: const Interval(0.0, 0.5,  curve: Curves.fastOutSlowIn ),
    ));
    // 下方文字
    descAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageOneAnimationController!,
      curve: const Interval(0.5, 0.6,  curve: Curves.fastOutSlowIn ),
    ));
    descAnim1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageOneAnimationController!,
      curve: const Interval(0.6, 0.7,  curve: Curves.fastOutSlowIn ),
    ));
    descAnim2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageOneAnimationController!,
      curve: const Interval(0.7, 1,  curve: Curves.fastOutSlowIn ),
    ));
  }

  // 第二屏动画初始化
  void initPageTwoAnim(){
    pageTwoAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    );
    // 中间图片
    logoAnim_1 = Tween<AlignmentGeometry>(begin: Alignment.bottomCenter, end: Alignment.center,).animate(CurvedAnimation(
      parent: pageTwoAnimationController!,
      curve: const Interval(0.0, 0.5,  curve: Curves.fastOutSlowIn ),
    ));
    logoFadeAnim_1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageTwoAnimationController!,
      curve: const Interval(0.0, 0.5,  curve: Curves.fastOutSlowIn ),
    ));
    // 下方文字
    descAnim_1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageTwoAnimationController!,
      curve: const Interval(0.5, 0.6,  curve: Curves.fastOutSlowIn ),
    ));
    descAnim1_1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageTwoAnimationController!,
      curve: const Interval(0.6, 0.7,  curve: Curves.fastOutSlowIn ),
    ));
    descAnim2_1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageTwoAnimationController!,
      curve: const Interval(0.7, 1,  curve: Curves.fastOutSlowIn ),
    ));
  }

  // 第三屏动画初始化
  void initPageThreeAnim(){
    pageThreeAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    );
    // 中间图片
    logoAnim_2 = Tween<AlignmentGeometry>(begin: Alignment.bottomCenter, end: Alignment.center,).animate(CurvedAnimation(
      parent: pageThreeAnimationController!,
      curve: const Interval(0.0, 0.5,  curve: Curves.fastOutSlowIn ),
    ));
    logoFadeAnim_2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageThreeAnimationController!,
      curve: const Interval(0.0, 0.5,  curve: Curves.fastOutSlowIn ),
    ));
    // 下方文字
    descAnim_2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageThreeAnimationController!,
      curve: const Interval(0.5, 0.6,  curve: Curves.fastOutSlowIn ),
    ));
    descAnim1_2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageThreeAnimationController!,
      curve: const Interval(0.6, 0.7,  curve: Curves.fastOutSlowIn ),
    ));
    descAnim2_2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: pageThreeAnimationController!,
      curve: const Interval(0.7, 1,  curve: Curves.fastOutSlowIn ),
    ));
  }


  @override
  void initState() {
    initBaseAnim();
    initPageOneAnim();
    initPageTwoAnim();
    initPageThreeAnim();
    super.initState();
  }

  // 根据页标获取页面controller
  AnimationController? getPageController (int index){
    switch (index) {
      case 1:
        return pageOneAnimationController!;
      case 2:
        return pageTwoAnimationController!;
      case 3:
        return pageThreeAnimationController!;
      default: {
        return baseAnimationController!;
      }
    }
  }

  void nextPage(){
    AnimationController? prePage = getPageController(activePage);
    AnimationController? nextPage = getPageController(activePage + 1);

    prePage?.addStatusListener((AnimationStatus status) {
      debugPrint('$status');
      if(status == AnimationStatus.dismissed){
        setState(() {
          activePage = activePage + 1;
          nextPage?.forward();
        });
      }
    });
    prePage?.reverse();
  }

  // 回到应用
  void goMainHome() {
    setState(() {
      showColor = true;
    });
    Timer(const Duration(seconds: 2), () => Navigator.of(context).pushReplacementNamed('/MainPage'));
  }

  @override
  Widget build(BuildContext context) {

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
            if(activePage == 1)
              Container(
              padding: const EdgeInsets.only(bottom: 260),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:FadeTransition(
                  opacity: logoFadeAnim,
                  child: AlignTransition(
                      alignment: logoAnim,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 100),
                        height: 400,
                        child: Padding(padding: EdgeInsets.all(8),
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset('assets/guide/flame-space-adventures.gif',
                                fit: BoxFit.contain,
                              ),
                            )
                        ),
                      )
                  )
              ),
            ),
            if(activePage == 1)
              Container(
              padding: const EdgeInsets.only(top: 540),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    height: 30,
                    child: FadeTransition(
                        opacity: descAnim,
                        child: Text('不断的尝试着去探索未知的领域', style: GoogleFonts.zcoolKuaiLe(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[100],
                        ))
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 70,
                    padding: const EdgeInsets.only(top: 30),
                    child: FadeTransition(
                        opacity: descAnim1,
                        child: Text('把一个又一个的未知变为已知', style: GoogleFonts.zcoolKuaiLe(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[100],
                        ))
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    height: 140,
                    child: FadeTransition(
                        opacity: descAnim2,
                        child: activePage == 3 ? OutlinedButton(
                          style:  const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                            padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.fromLTRB(40, 6, 40, 6)),
                          ),
                          onPressed: () {
                            goMainHome();
                          },
                          child: Text('一起出发', style: GoogleFonts.zcoolKuaiLe(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[100],
                          )),
                        ) : Container(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(3, (index) => InkWell(
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () => {
                                  nextPage()
                                },
                                child: Padding(padding: const EdgeInsets.all(5),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: ShapeDecoration(
                                      color: activePage == (index + 1) ? Colors.brown[700] : Colors.grey[800],
                                      shape: const CircleBorder(),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('${index + 1}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight:  activePage == (index + 1) ? FontWeight.bold : FontWeight.normal,
                                          color: activePage == (index + 1) ? Colors.grey[100] : Colors.grey[600]
                                      ),),
                                  ),),
                              )),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
            if(activePage == 2)
              Container(
                padding: const EdgeInsets.only(bottom: 260),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:FadeTransition(
                    opacity: logoFadeAnim_1,
                    child: AlignTransition(
                        alignment: logoAnim_1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 100),
                          height: 400,
                          child: Padding(padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: Image.asset('assets/guide/arabica-29.gif',
                                  fit: BoxFit.contain,
                                ),
                              )
                          ),
                        )
                    )
                ),
              ),
            if(activePage == 2)
              Container(
                padding: const EdgeInsets.only(top: 540),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 30,
                      child: FadeTransition(
                          opacity: descAnim_1,
                          child: Text('只有克服阻碍，才能体验到成功的喜悦', style: GoogleFonts.zcoolKuaiLe(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[100],
                          ))
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 70,
                      padding: const EdgeInsets.only(top: 30),
                      child: FadeTransition(
                          opacity: descAnim1_1,
                          child: Text('一起勇往直前，突破重重难关', style: GoogleFonts.zcoolKuaiLe(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[100],
                          ))
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 140,
                      child: FadeTransition(
                          opacity: descAnim2_1,
                          child: activePage == 3 ? OutlinedButton(
                            style:  const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                              padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.fromLTRB(40, 6, 40, 6)),
                            ),
                            onPressed: () {
                              goMainHome();
                            },
                            child: Text('一起出发', style: GoogleFonts.zcoolKuaiLe(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100],
                            )),
                          ) : Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(3, (index) => InkWell(
                                  highlightColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () => {
                                    nextPage()
                                  },
                                  child: Padding(padding: const EdgeInsets.all(5),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: ShapeDecoration(
                                        color: activePage == (index + 1) ? Colors.brown[700] : Colors.grey[800],
                                        shape: const CircleBorder(),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text('${index + 1}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight:  activePage == (index + 1) ? FontWeight.bold : FontWeight.normal,
                                            color: activePage == (index + 1) ? Colors.grey[100] : Colors.grey[600]
                                        ),),
                                    ),),
                                )),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            if(activePage == 3)
              Container(
                padding: const EdgeInsets.only(bottom: 260),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:FadeTransition(
                    opacity: logoFadeAnim_2,
                    child: AlignTransition(
                        alignment: logoAnim_2,
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
              ),
            if(activePage == 3)
              Container(
                padding: const EdgeInsets.only(top: 540),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 30,
                      child: FadeTransition(
                          opacity: descAnim_2,
                          child: Text('如果相遇，我会更懂得如何珍惜', style: GoogleFonts.zcoolKuaiLe(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[100],
                          ))
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 70,
                      padding: const EdgeInsets.only(top: 30),
                      child: FadeTransition(
                          opacity: descAnim1_2,
                          child: Text('做一个懂你的视频剪辑工具', style: GoogleFonts.zcoolKuaiLe(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[100],
                          ))
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 140,
                      child: FadeTransition(
                          opacity: descAnim2_2,
                          child: activePage == 3 ? OutlinedButton(
                            style:  const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                              padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.fromLTRB(40, 6, 40, 6)),
                            ),
                            onPressed: () {
                              goMainHome();
                            },
                            child: Text('一起出发', style: GoogleFonts.zcoolKuaiLe(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[100],
                            )),
                          ) : Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(3, (index) => InkWell(
                                  highlightColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () => {
                                    nextPage()
                                  },
                                  child: Padding(padding: const EdgeInsets.all(5),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: ShapeDecoration(
                                        color: activePage == (index + 1) ? Colors.brown[700] : Colors.grey[800],
                                        shape: const CircleBorder(),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text('${index + 1}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight:  activePage == (index + 1) ? FontWeight.bold : FontWeight.normal,
                                            color: activePage == (index + 1) ? Colors.grey[100] : Colors.grey[600]
                                        ),),
                                    ),),
                                )),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            if(showColor)
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                      padding: const EdgeInsets.only(top: 100),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/guide/arabica-colorful.gif',
                        fit: BoxFit.contain,
                      )
                  )
              ),
          ],
        )
    );
  }
}