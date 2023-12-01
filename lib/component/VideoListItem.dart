import 'package:flutter/material.dart';
import '../model/VideoListData.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({
    super.key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation
  });

  final VideoListData? listData;
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
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.asset(
                          listData!.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
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
