import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cc_clip_app/component/VideoList.dart';
import 'package:cc_clip_app/store/app_store.dart';

// 定义一个 MyHomePage 部件，它是一个有状态的部件(StatefulWidget)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// 小部件状态
class _MyHomePageState extends State<MyHomePage> {

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
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[900],
            height: 1.0,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  highlightColor: Colors.white.withOpacity(0.1),
                  color: Colors.white,
                  icon: Observer(
                    builder: (_) => (appStore.showList
                        ? const Icon(Icons.view_stream)
                        : const Icon(Icons.dashboard))
                  ),
                  onPressed: appStore.changeShowList,
                )
              ],
            ),
          )
        ],
        toolbarHeight: 45,
        backgroundColor: const Color(0xFF181818),
        titleTextStyle: const TextStyle(
            fontSize: 21,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      body: const VideoList()
    );
  }
}