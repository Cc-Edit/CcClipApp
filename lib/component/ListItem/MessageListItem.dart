import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/MessageListData.dart';

class MessageListItem extends StatelessWidget {
  const MessageListItem({
    super.key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation
  });

  final MessageListData? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child:  SizedBox(
                height: 133,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Colors.grey[900] as Color,
                            Colors.grey[800] as Color,
                          ]
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Colors.grey[700] as Color
                      )
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.asset('assets/image/3d-casual-life-line-idea-bulb.png',
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 0, right: 50, top: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(listData!.title, style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Container(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text(listData!.desc, maxLines: 3, style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            color: Colors.grey[300],
                                          )),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 5, bottom: 3),
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.resolveWith((states) => const Size(50, 30)),
                                padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.fromLTRB(20, 0, 20, 0)),
                                backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.pink[400]),
                              ),
                              child: const Row(
                                children: [
                                  Text('去使用', style: TextStyle(
                                    fontSize: 13,
                                  ),),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(Icons.arrow_forward, size: 16,),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
        );
      },
    );
  }
}
