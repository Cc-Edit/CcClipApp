import 'dart:math';
import 'package:flutter/material.dart';

import 'package:cc_clip_app/model/MessageListData.dart';
import 'package:cc_clip_app/component/ListItem/MessageListItem.dart';

import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/util/UserStorage.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => MessageListState();
}

// TickerProviderStateMixin 用来实现动画
class MessageListState extends State<MessageList> with TickerProviderStateMixin {

  List<MessageListData> messageListData =  MessageListData.emptyList;
  AnimationController? animationController; // 动画管理

  final List<String> tabs = <String>['官方', '评论', '粉丝', '点赞'];
  String userUuid = '';

  // 获取用户信息
  Future<void> initUserInfo() async {
    String? uuid= await UserStorage().getStorage(StoreKeys.userUuid);
    setState(() {
      userUuid = uuid ?? '';
    });
  }

  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initUserInfo();
    getData(0);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );
  }

  void getData(int index) {
    // await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    setState(() {
      messageListData = ((index == 0 && userUuid.isNotEmpty) ? MessageListData.messageList : MessageListData.emptyList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              getData(tabController.index);
            }
          });
          return  Scaffold(
              body:NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: SliverAppBar(
                          scrolledUnderElevation: 0.0,
                          title: const SizedBox(
                            height: 30,
                            child: Text('消息'),
                          ),
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(1),
                            child: Column(
                              children: [
                                Container(
                                  color: const Color(0xFF181818),
                                  child: TabBar(
                                      overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey[900]),
                                      indicatorColor: Colors.pink[400],
                                      controller: tabController,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      labelStyle: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                      unselectedLabelStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[300],
                                          fontWeight: FontWeight.normal
                                      ),
                                      dividerColor: Colors.grey[900],
                                      tabs: tabs.map((String name) => Tab(text: name)).toList()
                                  ),
                                ),
                                Container(
                                  color: Colors.grey[900],
                                  height: 1.0,
                                ),
                              ],
                            ),

                          ),
                          actions: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Row(
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    highlightColor: Colors.white.withOpacity(1),
                                    color: Colors.white,
                                    icon: const Icon(Icons.question_answer),
                                    onPressed: () => {},
                                  )
                                ],
                              ),
                            )
                          ],
                          forceElevated: innerBoxIsScrolled,
                          expandedHeight: 100,
                          toolbarHeight: 48,
                          collapsedHeight: 48,
                          backgroundColor: const Color(0xFF181818),
                          titleTextStyle: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                          floating: false,
                          pinned: true,
                          snap: false,
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: tabs.map((String name) {
                      return SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                              builder: (BuildContext context) {
                                if(messageListData.isEmpty) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        const Padding(padding: EdgeInsets.only(top: 200)),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 2,
                                          child: Image.asset('assets/image/arabica-1127.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const Padding(padding: EdgeInsets.only(top: 30)),
                                        Text('暂时没有更多消息', style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[500]
                                        ),)
                                      ],
                                    ),
                                  );
                                }
                                return CustomScrollView(
                                    key: PageStorageKey<String>(name),
                                    slivers: <Widget>[
                                      SliverOverlapInjector(
                                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                                      ),
                                      SliverPadding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 80),
                                        sliver: SliverFixedExtentList(
                                          itemExtent: 140.0,
                                          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                            final int count = messageListData.length;
                                            final int animationCount = min(count, 5);
                                            final int animationIndex = min(index, 5);
                                            final Animation<double> animation =
                                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                              CurvedAnimation(
                                                parent: animationController!,
                                                curve: Interval(
                                                    (1 / animationCount) * animationIndex,
                                                    // 可视区域内执行动画
                                                    1.0,
                                                    curve: Curves.fastOutSlowIn
                                                ),
                                              ),
                                            );
                                            animationController?.forward();
                                            return MessageListItem(
                                              listData: messageListData[index],
                                              animation: animation,
                                              animationController: animationController,
                                              callBack: () {},
                                            );
                                          }, childCount: messageListData.length,),
                                        ),
                                      )
                                    ]
                                );
                              }
                          )
                      );
                    }).toList(),
                  )
              ));
        }),
    );
  }
}