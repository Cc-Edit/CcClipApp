import 'package:flutter/material.dart';
import 'package:cc_clip_app/pages/HomePage.dart';
import 'package:cc_clip_app/component/BottomBar.dart';

enum PageName {
  home
}

// 定义一个 MyHomePage 部件，它是一个有状态的部件(StatefulWidget)
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}
// 小部件状态
class _MainViewState extends State<MainView> {
  Widget pageView = const MyHomePage(title: 'CcClip');
  PageName pageName = PageName.home;

  @override
  void initState() {
    super.initState();
  }

  void changePageView(PageName name) {
    if (pageName != name) {
      pageName = name;
      switch (pageName) {
        case PageName.home:
          setState(() {
            pageView = const MyHomePage(title: 'CcClip');
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
          body: Column(
            children: [
              Expanded(child: pageView),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 78,
                child: const BottomBar(),
              )
            ],
          ),
        ),
      ),
    );
  }
}