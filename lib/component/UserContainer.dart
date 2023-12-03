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
    return Column(children: [
      Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 245,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/image/bg1.png', fit: BoxFit.cover),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: MediaQuery.of(context).size.width,
            height: 250,
            padding: const EdgeInsets.all(0),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.only(top: 75, bottom: 0),
            child: Column(
              children: [
                Expanded(child: Row(
                  children: [
                    Padding(padding: const EdgeInsets.all(20), child: Container(
                      width: 100,
                      height: 100,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          color: const Color(0xfff1e7eb),
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                              color: const Color(0xfff1e7eb),
                              width: 1
                          )
                      ),
                      child: Image.asset('assets/image/head1.png',
                        fit: BoxFit.contain,
                      ),
                    ),),
                    Expanded(child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 40, 0, 4),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Cc-Edit",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                const SizedBox(width: 10,),
                                Icon(Icons.verified, size: 20, color: Colors.green[500],)
                              ],
                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0), child: Text("V1 会员用户 | 用户ID：100002", style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[300]
                            ),)),
                          ],
                        ))
                    )
                  ],
                )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 29,
                  color: Colors.black.withOpacity(0.4),
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.sentiment_very_satisfied, size: 20, color: Colors.grey[100],),
                      const SizedBox(width: 8,),
                      Text('添加个人简介，让更多人认识你', style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[100]
                      ),)
                    ],
                  ),
                )
              ],
            )

          )
        ],
      ),
      Text('123')
    ]);
  }
}
