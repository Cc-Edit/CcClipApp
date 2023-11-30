import 'package:flutter/material.dart';

// 定义一个 MyHomePage 部件，它是一个有状态的部件(StatefulWidget)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// 小部件状态
class _MyHomePageState extends State<MyHomePage> {
  var _showList = false;
  int _counter = 0;

  void _addCounter() {
    // 类似react 的setState，传递更新函数
    // 每次setState都会重新执行 build
    setState(() {
      _counter++;
    });
  }

  void _switchShowList() {
    setState(() {
      _showList = !_showList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 是一个类似fixed的容器，用来实现导航栏、悬浮、侧边栏等
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu), // 左侧icon
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  highlightColor: Colors.black.withOpacity(0.05),
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
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        titleTextStyle: const TextStyle(
            fontSize: 21,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.black87
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '按钮点击次数:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              '展示:',
            ),
            Text(
              _showList ? '列表' : '卡片',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCounter, // 点击处理函数
        tooltip: '自增',
        child: const Icon(Icons.add),
      ), // 浮动按钮
    );
  }
}