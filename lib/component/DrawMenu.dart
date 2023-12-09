import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/UserCard.dart';
import 'package:cc_clip_app/component/IconCard.dart';
import 'package:cc_clip_app/model/MenuIconData.dart';
import 'package:cc_clip_app/util/Storage.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UserCard(),
          IconCard(
              title: "常用功能",
              menuList: MenuIconData.menuList
          ),
          IconCard(
              title: "基础功能",
              menuList: MenuIconData.baseMenu
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: OutlinedButton(
              onPressed: () {
                Storage().clear();
              },
              child: Center(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                      child: const Icon(Icons.delete, size: 20,),
                    ),
                    const Text('清除存储', style: TextStyle(
                      fontSize: 14,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}