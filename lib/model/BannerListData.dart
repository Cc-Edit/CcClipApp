class BannerListData {
  BannerListData({
    this.id = '',
    this.cover = '',
    this.title = '',
  });

  String cover;
  String title;
  String id;

  static List<BannerListData> templateBanner = [
    BannerListData(
      cover: 'assets/banner/banner5.png',
      id: '1',
      title: 'AI智能扩图功能上线🔥',
    ),
    BannerListData(
      cover: 'assets/banner/banner6.png',
      id: '1',
      title: 'AI智能扩图功能上线🔥',
    ),
    BannerListData(
      cover: 'assets/banner/banner7.png',
      id: '1',
      title: 'AI智能扩图功能上线🔥',
    ),
    BannerListData(
      cover: 'assets/banner/banner8.png',
      id: '1',
      title: 'AI智能扩图功能上线🔥',
    ),
  ];

  static List<BannerListData> homeBanner = [
    BannerListData(
      cover: 'assets/banner/banner1.png',
      id: '1',
      title: '记录旅途风景，获得免费推荐 👍',
    ),
    BannerListData(
      cover: 'assets/banner/banner2.png',
      id: '1',
      title: '日出的光芒，如同生命的热情',
    ),
    BannerListData(
      cover: 'assets/banner/banner3.png',
      id: '1',
      title: '最具挑战性的挑战莫过于提升自我',
    ),
    BannerListData(
      cover: 'assets/banner/banner4.png',
      id: '1',
      title: '我喜欢看它那清澈的眼神和柔软的毛发',
    ),
  ];
}