// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  Computed<String>? _$listNameComputed;

  @override
  String get listName => (_$listNameComputed ??=
          Computed<String>(() => super.listName, name: 'AppStoreBase.listName'))
      .value;

  late final _$showListAtom =
      Atom(name: 'AppStoreBase.showList', context: context);

  @override
  bool get showList {
    _$showListAtom.reportRead();
    return super.showList;
  }

  @override
  set showList(bool value) {
    _$showListAtom.reportWrite(value, super.showList, () {
      super.showList = value;
    });
  }

  late final _$activeBottomTabIndexAtom =
      Atom(name: 'AppStoreBase.activeBottomTabIndex', context: context);

  @override
  int get activeBottomTabIndex {
    _$activeBottomTabIndexAtom.reportRead();
    return super.activeBottomTabIndex;
  }

  @override
  set activeBottomTabIndex(int value) {
    _$activeBottomTabIndexAtom.reportWrite(value, super.activeBottomTabIndex,
        () {
      super.activeBottomTabIndex = value;
    });
  }

  late final _$AppStoreBaseActionController =
      ActionController(name: 'AppStoreBase', context: context);

  @override
  void changeShowList() {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.changeShowList');
    try {
      return super.changeShowList();
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBottomTabIndex(int index) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.changeBottomTabIndex');
    try {
      return super.changeBottomTabIndex(index);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showList: ${showList},
activeBottomTabIndex: ${activeBottomTabIndex},
listName: ${listName}
    ''';
  }
}
