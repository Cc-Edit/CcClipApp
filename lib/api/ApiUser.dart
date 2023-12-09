import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/api/ApiBase.dart';


Future<CustomResponse> getUserInfo ([String? uuid = '']) async {
  var jsonData = json.encode({uuid: uuid});
  var url = Uri.https(AppConstant.serviceName, '${AppConstant.apiPath}/user/findByUuid');
  var response = await http.post(url, body: jsonData, headers: await ApiBase.getBaseHeader());
  return ApiBase.formatResponse(response);
}