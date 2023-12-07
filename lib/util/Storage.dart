import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cc_clip_app/config/Config.dart';

class Storage {
  // 存储实例
  static final _instance = Storage._init();
  bool isInitDefault = false;
  // 工厂实例
  factory Storage() => _instance;

  // 存储实例
  static late SharedPreferences _storage;

  // 存储初始化
  _initDefault() async {
    if(isInitDefault || _storage.getKeys().isNotEmpty) return;
    isInitDefault = true;
    for (var key in StoreKeys.defaultValue.keys) {
      await setStorage(key, StoreKeys.defaultValue[key], needInit: false);
    }
    _storage.setBool(StoreKeys.isInitDefault, true);
  }

  // 初始化全局SharedPreferences
  _initShared() async {
    try {
      _storage ??= await SharedPreferences.getInstance();
    }catch (e) {
      _storage = await SharedPreferences.getInstance();
    }
    await _initDefault();
  }

  Storage._init() {
    _initShared();
  }

  // 设置存储
  setStorage(String key, dynamic value, { bool needInit = true }) async {
    // 初始化，避免堆栈溢出
    if(needInit) {
      await _initShared();
    }
    String type = value.runtimeType.toString();
    // 根据value不同的类型 用不同的方法进行存储
    switch (type) {
      case 'String':
        _storage.setString(key, value);
        break;
      case 'int':
        _storage.setInt(key, value);
        break;
      case 'double':
        _storage.setDouble(key, value);
        break;
      case 'bool':
        _storage.setBool(key, value);
        break;
    }
  }

  // 获取存储 注意：返回的是一个Future对象 要么用await接收 要么在.then中接收
  Future<dynamic> getStorage(String key) async {
    await _initShared();
    var value = _storage.get(key);
    // 获取key对应的value
    return value ?? StoreKeys.defaultValue[key];
  }

  // 是否包含某个key
  Future<bool> hasKey(String key) async {
    await _initShared();
    return _storage.containsKey(key);
  }

  // 删除key指向的存储 如果key存在则删除并返回true，否则返回false
  Future<bool> removeStorage(String key) async {
    await _initShared();
    if (await hasKey(key)) {
      await _storage.remove(key);
      return true;
    } else {
      return false;
    }
  }

  // 清空存储 并总是返回true
  Future<bool> clear() async {
    await _initShared();
    _storage.clear();
    return true;
  }

  // 获取所有的key 类型为Set<String>
  Future<Set<String>> getKeys() async {
    await _initShared();
    return _storage.getKeys();
  }
}