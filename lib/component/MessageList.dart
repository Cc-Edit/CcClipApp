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

  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
           Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Row(
              children: [
                Icon(Icons.movie_filter, color: Colors.pink[400]),
                const Text("  我的剪辑 ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    )
                )
              ],
            ),
          ),
          Expanded(
            child: GridView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                physics: const AlwaysScrollableScrollPhysics(), // 滚动效果
                scrollDirection: Axis.vertical, // 方向
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1.5,
                ),
                children: [
                  ...List<Widget>.generate(
                    messageListData.length,
                        (int index) {
                      final int count = messageListData.length;
                      final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval(
                              (1 / count) * index,
                              1.0,
                              curve: Curves.fastOutSlowIn
                          ),
                        ),
                      );
                      animationController?.forward();
                      return MessageListItem(
                        animation: animation,
                        animationController: animationController,
                        listData: messageListData[index],
                        callBack: () {},
                      );
                    },
                  )
                ],
              )
            ),
        ]
    );
  }
}