import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/UserContainer.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.title});
  final String title;
  @override
  State<UserPage> createState() => TemplatePageState();
}

// 小部件状态
class TemplatePageState extends State<UserPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 是一个类似fixed的容器，用来实现导航栏、悬浮、侧边栏等
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        toolbarHeight: -(MediaQuery.of(context).padding.top),
        backgroundColor: const Color(0xFF181818),
      ),
      body: const UserContainer()
    );
  }
}