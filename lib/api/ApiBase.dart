import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cc_clip_app/util/UserStorage.dart';
import 'package:cc_clip_app/config/Config.dart';

class CustomResponse {
  CustomResponse({
    required this.success,
    required this.hasError,
    required this.msg,
    required this.data,
    required this.httpResp,
  });
  bool success; // 请求是否成功
  bool hasError; // 是否有错误
  String msg; // 错误信息
  Map<String, dynamic> data; // 返回数据
  http.Response httpResp; // 请求实例
}

class ApiBase {
  static String serviceName = 'cccs.ccedit.com';
  static String apiPath = 'api';

  static CustomResponse formatResponse(http.Response response, [autoDialog = true]) {
    bool success;
    bool hasError;
    String msg = '';
    Map<String, dynamic> data = {};
    try{
      success = true;
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if(decodedResponse['code'] == 200 && decodedResponse['isOk']){
        hasError = false;
        data = decodedResponse['data'];
        data??={};
      }else if(decodedResponse['code'] == 400){
        hasError = true;
        String error = decodedResponse['error'][0];
        msg = error.isNotEmpty ? error : "参数错误";
      }else if(decodedResponse['code'] == 500){
        hasError = true;
        msg??="服务器异常";
      }else{
        hasError = true;
        msg = decodedResponse['msg'];
        msg??="接口数据解析错误";
      }
    }catch(e){
      success = false;
      hasError = true;
      msg = "请求失败，请检查网络";
    }
    CustomResponse resp = CustomResponse(success: success, msg: msg, data: data, httpResp: response, hasError: hasError);
    if(autoDialog && resp.hasError || !resp.success){
      Fluttertoast.showToast(
          msg: resp.msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 15.0
      );
    }
    return resp;
  }

  static Future<Map<String, String>> getBaseHeader() async {
    String? token = await UserStorage().getStorage(StoreKeys.accessToken);
    return {
      "Content-Type": "application/json",
      "t": token ?? ''
    };
  }
}
