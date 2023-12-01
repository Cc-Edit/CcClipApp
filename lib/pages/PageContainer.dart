import 'package:flutter/material.dart';
import 'package:cc_clip_app/pages/HomePage.dart';
import 'package:cc_clip_app/pages/DrawContainer.dart';

enum PageName {
  home
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.pageName,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  PageName? pageName;
}

// 页面容器
class PageContainer extends StatefulWidget {
  const PageContainer({super.key});
  @override
  State<PageContainer> createState() => _PageContainerState();
}
// 小部件状态
class _PageContainerState extends State<PageContainer> {
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
          body: DrawContainer(
            pageName: pageName, // 当前激活的页面
            drawerWidth: MediaQuery.of(context).size.width * 0.75, // 侧边栏宽度比例
            onDrawerCall: (PageName newPage) {
              changePageView(newPage);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            pageView: pageView, // 当前渲染的容器
          ),
        ),
      ),
    );
  }
}