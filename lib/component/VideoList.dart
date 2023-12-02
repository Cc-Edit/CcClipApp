import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cc_clip_app/model/VideoListData.dart';
import 'package:cc_clip_app/component/VideoListItem.dart';
import 'package:cc_clip_app/store/app_store.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}
// TickerProviderStateMixin 用来实现动画
class _VideoListState extends State<VideoList> with TickerProviderStateMixin {

  List<VideoListData> videoListData = VideoListData.videoList;
  AnimationController? animationController; // 动画管理

  // 监控 mobx 数据变化
  // final List<ReactionDisposer> _disposers = [];
  // Key _refreshKey = UniqueKey();
  //
  // void _handleLocaleChanged() => setState((){
  //   _refreshKey = UniqueKey();
  // });
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _disposers.add(
  //     reaction((_) => appStore.showList, (msg) =>
  //       _handleLocaleChanged()
  //     )
  //   );
  // }

  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
           Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Row(
              children: [
                Icon(Icons.movie_filter, color: Colors.pink[400]),
                const Text("  我的剪辑 ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    )
                )
              ],
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) => GridView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                physics: const BouncingScrollPhysics(), // 滚动效果
                scrollDirection: Axis.vertical, // 方向
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: appStore.showList ? 1 : 3,
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
              )
            ),
          ),
        ]
    );
  }
}