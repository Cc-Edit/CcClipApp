import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cc_clip_app/model/VideoListData.dart';
import 'package:cc_clip_app/model/BannerListData.dart';
import 'package:cc_clip_app/component/ListItem/VideoListItem.dart';
import 'package:cc_clip_app/store/app_store.dart';
import 'package:card_swiper/card_swiper.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => VideoListState();
}

// TickerProviderStateMixin 用来实现动画
class VideoListState extends State<VideoList> with TickerProviderStateMixin {
  List<VideoListData> videoListData = VideoListData.videoList;
  List<BannerListData> homeBanner = BannerListData.homeBanner;
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
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 200,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.pink[400]),
                  const Text("  热门活动 ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Expanded(
              child: FadeTransition(
                  opacity: animationController!,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: Colors.grey[800] as Color)),
                      child: Swiper(
                        itemCount: homeBanner.length,
                        autoplay: true,
                        autoplayDelay: 5000,
                        duration: 800,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                width: MediaQuery.of(context).size.width -
                                    20,
                                child: Image.asset(
                                  homeBanner[index].cover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  const Expanded(child: SizedBox()),
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        20,
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 2, 0, 2),
                                    color: Colors.grey[800]!
                                        .withOpacity(0.6),
                                    child: Text(
                                      homeBanner[index].title,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[200],
                                          letterSpacing: 1),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                          // return Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,);
                        },
                        pagination: SwiperPagination(
                            alignment: Alignment.topRight,
                            builder: DotSwiperPaginationBuilder(
                                activeColor: Colors.pink[400] as Color,
                                color: Colors.grey[800]!.withOpacity(0.2),
                                activeSize: 8,
                                size: 6)),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Icon(Icons.movie_filter, color: Colors.pink[400]),
            const Text("  我的剪辑 ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
          ],
        ),
      ),
      Expanded(
        child: Observer(
            builder: (_) => GridView(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 120),
                  physics: const AlwaysScrollableScrollPhysics(),
                  // 滚动效果
                  scrollDirection: Axis.vertical,
                  // 方向
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
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
                )),
      ),
    ]);
  }
}
