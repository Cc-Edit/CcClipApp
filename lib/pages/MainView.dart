import 'package:flutter/material.dart';
import 'package:cc_clip_app/pages/HomePage.dart';

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
  Widget? pageView;
  PageName? pageName;

  @override
  void initState() {
    pageName = PageName.home;
    pageView = const MyHomePage(title: 'CcClip');
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
          body: pageView,
        ),
      ),
    );
  }
}