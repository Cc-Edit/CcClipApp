import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/UserCart.dart';

// 侧边栏小组件
class DrawMenu extends StatefulWidget {
  const DrawMenu({
    super.key,
  });

  @override
  DrawMenuState createState() => DrawMenuState();
}

class DrawMenuState extends State<DrawMenu> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Column(
        children: [
          UserCart(),
        ],
      )
    );
  }
}