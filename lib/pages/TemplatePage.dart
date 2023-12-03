import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cc_clip_app/component/TemplateList.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key, required this.title});
  final String title;
  @override
  State<TemplatePage> createState() => TemplatePageState();
}

// 小部件状态
class TemplatePageState extends State<TemplatePage> with TickerProviderStateMixin {
  AnimationController? maskAnimationController;
  late TextEditingController textController;
  late FocusNode searchButton;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    searchButton = FocusNode(debugLabel: 'searchButton');
    searchButton.addListener(_handleFocusChange);
    textController = TextEditingController();
    // mask 动画
    maskAnimationController = AnimationController(vsync: this);
  }

  void _handleFocusChange() {
    if (searchButton.hasFocus != _focused) {
      maskAnimationController?.animateTo(searchButton.hasFocus ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn);
      if (searchButton.hasFocus) {
        setState(() {
          _focused = searchButton.hasFocus;
        });
      }else{
        // 等待蒙层东海
        Future.delayed(const Duration(milliseconds: 600), () {
          setState(() {
            _focused = searchButton.hasFocus;
          });
        });
      }
    }
  }

  @override
  void dispose() {
    // The attachment will automatically be detached in dispose().
    searchButton.dispose();
    maskAnimationController!.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 是一个类似fixed的容器，用来实现导航栏、悬浮、侧边栏等
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[900],
            height: 1.0,
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width - 30,
          child: Column(
            children: [
              CupertinoSearchTextField(
                focusNode: searchButton,
                autocorrect: false,
                decoration: BoxDecoration(
                    gradient:  const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xFF333030),
                        Color(0x563A3733),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.grey[600] as Color,
                        width: 1
                    )
                ),
                itemColor: Colors.grey[300] as Color,
                itemSize: 18,
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                placeholderStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[400]
                ),
                prefixInsets: const EdgeInsets.all(8),
                controller: textController,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[100]
                ),
                placeholder: '可使用关键词、场景、任务、主题搜索模板~',
              )
            ],
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color(0xFF181818),
      ),
      body: Stack(
        children: [
          const TemplateList(),
          if(_focused)
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: AnimatedBuilder(
                animation: maskAnimationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                      opacity: maskAnimationController!,
                      child: Container(
                        color: Colors.black.withOpacity(0.4)
                      )
                  );
                }),
              onTap: () {
                searchButton.unfocus();
              },
            )
        ],
      )

    );
  }
}