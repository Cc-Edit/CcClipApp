import 'dart:math';
import 'dart:ui';

import 'package:cc_clip_app/model/FormData.dart';
import 'package:flutter/material.dart';

class FormGenerate extends StatefulWidget {
  FormGenerate({
    super.key,
    required this.formData,
    this.padding = const EdgeInsets.only(left: 30, right: 30)
  });
  final List<FormData> formData;
  EdgeInsetsGeometry? padding;

  @override
  State<StatefulWidget> createState()  => FormGenerateState();
}
class FormGenerateState extends State<FormGenerate> with TickerProviderStateMixin {
  late Map<String, FocusNode> formItemNodeMap = {};
  late AnimationController? scrollAnimationController; // 聚焦时居中元素
  late Animation<double> scrollAnim; // 聚焦时居中元素
  late Tween<double> scrollTween; // 居中要做的位移距离
  double middleHeight = 400;
  EdgeInsets? paddingObj;

  @override
  void initState() {
    FlutterView view = PlatformDispatcher.instance.views.first;
    double physicalHeight = view.physicalSize.height;
    double devicePixelRatio = view.devicePixelRatio;
    setState(() {
      middleHeight = physicalHeight / devicePixelRatio / 2 - 80;
    });
    super.initState();
    _initNodeMap();
    paddingObj = widget.padding?.resolve(TextDirection.ltr);
    scrollAnimationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    scrollTween = Tween<double>(begin: 0, end: 0);
    scrollAnim = scrollTween.animate(CurvedAnimation(
        parent: scrollAnimationController!,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn))
    )..addListener(() {
      setState(() {}); // 当动画区间发生变化，重新build
    });
  }

  @override
  void dispose() {
    // The attachment will automatically be detached in dispose().
    Iterable<FocusNode> nodeList = formItemNodeMap.values;
    for(FocusNode formItemNode in nodeList){
      formItemNode.dispose();
    }
    scrollAnimationController!.dispose();
    super.dispose();
  }

  // 初始化节点关联
  void _initNodeMap() {
    for(FormData formItem in widget.formData){
      FocusNode elementNode = FocusNode(debugLabel: formItem.key);
      elementNode.addListener(() => _handleFocusChange(elementNode) );
      formItemNodeMap[formItem.key] = elementNode;
    }
  }

  // 焦点元素变化回调, 使元素出现在视口内
  void _handleFocusChange(FocusNode elementNode) {
    double diffHeight = 0;
    if(elementNode.hasFocus){
      diffHeight = elementNode.offset.dy - middleHeight;
    }else{
      diffHeight = 0;
    }
    double newDiffHeight = max(0, diffHeight);

    if(scrollTween.end == newDiffHeight) return;

    if(scrollAnimationController?.status == AnimationStatus.forward){
      scrollTween.begin = scrollAnim.value; // 正在进行中，取当前动画位置
    }else{
      scrollTween.begin = scrollTween.end; // 上次动画的结尾是新的开始
    }
    scrollAnimationController!.reset(); // 重置controller
    scrollTween.end = newDiffHeight; // 设置新的位置
    scrollAnimationController!.forward(); // 再次执行
  }

  // 获取表单结构
  List<Widget> genFormItem(double width) {
    List<Widget> result = [];
    if(formItemNodeMap.isEmpty) return result;
    for(FormData formItem in widget.formData){
      InputType type = formItem.type;
      if(type == InputType.string) {
        result.add(
          Container(
            key: Key(formItem.key),
            padding: const EdgeInsets.only(bottom: 10),
            width: width,
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    focusNode: formItemNodeMap[formItem.key],
                    autocorrect: false,
                    cursorColor: Colors.grey[100],
                    decoration: InputDecoration(
                      icon: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(formItem.icon, color: Colors.grey[100], size: 28,),
                      ),
                      hintText: formItem.hintText,
                      helperText: formItem.helperText,
                      errorText: formItem.errorText,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }else if(type == InputType.password) {
        result.add(
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: width,
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    focusNode: formItemNodeMap[formItem.key],
                    autocorrect: false,
                    cursorColor: Colors.grey[100],
                    obscureText: true,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[200]
                    ),
                    decoration: InputDecoration(
                        icon: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Icon(formItem.icon, color: Colors.grey[100], size: 28,),
                        ),
                        hintText: formItem.hintText,
                        helperText: formItem.helperText,
                        errorText: formItem.errorText,
                        // suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[100], size: 24,)
                        suffixIcon: Icon(Icons.visibility_outlined, color: Colors.grey[100], size: 24,)
                    ),
                  ),
                )
              ],
            ),
          )
        );
      } else if(type == InputType.piCode){
        result.add(
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              width: width,
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: formItemNodeMap[formItem.key],
                      autocorrect: false,
                      cursorHeight: 19,
                      cursorColor: Colors.grey[100],
                      obscureText: true,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[200]
                      ),
                      decoration: InputDecoration(
                          icon: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(formItem.icon, color: Colors.grey[100], size: 28,),
                          ),
                          hintText: formItem.hintText,
                          helperText: formItem.helperText,
                          errorText: formItem.errorText,
                          // suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[100], size: 24,)
                          suffixIcon: Icon(Icons.refresh, color: Colors.grey[100], size: 24,)
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    width: 110,
                    height: 46,
                    child: Image.asset('assets/image/flame-40.png', fit: BoxFit.fill,),
                  )
                ],
              ),
            )
        );
      }else if(type == InputType.button){
        result.add(
            Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                width: width,
                height: 80,
                child: Center(
                  child: OutlinedButton(
                    focusNode: formItemNodeMap[formItem.key],
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey[800] as Color),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[900] as Color),
                      foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[200] as Color),
                      side: MaterialStateProperty.resolveWith((states) => BorderSide(width: 1.0, color: Colors.grey[200] as Color)),
                    ),
                    onPressed: () {},
                    child: Center(
                        child: Text('${formItem.buttonText}', style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          color: Colors.grey[100],
                          fontWeight: FontWeight.bold
                        ))
                    ),
                  ),
                )
            )
        );
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBuilder(
        animation: scrollAnimationController!,
        builder: (BuildContext context, Widget? child) {
          return Container(
            padding: EdgeInsets.fromLTRB(paddingObj!.left,max(0, paddingObj!.top - scrollAnim.value),paddingObj!.right,paddingObj!.bottom),
            color: Colors.grey[900],
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...genFormItem(width)
                ]
            ),
          );
        }),
    );
  }
}