import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/TemplateList.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key, required this.title});
  final String title;
  @override
  State<TemplatePage> createState() => TemplatePageState();
}

// 小部件状态
class TemplatePageState extends State<TemplatePage> {

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
                  highlightColor: Colors.white.withOpacity(1),
                  color: Colors.white,
                  icon: const Icon(Icons.question_answer),
                  onPressed: () => {},
                )
              ],
            ),
          )
        ],
        toolbarHeight: 35,
        backgroundColor: const Color(0xFF181818),
        titleTextStyle: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      body: const TemplateList()
    );
  }
}