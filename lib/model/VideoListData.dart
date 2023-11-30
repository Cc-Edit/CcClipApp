class VideoListData {
  VideoListData({
    this.id = '',
    this.cover = '',
    this.title = '',
    this.size = 0,
    this.time = 0,
  });

  String cover;
  String title;
  String id;
  int size;
  int time;

  static List<VideoListData> videoList = [
    VideoListData(
      cover: 'assets/image/simplistic-play-sign.png',
      id: '1',
      title: '草稿0001',
      size: 13000,
      time: 54000,
    ),
    VideoListData(
      cover: 'assets/image/simplistic-play-sign.png',
      id: '1',
      title: '草稿0001',
      size: 14000,
      time: 24000,
    ),
    VideoListData(
      cover: 'assets/image/simplistic-play-sign.png',
      id: '1',
      title: '草稿0001',
      size: 12000,
      time: 14000,
    ),
    VideoListData(
      cover: 'assets/image/simplistic-play-sign.png',
      id: '1',
      title: '草稿0001',
      size: 19000,
      time: 34000,
    ),
    VideoListData(
      cover: 'assets/image/simplistic-play-sign.png',
      id: '1',
      title: '草稿0001',
      size: 1000,
      time: 39000,
    ),
  ];
}