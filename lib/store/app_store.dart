import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

// 全局实例化，必须在此处实例化
final AppStore appStore = AppStore();

abstract class AppStoreBase with Store {
  @observable
  bool showList = false;

  @computed
  String get listName => '当前状态：$showList';

  @action
  void changeShowList() {
    showList = !showList;
  }
}