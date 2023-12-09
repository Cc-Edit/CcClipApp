class AppConstant {
  static String serviceName = 'cccs.ccedit.com';
  static String apiPath = 'api';
}

// 数据存储 key
class StoreKeys {
  static String showGuide = 'showGuide';
  static String isInitDefault = 'isInitDefault';
  static String accessToken = 'access_token';
  static String userName = 'userName';
  static String userPhone = 'userPhone';
  static String userEmail = 'userEmail';
  static String userUuid = 'userUuid';
  static String userRole = 'userRole';
  static String userStatus = 'userStatus';

  // 用户角色
  static List<String> roleNameMap = ['管理员', '会员用户'];
  static List<String> userStatusMap = ['已删除', '已禁用', '正常'];

  // 默认值
  static Map<String, dynamic> defaultValue = {
    StoreKeys.showGuide: true,
  };
}
// 默认值
Map<String, dynamic> defaultValue = {
  StoreKeys.showGuide: true
};