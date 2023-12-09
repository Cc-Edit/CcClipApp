import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/MenuIconData.dart';
import 'package:cc_clip_app/component/ListItem/UserMenuListItem.dart';
import 'package:cc_clip_app/model/VideoListData.dart';

import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/util/UserStorage.dart';
import 'ListItem/VideoListItem.dart';

class UserContainer extends StatefulWidget {
  const UserContainer({super.key});

  @override
  State<UserContainer> createState() => UserContainerState();
}

// TickerProviderStateMixin 用来实现动画
class UserContainerState extends State<UserContainer>
    with TickerProviderStateMixin {
  AnimationController? animationController; // 动画管理
  List<VideoListData> listData = VideoListData.emptyList;

  static const List<Tab> homeTabs = <Tab>[
    Tab(text: '作品'),
    Tab(text: '私密'),
    Tab(text: '收藏'),
    Tab(text: '被@'),
    Tab(text: '喜欢')
  ];
  String userUuid = '';
  bool isInit = false;

  // 获取用户信息
  Future<void> initUserInfo() async {
    String? uuid= await UserStorage().getStorage(StoreKeys.userUuid);
    setState(() {
      userUuid = uuid ?? '';
    });
    getData(0);
    setState(() {
      isInit = true;
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initUserInfo();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  void getData(int index) {
    // await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    setState(() {
      listData =
          ((index == 0 && userUuid.isNotEmpty) ? VideoListData.videoList : VideoListData.emptyList);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!isInit) return const SizedBox();
    return DefaultTabController(
        length: homeTabs.length,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              getData(tabController.index);
            }
          });
          return Column(children: [
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Image.asset('assets/image/bg1.png', fit: BoxFit.cover),
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  padding: const EdgeInsets.all(0),
                ),
                if(userUuid.isEmpty)
                  Container(
                    padding: const EdgeInsets.fromLTRB(100, 60, 100, 0),
                    child:  Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              color: const Color(0xfff1e7eb),
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                  color: const Color(0xfff1e7eb),
                                  width: 1
                              )
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onTap: () => {
                              Navigator.of(context).pushReplacementNamed('/LoginPage')
                            },
                            child: Image.asset('assets/image/icons8-user.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 20, right: 20)),
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[800]?.withOpacity(0.5)),
                            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[100] as Color),
                            side: MaterialStateProperty.resolveWith((states) => BorderSide(width: 1, color: Colors.grey[500]!.withOpacity(0.5))),
                          ),
                          onPressed: () => Navigator.of(context).pushReplacementNamed('/LoginPage'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Icon(Icons.login_outlined, size: 20,),
                              ),
                              const Text('立即登录', style: TextStyle(
                                fontSize: 17,
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                if(userUuid.isNotEmpty)
                  Container(
                    height: 250,
                    padding: const EdgeInsets.only(top: 75, bottom: 0),
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: const Color(0xfff1e7eb),
                                    borderRadius: BorderRadius.circular(60),
                                    border: Border.all(
                                        color: const Color(0xfff1e7eb),
                                        width: 1)),
                                child: Image.asset(
                                  'assets/image/head1.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 40, 0, 4),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text("Cc-Edit",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.verified,
                                              size: 20,
                                              color: Colors.green[500],
                                            )
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Text(
                                              "V1 会员用户 | 用户ID：100002",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[300]),
                                            )),
                                      ],
                                    )))
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
                              Icon(
                                Icons.sentiment_very_satisfied,
                                size: 20,
                                color: Colors.grey[100],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '添加个人简介，让更多人认识你',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[100]),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
            if(userUuid.isEmpty)
              Center(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 60)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset('assets/image/arabica-summer-time.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Text('还没有登录，登录后查看更多数据~', style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500]
                    ),)
                  ],
                ),
              ),
            if(userUuid.isNotEmpty)
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '9',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(
                              '获赞',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[100]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '29',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(
                              '朋友',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[100]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '1098',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(
                              '关注',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[100]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '7998',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(
                              '粉丝',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[100]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                        children: <Widget>[
                          ...List.generate(MenuIconData.userMenu.length,
                              (index) {
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval(
                                    (1 / MenuIconData.userMenu.length) * index,
                                    // 可视区域内执行动画
                                    1.0,
                                    curve: Curves.fastOutSlowIn),
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
                        ])),
                SizedBox(
                  height: 470,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                  children: [
                    TabBar(
                      overlayColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.grey[900]),
                      indicatorColor: Colors.pink[400],
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.normal),
                      dividerColor: Colors.grey[900],
                      tabs: homeTabs,
                    ),
                    Expanded(
                      child: TabBarView(
                      controller: tabController,
                      children: [
                        ...List.generate(homeTabs.length, (index) {
                          if (index == 0) {
                            if(listData.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    const Padding(padding: EdgeInsets.only(top: 60)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Image.asset('assets/image/arabica-camping.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 30)),
                                    Text('这里空空的，去丰富一下吧', style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[500]
                                    ),)
                                  ],
                                ),
                              );
                            }
                            return GridView(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 120),
                              physics: const AlwaysScrollableScrollPhysics(),
                              // 滚动效果
                              scrollDirection: Axis.vertical,
                              // 方向
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 1.5,
                              ),
                              children: [
                                ...List<Widget>.generate(
                                  listData.length,
                                      (int index) {
                                    final int count = listData.length;
                                    final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval((1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn),
                                      ),
                                    );
                                    animationController?.forward();
                                    return VideoListItem(
                                      animation: animation,
                                      rowCount: 2,
                                      animationController: animationController,
                                      listData: listData[index],
                                      callBack: () {},
                                    );
                                  },
                                )
                              ],
                            );
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  const Padding(padding: EdgeInsets.only(top: 60)),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Image.asset('assets/image/arabica-camping.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.only(top: 30)),
                                  Text('这里空空的，去丰富一下吧', style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[500]
                                  ),)
                                ],
                              ),
                            );
                          }
                        }),
                      ],
                    ))
                  ],
                )),
              ],
            )
          ]);
        }));
  }
}
