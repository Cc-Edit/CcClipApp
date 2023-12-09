import 'package:http/http.dart' as http;
import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/api/ApiBase.dart';

Future<CustomResponse> getCaptcha (width, height) async {
  var url = Uri.https(AppConstant.serviceName, '${AppConstant.apiPath}/auth/captcha', {
    "w": '$width',
    "h": '$height'
  });
  var response = await http.get(url);
  return ApiBase.formatResponse(response);
}