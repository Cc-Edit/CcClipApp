import 'package:flutter/material.dart';
import 'package:cc_clip_app/pages/HomePage.dart';
import 'package:cc_clip_app/pages/MessagePage.dart';
import 'package:cc_clip_app/pages/TemplatePage.dart';
import 'package:cc_clip_app/pages/UserPage.dart';
import 'package:cc_clip_app/component/BottomBar.dart';

import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/util/UserStorage.dart';

List<String> pageNameList =[
  'home',
  'message',
  'template',
  'user'
];

// 定义一个 MyHomePage 部件，它是一个有状态的部件(StatefulWidget)
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}
// 小部件状态
class _MainViewState extends State<MainView> {
  Widget pageView = const MyHomePage(title: 'CcClip');
  String pageName = pageNameList[0];
  String userUuid = '';

  // 获取用户信息
  Future<void> initUserInfo() async {
    String? uuid= await UserStorage().getStorage(StoreKeys.userUuid);
    setState(() {
      userUuid = uuid ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  void changePageView(int index) {
    String name = pageNameList[index];
    if (pageName != name) {
      pageName = name;
      switch (pageName) {
        case 'home':
          setState(() {
            pageView = const MyHomePage(title: 'CcClip');
          });
          break;
        case 'message':
          setState(() {
            pageView = const MessagePage(title: '消息');
          });
          break;
        case 'template':
          setState(() {
            pageView = const TemplatePage(title: '模板');
          });
          break;
        case 'user':
          setState(() {
            pageView = const UserPage(title: '模板');
          });
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF181818),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: const Color(0xFF181818),
          body: Stack(
            children: [ // 两个层级叠加，实现底部菜单的超出区域
              Column(
                children: [
                  Expanded(child: pageView),
                ],
              ),
              Column(
                children: [
                  const Expanded(child: SizedBox()),
                  BottomBar(
                    onActiveChange: changePageView
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}