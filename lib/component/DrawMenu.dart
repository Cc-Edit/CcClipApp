import 'package:flutter/material.dart';

// 侧边栏小组件
class DrawMenu extends StatefulWidget {
  const DrawMenu({
    super.key,
  });

  @override
  DrawMenuState createState() => DrawMenuState();
}

class DrawMenuState extends State<DrawMenu> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(10,10,10,0),
            decoration: BoxDecoration(
                gradient:  const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xffdbc0a8),
                    Color(0xffa7876d),
                    Color(0xff886a52),
                    Color(0xff6e523c),
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: Color(0xff93918f),
                    width: 1
                )
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          color: const Color(0xfff1e7eb),
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                              color: const Color(0xfff1e7eb),
                              width: 1
                          )
                      ),
                      child: Image.asset('assets/image/head.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(child: Container(
                        padding: const EdgeInsets.fromLTRB(14, 10, 0, 4),
                        alignment: Alignment.topLeft,
                        child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Cc-Edit",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              Padding(padding: const EdgeInsets.fromLTRB(0, 6, 0, 0), child: Text("V1 会员用户", style: TextStyle(
                                  fontSize: 12,
                                color: Colors.grey[300]
                              ),))
                            ],
                          )
                      )
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      transform: Matrix4.translationValues(10, -10, 0),
                      child: IconButton(
                        color: Colors.grey[100],
                        icon: const Icon(Icons.logout),
                        tooltip: '退出登录',
                        onPressed: () {},
                      )
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: Text('会员到期时间：2024-12-12', style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w400
                      ))),
                      Container(
                          width: 32,
                          height: 32,
                          transform: Matrix4.translationValues(10, 5, 0),
                          child: IconButton(
                            iconSize: 20,
                            color: Colors.grey[100],
                            icon: const Icon(Icons.more_horiz),
                            tooltip: '更多信息',
                            onPressed: () {},
                          )
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      )
    );
  }
}