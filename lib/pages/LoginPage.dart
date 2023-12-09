import 'dart:async';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/FormGenerate.dart';
import 'package:cc_clip_app/model/FormData.dart';
import 'package:cc_clip_app/api/ApiAuth.dart';
import 'package:cc_clip_app/api/ApiBase.dart';
import 'package:cc_clip_app/api/ApiUser.dart';
import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/util/UserStorage.dart';


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
  late Timer _timer;
  bool showLoading = false;

  @override
  void initState(){
    super.initState();

    // 滑动控制
    scrollController = ScrollController(initialScrollOffset: 0);
    scrollController!.addListener(() {
      // final double offset = scrollController!.offset;
    });
    // 动画
    pageAnimationController = AnimationController(duration: const Duration(milliseconds: 1800), vsync: this);
    starAnimationController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    animationController = AnimationController(duration: const Duration(milliseconds: 1600), vsync: this);

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
  void login(Map<String, dynamic> formData) async {
    setState(() {
      showLoading = true;
    });
    CustomResponse loginRes = await userLogin(formData);
    if(loginRes.success && !loginRes.hasError) {
      String token = loginRes.data['access_token'];
      await UserStorage().setStorage(StoreKeys.accessToken, token);
      _timer = Timer(const Duration(milliseconds: 600), () {
        getUserData(token);
      });
    }else{
      setState(() {
        showLoading = false;
      });
    }
  }
  void getUserData(String token) async{
    CustomResponse userRes = await getUserInfo();
    setState(() {
      showLoading = false;
    });
    if(userRes.success && !userRes.hasError) {
      await UserStorage().setStorage(StoreKeys.userName, userRes.data['name']);
      await UserStorage().setStorage(StoreKeys.userPhone, userRes.data['phone']);
      await UserStorage().setStorage(StoreKeys.userEmail, userRes.data['email']);
      await UserStorage().setStorage(StoreKeys.userUuid, userRes.data['uuid']);
      await UserStorage().setStorage(StoreKeys.userRole, userRes.data['role']);
      await UserStorage().setStorage(StoreKeys.userStatus, userRes.data['status']);
      showLoginDialog();
    }
  }
  // 登录成功
  void showLoginDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        _timer = Timer(const Duration(milliseconds: 1600), () {
          Navigator.of(context).pushNamedAndRemoveUntil('/MainPage', (Route<dynamic> route) => false);
        });
        return SimpleDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.grey[900],
          shadowColor: Colors.grey[900],
          surfaceTintColor: Colors.grey[900],
          elevation:99,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child:  Image.asset('assets/image/casual-life-3d-check-mark-pink.png', fit: BoxFit.contain,),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Text('登录成功', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[100]
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 0)),
          ],
        );
      }
    ).then((val){
      if (_timer.isActive) {
        _timer.cancel();
      }
      Navigator.of(context).pushNamedAndRemoveUntil('/MainPage', (Route<dynamic> route) => false);
    });
  }
  @override
  void dispose(){
    scrollController?.dispose();
    animationController?.dispose();
    pageAnimationController?.dispose();
    starAnimationController?.dispose();
    _timer.cancel();
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
    final circleAnimation5 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent:starAnimationController!,
        curve: const Interval(0.1, 0.3, curve: Curves.fastOutSlowIn)
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
                      color: Colors.grey[900],
                      height: height,
                      width: width,
                      child: Column(
                        children: [
                          Expanded(child: FormGenerate(
                            formData: FormData.loginForm,
                            onSubmit: login,
                            showLoading:showLoading,
                            padding: const EdgeInsets.only(top: 120, left: 30, right: 30),
                          ))
                        ],
                      )
                    )
                  ],
                )
            )
        ),
        // 背景
        Padding(
            padding: const EdgeInsets.only(top: 0),
            child:  AnimatedBuilder(animation: pageAnimationController!, builder: (BuildContext context, Widget? child) {
              return Container(
                  width: width,
                  height: 280,
                  child: PhysicalShape(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0XFF181818),
                      clipper: HeadClipper(radius: animation.value * 80.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: width,
                            height: 310,
                            child: Image.asset('assets/image/space-background-blue-pink-planet.png', fit: BoxFit.cover,),
                          ),
                          Container(
                            color: const Color(0XFF181818).withOpacity(1 - (0.35 * animation.value)),
                            width: width,
                            height: 310,
                            child: SizedBox(),
                          )
                        ],
                      )
                  )
              );
            })
        ),
        // 星星
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
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: Image.asset('assets/image/icons8-star-96.png', fit: BoxFit.contain,),
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
                      child: SizedBox(
                        width: 7,
                        height: 7,
                        child: Image.asset('assets/image/icons8-star-96.png', fit: BoxFit.contain,),
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
                      child: SizedBox(
                        width: 12,
                        height: 12,
                        child: Image.asset('assets/image/icons8-star-96.png', fit: BoxFit.contain,),
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
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: Image.asset('assets/image/icons8-star-96.png', fit: BoxFit.contain,),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 120,
                    bottom: 80,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation4,
                      child: SizedBox(
                        width: 9,
                        height: 9,
                        child: Image.asset('assets/image/icons8-star-96.png', fit: BoxFit.contain,),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -20,
                    left: 20,
                    bottom: 0,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: circleAnimation5,
                      child: SizedBox(
                        width: 9,
                        height: 9,
                        child: Image.asset('assets/image/icons8-star-96.png', fit: BoxFit.contain,),
                      ),
                    ),
                  ),
                ]
              )
            );
          })
        ),
        // 标题
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
    path.lineTo(0, size.height - v);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - v);
    path.arcTo(Rect.fromLTWH(0, size.height - v, size.width, v), degreeToRadians(0), degreeToRadians(180), false);
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