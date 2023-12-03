import 'package:flutter/material.dart';
import 'package:cc_clip_app/model/TemplateListData.dart';
import 'package:cc_clip_app/model/BannerListData.dart';
import 'package:cc_clip_app/component/ListItem/TemplateListItem.dart';
import 'package:card_swiper/card_swiper.dart';

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
                  const Text("  热门模板 ",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Expanded(
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
                                    borderRadius: BorderRadius.circular(14),
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
            const Text("  模板列表 ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
          ],
        ),
      ),
      Expanded(
        child:
        GridView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 120),
          physics: const AlwaysScrollableScrollPhysics(),
          // 滚动效果
          scrollDirection: Axis.vertical,
          // 方向
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 80 / 120,
            crossAxisCount: 2,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 5.0,
          ),
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
                return TemplateListItem(
                  animation: animation,
                  animationController: animationController,
                  listData: templateListData[index],
                  callBack: () {},
                );
              },
            )
          ],
        ),
      ),
    ]);
  }
}
