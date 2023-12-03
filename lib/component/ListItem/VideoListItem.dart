import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/VideoListData.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cc_clip_app/store/app_store.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({
    super.key,
    this.listData,
    this.callBack,
    this.animationController,
    this.animation,
    this.rowCount = 3
  });

  final VideoListData? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int? rowCount;

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
                      Observer(
                        builder: (_) => Column(
                          children: [
                            Container(
                              height: appStore.showList ? 28 : (rowCount == 2 ? 22 : 16),
                              padding: const EdgeInsets.fromLTRB(6, 0, 4, 0),
                              color: Colors.grey[800]!.withOpacity(0.7),
                              child: Row(
                                children: [
                                  Text(listData!.title, style: TextStyle(
                                    fontSize: appStore.showList ? 14 : (rowCount == 2 ? 13 : 11),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[100],
                                  ),)
                                ],
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              height: appStore.showList ? 24 : (rowCount == 2 ? 18 : 12),
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                              color: Colors.grey[800]!.withOpacity(0.6),
                              child: Row(
                                children: [
                                  Text(listData!.time, style: TextStyle(
                                      fontSize: appStore.showList ? 12 : (rowCount == 2 ? 11 : 9),
                                      color: Colors.grey[300]
                                  ),),
                                  const Expanded(child: SizedBox()),
                                  Text(listData!.size, style: TextStyle(
                                      fontSize: appStore.showList ? 12 : (rowCount == 2 ? 11 : 9),
                                      color: Colors.grey[400]
                                  ),),
                                ],
                              ),
                            )
                          ],
                        )
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
