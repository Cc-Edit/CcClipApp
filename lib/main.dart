import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import  './pages/HomePage.dart';


// 程序入口
void main() => runApp(const MyApp());

// 声明App为一个无状态容器
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 应用根节点.
  @override
  Widget build(BuildContext context) {
    // 创建一个materialApp
    return MaterialApp(
      title: 'Clip',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,  // seedColor 是种子颜色，由此派生相关主题下的其他颜色
          brightness: Brightness.light,
          primary: Colors.white,
          background: Colors.white
        ),
        // 文本样式
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.lato(
            fontSize: 21,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: Colors.black54
          ), // 标题样式
          bodyMedium: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black54
          ),
          displaySmall: GoogleFonts.lato(),
        ),
      ),
      home: const MyHomePage(title: 'CcClip'),
    );
  }
}
