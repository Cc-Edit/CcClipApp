import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cc_clip_app/model/MessageListData.dart';
import 'package:cc_clip_app/component/ListItem/MessageListItem.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => MessageListState();
}
// TickerProviderStateMixin 用来实现动画
class MessageListState extends State<MessageList> with TickerProviderStateMixin {

  List<MessageListData> messageListData = MessageListData.messageList;
  AnimationController? animationController; // 动画管理

  static const List<Tab> myTabs = <Tab>[
    Tab(text: '官方'),
    Tab(text: '评论'),
    Tab(text: '粉丝'),
    Tab(text: '点赞'),
  ];

  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );
    super.initState();
  }

  void getData(int index) {
    // await Future<dynamic>.delayed(const Duration(milliseconds: 600));

    setState(() {
      messageListData = (index == 0 ? MessageListData.messageList : MessageListData.emptyList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            getData(tabController.index);
          }
        });
        return Column(
          children: [
            TabBar(
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
              tabs: myTabs,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children:  [
                    ...List.generate(myTabs.length, (index) {
                      if(index == 0){
                        return ListView(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            children: <Widget>[
                              ...List.generate(messageListData.length, (index) {
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
                              }),
                              const SizedBox(
                                height: 80,
                              )
                            ]
                        );
                      }else{
                        return  const Center(child: Text('暂时没有更多消息'));
                      }
                    }),
                  ],
                ),
              ),
            )
          ]
        );
      }),
    );
  }
}