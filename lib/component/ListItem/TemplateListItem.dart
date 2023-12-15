import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/TemplateListData.dart';

class TemplateListItem extends StatefulWidget {
  const TemplateListItem({
    super.key,
    this.height = 100,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation
  });
  final double height;
  final TemplateListData? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<StatefulWidget> createState() => TemplateListItemState();
}
class TemplateListItemState extends State<TemplateListItem> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation!.value), 0.0),
            child:Container(
              height: widget.height,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xFF333030),
                        Color(0x563A3733),
                      ]
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: const Color(0x5644413D)
                  )
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        widget.listData!.cover,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 28,
                          padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                          color: Colors.grey[800]!.withOpacity(0.7),
                          child: Row(
                            children: [
                              Text(widget.listData!.title, style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100],
                              ),),
                              const Expanded(child: SizedBox()),
                              SizedBox(
                                width: 30,
                                child: IconButton(
                                  iconSize: 24,
                                  padding: const EdgeInsets.all(0),
                                  color: Colors.grey[100],
                                  icon: const Icon(Icons.add),
                                  tooltip: '使用模板',
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          color: Colors.grey[800]!.withOpacity(0.6),
                          child: Row(
                            children: [
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                    child: null,
                                  ),
                                  Text(widget.listData!.flag, style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                    color: Colors.grey[300]
                                  ),),
                                  const SizedBox(
                                    height: 2,
                                    child: null,
                                  ),
                                  Row(
                                    children: [
                                      Text('使用:${widget.listData!.use.toString()}   点赞:${widget.listData!.star.toString()}', style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12,
                                          color: Colors.grey[300]
                                      ),),
                                    ],
                                  )

                                ],
                              )),
                              SizedBox(
                                width: 26,
                                child: Image.asset(
                                  widget.listData!.author,
                                  fit: BoxFit.cover,
                                ),
                              )
                              // Text(listData!.author, style: TextStyle(
                              //     fontSize: 12,
                              //     color: Colors.grey[400]
                              // ),),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}