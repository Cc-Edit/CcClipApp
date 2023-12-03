class TemplateListData {
  TemplateListData({
    this.id = '',
    this.cover = '',
    this.title = '',
    this.author = '',
    this.time = '',
  });

  String cover;
  String title;
  String id;
  String author;
  String time;

  static List<TemplateListData> templateList = [
    TemplateListData(
      cover: 'assets/image/cover1.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
    TemplateListData(
      cover: 'assets/image/cover2.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
    TemplateListData(
      cover: 'assets/image/cover3.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
    TemplateListData(
      cover: 'assets/image/cover4.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
    TemplateListData(
      cover: 'assets/image/cover5.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
    TemplateListData(
      cover: 'assets/image/cover6.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
    TemplateListData(
      cover: 'assets/image/cover7.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
    TemplateListData(
      cover: 'assets/image/cover8.png',
      id: '1',
      title: '草稿',
      time: '2023-12-09',
      author: 'assets/image/head1.png',
    ),
  ];
}