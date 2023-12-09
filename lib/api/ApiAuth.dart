import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/api/ApiBase.dart';

class ApiAuth {
  static Future<CustomResponse> getCaptcha (width, height) async {
    var url = Uri.https(AppConstant.serviceName, '${AppConstant.apiPath}/auth/captcha', {
      "w": '$width',
      "h": '$height'
    });
    var response = await http.get(url);
    return ApiBase.formatResponse(response);
  }

  static Future<CustomResponse> logout () async {
    var url = Uri.https(AppConstant.serviceName, '${AppConstant.apiPath}/auth/logout');
    var response = await http.get(url, headers: await ApiBase.getBaseHeader());
    return ApiBase.formatResponse(response);
  }

  static Future<CustomResponse> userLogin (Map<String, dynamic> userData) async {
    var jsonData = json.encode(userData);
    var url = Uri.https(AppConstant.serviceName, '${AppConstant.apiPath}/auth/login');
    var response = await http.post(url, body: jsonData, headers: await ApiBase.getBaseHeader());
    return ApiBase.formatResponse(response);
  }
}
