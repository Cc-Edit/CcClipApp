import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/MenuIconData.dart';

// 按钮卡片
class IconCard extends StatefulWidget {
  const IconCard({
    super.key,
    required this.menuList, required this.title
  });
  final String title;
  final List<MenuIconData> menuList;

  @override
  IconCardState createState() => IconCardState();
}

class IconCardState extends State<IconCard> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 218,
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        decoration: BoxDecoration(
            gradient:  LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Colors.grey[800] as Color,
                Colors.grey[900] as Color,
              ],
            ),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: Colors.grey[800] as Color,
                width: 1
            )
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.amber[400],
                  height: 10,
                  width: 3,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child:
                          Text(widget.title,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                        Container(
                          width: 40,
                          height: 18,
                          padding: const EdgeInsets.all(0),
                          child: IconButton(
                            iconSize: 20,
                            padding: const EdgeInsets.all(0),
                            color: Colors.grey[100],
                            icon: const Icon(Icons.more_horiz),
                            tooltip: '更多',
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 8),
              child: Container(
                color: Colors.grey[700],
                height: 1,
                width: MediaQuery.of(context).size.width,
              )
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.only(top: 18),
                scrollDirection: Axis.vertical, // 方向
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                childAspectRatio: 60 / 65,
                mainAxisSpacing: 15,
                crossAxisSpacing: 1,
                children: List<Widget>.generate(widget.menuList.length, (index) {
                  final icon = widget.menuList[index].icon;
                  final title = widget.menuList[index].title;
                  return SizedBox(
                            width: 60,
                            height: 65,
                            child: Column(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    padding: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        gradient:  LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[
                                            Colors.grey[600] as Color,
                                            Colors.grey[900] as Color,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: Colors.grey[700] as Color,
                                            width: 1
                                        )
                                    ),
                                    child: IconButton(
                                      iconSize: 22,
                                      padding: const EdgeInsets.all(0),
                                      color: Colors.grey[300],
                                      icon: Icon(icon),
                                      tooltip: '更多信息',
                                      onPressed: () {},
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(title,
                                      style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 1,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                          );
                })
              ),
            )
            // GridView(
            //   padding: const EdgeInsets.all(0),
            //   scrollDirection: Axis.vertical, // 方向
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3,
            //     mainAxisSpacing: 15.0,
            //     crossAxisSpacing: 5.0,
            //     childAspectRatio: 1.5,
            //   ),
            //   children: [
                // ...List<Widget>.generate(
                //   widget.menuList.length,
                //   (int index) {
                //     return IconButton(
                //       iconSize: 20,
                //       padding: const EdgeInsets.all(0),
                //       color: Colors.grey[100],
                //       icon: const Icon(Icons.more_horiz),
                //       tooltip: '更多',
                //       onPressed: () {},
                //     );
                //   },
                // )
            //   ],
            // )
          ],
        ),
      )
    );
  }
}