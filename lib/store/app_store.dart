import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

// 全局实例化，必须在此处实例化
final AppStore appStore = AppStore();

abstract class AppStoreBase with Store {
  @observable
  bool showList = false; // 主页列表展现形式

  @observable
  int activeBottomTabIndex = 0; // 底部菜单选中下标

  @computed
  String get listName => '当前状态：$showList';

  @computed
  bool get showDraw => activeBottomTabIndex == 0;

  @action
  void changeShowList() {
    showList = !showList;
  }

  @action
  void changeBottomTabIndex(int index) {
    activeBottomTabIndex = index;
  }
}