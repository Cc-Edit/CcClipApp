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
  int _counter = 0;

  void _addCounter() {
    // 类似react 的setState，传递更新函数
    // 每次setState都会重新执行 build
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 是一个类似fixed的容器，用来实现导航栏、悬浮、侧边栏等
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
            fontSize: 21,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
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