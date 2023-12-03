import 'package:flutter/material.dart';

class MenuIconData {
  MenuIconData({
    this.id = '',
    this.icon = Icons.more_horiz,
    this.title = '',
    this.tooltip = '',
  });

  IconData icon;
  String title;
  String tooltip;
  String id;

  static List<MenuIconData> menuList = [
    MenuIconData(
        id: '1',
        title: '一键成片',
        tooltip: '一键成片',
        icon: Icons.smart_display
    ),
    MenuIconData(
        id: '1',
        title: '图文成片',
        tooltip: '图文成片',
        icon: Icons.perm_media
    ),
    MenuIconData(
        id: '1',
        title: '拍摄',
        tooltip: '拍摄',
        icon: Icons.photo_camera
    ),
    MenuIconData(
        id: '1',
        title: 'AI作图',
        tooltip: 'AI作图',
        icon: Icons.auto_fix_high
    ),
    MenuIconData(
        id: '1',
        title: '创作脚本',
        tooltip: '创作脚本',
        icon: Icons.description
    ),
    MenuIconData(
        id: '1',
        title: '录屏',
        tooltip: '录屏',
        icon: Icons.videocam
    ),
    MenuIconData(
        id: '1',
        title: '提词器',
        tooltip: '提词器',
        icon: Icons.dvr
    ),
    MenuIconData(
        id: '1',
        title: '美颜',
        tooltip: '美颜',
        icon: Icons.face_retouching_natural
    ),
  ];

  static List<MenuIconData> baseMenu = [
    MenuIconData(
        id: '1',
        title: '我的钱包',
        tooltip: '我的钱包',
        icon: Icons.account_balance_wallet
    ),
    MenuIconData(
        id: '1',
        title: '我的订单',
        tooltip: '我的订单',
        icon: Icons.list_alt
    ),
    MenuIconData(
        id: '1',
        title: '二维码',
        tooltip: '二维码',
        icon: Icons.qr_code
    ),
    MenuIconData(
        id: '1',
        title: '观看历史',
        tooltip: '观看历史',
        icon: Icons.schedule
    ),
    MenuIconData(
        id: '1',
        title: '离线模式',
        tooltip: '离线模式',
        icon: Icons.wifi_off
    ),
    MenuIconData(
        id: '1',
        title: '版本升级',
        tooltip: '版本升级',
        icon: Icons.cloud_download
    ),
    MenuIconData(
        id: '1',
        title: '我的客服',
        tooltip: '录屏',
        icon: Icons.support_agent
    ),
    MenuIconData(
        id: '1',
        title: '版本升级',
        tooltip: '版本升级',
        icon: Icons.cloud_download
    ),
    MenuIconData(
        id: '1',
        title: '我的客服',
        tooltip: '录屏',
        icon: Icons.support_agent
    ),
    MenuIconData(
        id: '1',
        title: '版本升级',
        tooltip: '版本升级',
        icon: Icons.cloud_download
    ),
    MenuIconData(
        id: '1',
        title: '我的客服',
        tooltip: '录屏',
        icon: Icons.support_agent
    ),
  ];
  static List<MenuIconData> userMenu = [
    MenuIconData(
        id: '1',
        title: '模板商城',
        tooltip: '美好生活触手可得',
        icon: Icons.store
    ),
    MenuIconData(
        id: '1',
        title: '我的钱包',
        tooltip: '查看余额与账单',
        icon: Icons.payment
    ),
    MenuIconData(
        id: '1',
        title: '放映厅',
        tooltip: '海量经典影视',
        icon: Icons.smart_display
    ),
    MenuIconData(
        id: '1',
        title: '我的小程序',
        tooltip: '最近使用',
        icon: Icons.widgets
    ),
  ];
}