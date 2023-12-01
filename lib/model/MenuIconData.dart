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
}