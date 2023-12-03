import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/MenuIconData.dart';

class UserMenuListItem extends StatelessWidget {
  const UserMenuListItem({
    super.key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation
  });

  final MenuIconData? listData;
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
            transform: Matrix4.translationValues(50 * (1.0 - animation!.value), 0.0, 0.0),
            child: Container(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 180,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey[800]!.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Icon(listData!.icon, color: Colors.grey[200], size: 28,),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listData!.title, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[200]
                        ),),
                        Text(listData!.tooltip, style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400]
                        ),),
                      ],
                    ))
                  ],
                ),
              ),
            )
          ),
        );
      },
    );
  }
}
