import 'package:flutter/material.dart';

class UserContainer extends StatefulWidget {
  const UserContainer({super.key});

  @override
  State<UserContainer> createState() => UserContainerState();
}

// TickerProviderStateMixin 用来实现动画
class UserContainerState extends State<UserContainer> with TickerProviderStateMixin {
  AnimationController? animationController; // 动画管理

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Text('123')
    ]);
  }
}
