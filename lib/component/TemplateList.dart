import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/TemplateListData.dart';
import 'package:cc_clip_app/model/BannerListData.dart';
import 'package:cc_clip_app/component/ListItem/TemplateListItem.dart';
import 'package:card_swiper/card_swiper.dart';

import 'common/CustomSliverHeader.dart';

class TemplateList extends StatefulWidget {
  const TemplateList({super.key});

  @override
  State<TemplateList> createState() => _VideoListState();
}

// TickerProviderStateMixin 用来实现动画
class _VideoListState extends State<TemplateList> with TickerProviderStateMixin {
  List<TemplateListData> templateListData = TemplateListData.templateList;
  List<BannerListData> templateBanner = BannerListData.templateBanner;
  AnimationController? animationController; // 动画管理
  ScrollController? pageScrollController; // 页面滚动控制
  // 随机高度，体现瀑布流
  List<double> heightList = [ Random().nextInt(80) + 200, Random().nextInt(80) + 200, Random().nextInt(80) + 200,  Random().nextInt(80) + 200];
  @override
  void dispose() {
    pageScrollController?.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 滑动控制
    pageScrollController = ScrollController(initialScrollOffset: 0);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: pageScrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 40,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            Icon(Icons.local_fire_department, color: Colors.pink[400]),
                            const Text("  热门模板 ",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 160,
                        child: FadeTransition(
                            opacity: animationController!,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[800] as Color
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Swiper(
                                    itemCount: templateBanner.length,
                                    autoplay: true,
                                    autoplayDelay: 5000,
                                    duration: 800,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            width: MediaQuery.of(context).size.width -
                                                20,
                                            child: Image.asset(
                                              templateBanner[index].cover,
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
                                                  templateBanner[index].title,
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
                              ),
                            )),
                      )
                    ],
                  );
                }, childCount: 1),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: CustomSliverHeader(
              Container(
                height: 40,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: const Color(0xFF181818),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.pink[400]),
                    const Text('  精选模板 ',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child:
        ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex:1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...List<Widget>.generate(
                          templateListData.length,
                              (int index) {
                            final int count = templateListData.length;
                            final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController?.forward();
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(1, 2, 1, 2),
                              child: TemplateListItem(
                                height: heightList[index%3],
                                animation: animation,
                                animationController: animationController,
                                listData: templateListData[index],
                                callBack: () {},
                              ),
                            );
                          },
                        )
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...List<Widget>.generate(
                          templateListData.length,
                              (int index) {
                            final int count = templateListData.length;
                            final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController?.forward();
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(1, 2, 1, 2),
                              child: TemplateListItem(
                                height: heightList[index%3 + 1],
                                animation: animation,
                                animationController: animationController,
                                listData: templateListData[index],
                                callBack: () {},
                              ),
                            );
                          },
                        )
                      ],
                    )
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(20), child:   Center(
              child: Text('已经到底啦~', style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800]
              ),),
            ),)
          ],
        ),
      ),
    );
  }
}