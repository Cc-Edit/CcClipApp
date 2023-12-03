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
      cover: 'assets/image/cover3.png',
      id: '1',
      title: '草稿0001',
      size: 13000,
      time: 54000,
    ),
    VideoListData(
      cover: 'assets/image/cover1.png',
      id: '1',
      title: '草稿0001',
      size: 14000,
      time: 24000,
    ),
    VideoListData(
      cover: 'assets/image/cover4.png',
      id: '1',
      title: '草稿0001',
      size: 12000,
      time: 14000,
    ),
    VideoListData(
      cover: 'assets/image/cover2.png',
      id: '1',
      title: '草稿0001',
      size: 19000,
      time: 34000,
    ),
    VideoListData(
      cover: 'assets/image/cover5.png',
      id: '1',
      title: '草稿0001',
      size: 1000,
      time: 39000,
    ),
    VideoListData(
      cover: 'assets/image/cover6.png',
      id: '1',
      title: '草稿0001',
      size: 12000,
      time: 14000,
    ),
    VideoListData(
      cover: 'assets/image/cover7.png',
      id: '1',
      title: '草稿0001',
      size: 19000,
      time: 34000,
    ),
    VideoListData(
      cover: 'assets/image/cover8.png',
      id: '1',
      title: '草稿0001',
      size: 1000,
      time: 39000,
    ),
    VideoListData(
      cover: 'assets/image/cover1.png',
      id: '1',
      title: '草稿0001',
      size: 1000,
      time: 39000,
    ),
    VideoListData(
      cover: 'assets/image/cover2.png',
      id: '1',
      title: '草稿0001',
      size: 1000,
      time: 39000,
    ),
    VideoListData(
      cover: 'assets/image/cover3.png',
      id: '1',
      title: '草稿0001',
      size: 1000,
      time: 39000,
    ),
    VideoListData(
      cover: 'assets/image/cover4.png',
      id: '1',
      title: '草稿0001',
      size: 1000,
      time: 39000,
    ),
  ];
}