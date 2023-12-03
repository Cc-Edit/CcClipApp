import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/DrawMenu.dart';
import 'package:cc_clip_app/pages/MainView.dart';
import 'package:cc_clip_app/store/app_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// 带侧边栏的容器组件
class DrawContainer extends StatefulWidget {
  const DrawContainer({
    super.key,
    this.drawerWidth = 250,
    this.drawerIsOpen,
    this.animatedIconData = AnimatedIcons.arrow_menu,
  });

  final double drawerWidth;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;


  @override
  DrawContainerState createState() => DrawContainerState();
}

class DrawContainerState extends State<DrawContainer> with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  double scrollOffset = 0.0;// 标识抽屉是否打开

  @override
  void initState() {
    // 动画
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    // icon 动画
    iconAnimationController = AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
    iconAnimationController?.animateTo(1.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    // 滑动控制
    scrollController = ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController!.addListener(() {
      debugPrint('$appStore');
      final double offset = scrollController!.offset;
      // 打开侧边栏
      if (offset <= 0) {
        if (scrollOffset != 1.0) {
          setState(() {
            scrollOffset = 1.0;
            try {
              widget.drawerIsOpen!(true);
            } catch (_) {}
          });
        }
        // 设置按钮样式
        iconAnimationController?.animateTo(0.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }else if(offset > 0 && offset < widget.drawerWidth.floor()) {
        if (scrollOffset != 1.0) {
          setState(() {
            scrollOffset = 1.0;
          });
        }
        // 设置按钮样式
        iconAnimationController?.animateTo(
            (offset * 100 / (widget.drawerWidth)) / 100,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else {
        // 关闭侧边栏
        if (scrollOffset != 0.0) {
          setState(() {
            scrollOffset = 0.0;
            try {
              widget.drawerIsOpen!(false);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(1.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  // 帧渲染回调，类比requestAnimationFrame
  Future<bool> getInitState() async {
    scrollController?.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  void onDrawerClick() {
    //if scrollcontroller.offset != 0.0 then we set to closed the drawer(with animation to offset zero position) if is not 1 then open the drawer
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: appStore.showDraw ? const PageScrollPhysics(parent: ClampingScrollPhysics()) : const NeverScrollableScrollPhysics(), // 弹性和禁用滚动
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width + widget.drawerWidth,
            child: Row(
              children: [
                SizedBox( // 抽屉
                  width: widget.drawerWidth,
                  height: MediaQuery.of(context).size.height,
                  child: AnimatedBuilder(
                    animation: iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                          transform: Matrix4.translationValues(scrollController!.offset, 0.0, 0.0),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 60, 10, 30),
                            color:  const Color(0xFF171717),
                            child: const DrawMenu(),
                          )
                      );
                    },
                  ),
                ),
                SizedBox( // 主屏幕
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                      decoration: BoxDecoration(// 背景
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 25),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // 抽屉打开的情况下屏蔽主屏幕的事件
                          IgnorePointer(
                            ignoring: scrollOffset == 1 || false,
                            child: const MainView(),
                          ),
                          // 抽屉打开时，点击主屏幕关闭抽屉
                          if (scrollOffset == 1.0)
                            InkWell(
                              child: AnimatedBuilder(
                                animation: iconAnimationController!,
                                builder: (BuildContext context, Widget? child) {
                                  return Container(
                                      color: Colors.black.withOpacity((1 - iconAnimationController!.value) * 0.7)
                                  );
                                },
                              ),
                              onTap: () {
                                onDrawerClick();
                              },
                            ),
                          // 菜单按钮动画
                          if(appStore.showDraw)
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 4, left: 4),
                            child: SizedBox(
                              width: AppBar().preferredSize.height - 18,
                              height: AppBar().preferredSize.height - 18,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  highlightColor: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                                  child: Center(
                                    child: AnimatedIcon(
                                        color: Colors.white,
                                        icon: widget.animatedIconData ?? AnimatedIcons.arrow_menu,
                                        size: 28,
                                        progress: iconAnimationController!
                                    ),
                                  ),
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    onDrawerClick();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}