import 'package:flutter/material.dart';
import '../model/VideoListData.dart';
import 'VideoListItem.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}
// TickerProviderStateMixin 用来实现动画
class _VideoListState extends State<VideoList> with TickerProviderStateMixin {
  List<VideoListData> videoListData = VideoListData.videoList;
  AnimationController? animationController; // 动画管理
  final bool _showGrid = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
           Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: const Row(
              children: [
                Icon(Icons.movie_filter, color: Colors.amber,),
                Text("  我的剪辑",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    )
                )
              ],
            ),
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              physics: const BouncingScrollPhysics(), // 滚动效果
              scrollDirection: Axis.vertical, // 方向
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _showGrid ? 3 : 1,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.5,
              ),
              children: [
                ...List<Widget>.generate(
                  videoListData.length,
                      (int index) {
                    final int count = videoListData.length;
                    final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController!,
                        curve: Interval(
                            (1 / count) * index,
                            1.0,
                            curve: Curves.fastOutSlowIn
                        ),
                      ),
                    );
                    animationController?.forward();
                    return VideoListItem(
                      animation: animation,
                      animationController: animationController,
                      listData: videoListData[index],
                      callBack: () {},
                    );
                  },
                )
              ],
            ),
          ),
        ]
    );
  }
}