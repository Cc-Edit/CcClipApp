import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/MenuIconData.dart';
import 'package:cc_clip_app/component/ListItem/UserMenuListItem.dart';

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
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                      color: Color(0xff181818),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                  ),
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
      Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 15, top: 2), child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('9', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[100]
                  ),),
                  Padding(padding: EdgeInsets.only(left: 6), child: Text('获赞', style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[100]
                  ),),),
                ],
              ),),
              Padding(padding: EdgeInsets.only(left: 20, top: 2), child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('29', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[100]
                  ),),
                  Padding(padding: EdgeInsets.only(left: 6), child: Text('朋友', style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[100]
                  ),),),
                ],
              ),),
              Padding(padding: EdgeInsets.only(left: 20, top: 2), child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('1098', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[100]
                  ),),
                  Padding(padding: EdgeInsets.only(left: 6), child: Text('关注', style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[100]
                  ),),),
                ],
              ),),
              Padding(padding: EdgeInsets.only(left: 20, top: 2), child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('7998', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[100]
                  ),),
                  Padding(padding: EdgeInsets.only(left: 6), child: Text('粉丝', style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[100]
                  ),),),
                ],
              ),)
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: ListView(
                scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    children: <Widget>[
                      ...List.generate(MenuIconData.userMenu.length, (index) {
                        final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController!,
                            curve: Interval(
                                (1 / MenuIconData.userMenu.length) * index,
                                // 可视区域内执行动画
                                1.0,
                                curve: Curves.fastOutSlowIn
                            ),
                          ),
                        );
                        animationController?.forward();
                        return UserMenuListItem(
                          listData: MenuIconData.userMenu[index],
                          animation: animation,
                          animationController: animationController,
                          callBack: () {},
                        );
                      }),
                      const SizedBox(
                        height: 80,
                      )
                    ]
                )
            ),
          Container(color: Colors.yellow, height: 20, width: MediaQuery.of(context).size.width,)
        ],
      )

    ]);
  }
}
