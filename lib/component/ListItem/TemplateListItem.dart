import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/TemplateListData.dart';

class TemplateListItem extends StatelessWidget {
  const TemplateListItem({
    super.key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation
  });

  final TemplateListData? listData;
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
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
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
                          listData!.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 28,
                            padding: const EdgeInsets.fromLTRB(6, 0, 4, 0),
                            color: Colors.grey[800]!.withOpacity(0.7),
                            child: Row(
                              children: [
                                Text(listData!.title, style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[100],
                                ),)
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            height: 24,
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            color: Colors.grey[800]!.withOpacity(0.6),
                            child: Row(
                              children: [
                                Text(listData!.time, style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[300]
                                ),),
                                const Expanded(child: SizedBox()),
                                Text(listData!.author, style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400]
                                ),),
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
          ),
        );
      },
    );
  }
}
