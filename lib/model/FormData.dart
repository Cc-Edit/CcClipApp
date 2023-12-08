import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// 支持的类型
enum InputType {
  string,
  number,
  password,
  piCode,
  button,
}

class FormData {
  FormData({
    this.id = '',
    this.icon = Icons.person_outline,
    this.key = '',
    this.type = InputType.string,
    this.hintText,
    this.defaultValue,
    this.helperText,
    this.errorText,
    this.buttonText,
    this.validator,
    this.callback,
  });

  String id;
  IconData icon;
  String key;
  InputType type;
  String? hintText;
  String? defaultValue;
  String? helperText;
  String? errorText;
  String? buttonText;
  Function? callback;
  List<FieldValidator>? validator;
  List<FieldValidator> emptyList = [];

  static List<FormData> loginForm = [
    FormData(
      id: '1',
      type: InputType.string,
      icon: Icons.person_outline,
      key: 'userName',
      defaultValue: 'guest',
      hintText: '请输入用户名',
      validator: [
        RequiredValidator(errorText: '用户名不能为空'),
        MinLengthValidator(5, errorText: '用户名长度至少5位'),
        MaxLengthValidator(20, errorText: '用户名长度最多20位'),
        PatternValidator(r'^[a-zA-Z0-9_]', errorText: '用户名格式不正确')
      ]
    ),
    FormData(
      id: '2',
      type: InputType.password,
      icon: Icons.lock_outline_rounded,
      key: 'password',
      defaultValue: 'aA@123456789',
      hintText: '请输入密码',
      validator: [
        RequiredValidator(errorText: '密码不能为空'),
        MinLengthValidator(6, errorText: '密码长度至少6位'),
        MaxLengthValidator(30, errorText: '密码长度最多30位'),
        PatternValidator(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[._~!@#$^&*])[A-Za-z0-9._~!@#$^&*]{6,30}$', errorText: '密码中必须包含字母、数字和特殊字符')
      ]
    ),
    FormData(
      id: '4',
      type: InputType.piCode,
      icon: Icons.image,
      defaultValue: 'aysr',
      key: 'imageCode',
      hintText: '请输入验证码',
      validator: [
        RequiredValidator(errorText: '验证码不能为空'),
        MinLengthValidator(4, errorText: '验证码长度至少4位'),
        MaxLengthValidator(6, errorText: '验证码长度最多6位'),
        PatternValidator(r'^[a-zA-Z0-9]{4,6}$', errorText: '验证码格式不正确')
      ]
    ),
    FormData(
      id: '3',
      type: InputType.button,
      key: 'submit',
      buttonText: '登录',
      callback: (context) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        )
      }
    ),
  ];

  static List<FormData> registerForm = [];

  // 表单验证
  String? customValidator (value, [List<FieldValidator>? validators]) {
    validators ??= emptyList;
    return MultiValidator(validators)(value);
  }
}
