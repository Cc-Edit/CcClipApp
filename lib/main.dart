import 'package:cc_clip_app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cc_clip_app/component/DrawContainer.dart';
import 'package:cc_clip_app/pages/GuidePage.dart';
import 'package:cc_clip_app/util/Storage.dart';
import 'package:cc_clip_app/config/Config.dart';

// 程序入口
void main() => runApp(const MyApp());

// 声明App为一个无状态容器
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 应用根节点.
  @override
  Widget build(BuildContext context) {
    Widget mainContainer = DrawContainer(
      drawerWidth: MediaQuery.of(context).size.width * 0.75, // 侧边栏宽度比例
    );
    return FutureBuilder<dynamic>(
        future: Storage().getStorage(StoreKeys.showGuide), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.data == null) return const SizedBox();
          return MaterialApp(
            title: 'Cc Clip',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF181818),  // seedColor 是种子颜色，由此派生相关主题下的其他颜色
                  primary: Colors.white,
                  background: const Color(0xFF181818)
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
                    color: Colors.white
                ), // 标题样式
                bodyMedium: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white
                ),
                bodyLarge: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white
                ),
                displaySmall: GoogleFonts.lato(),
              ),
            ),
            routes: {
              '/MainPage': (ctx) => mainContainer,
              '/LoginPage': (ctx) => const LoginPage(),
            },
            home: snapshot.data ? const GuidePage() : const LoginPage(),
          );
        });
  }
}
