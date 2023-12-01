import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/VideoList.dart';

// 定义一个 MyHomePage 部件，它是一个有状态的部件(StatefulWidget)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// 小部件状态
class _MyHomePageState extends State<MyHomePage> {
  var _showList = false; // 展示列表/ka
  var _showMenu = false; // 左侧菜单显示

  void _switchShowList() {
    setState(() {
      _showList = !_showList;
    });
  }

  void _switchShowMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 是一个类似fixed的容器，用来实现导航栏、悬浮、侧边栏等
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
            Icons.menu,
            color: Colors.white
        ), // 左侧icon
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  highlightColor: Colors.white.withOpacity(0.1),
                  color: Colors.white,
                  icon: (_showList
                      ? const Icon(Icons.view_stream)
                      : const Icon(Icons.dashboard)),
                  onPressed: _switchShowList,
                )
              ],
            ),
          )
        ],
        toolbarHeight: 45,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
            fontSize: 21,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      body: const VideoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _switchShowList, // 点击处理函数
        tooltip: '自增',
        child: const Icon(Icons.add),
      ), // 浮动按钮
    );
  }
}