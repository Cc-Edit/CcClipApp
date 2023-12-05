import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/MessageList.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.title});
  final String title;
  @override
  State<MessagePage> createState() => MessagePageState();
}

// 小部件状态
class MessagePageState extends State<MessagePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 是一个类似fixed的容器，用来实现导航栏、悬浮、侧边栏等
    return const MessageList();
  }
}