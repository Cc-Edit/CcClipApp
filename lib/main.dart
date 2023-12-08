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

              inputDecorationTheme: InputDecorationTheme(
                focusColor: Colors.transparent,
                suffixIconColor: Colors.grey[100],
                errorMaxLines: 1,
                errorStyle: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                  color: Colors.red[400]
                ),
                helperStyle: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1,
                    color: Colors.grey[400]
                ),
                hintStyle: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    color: Colors.grey[600],
                ),
                floatingLabelStyle: const TextStyle(
                  fontSize: 0,
                ),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // filled: true,
                // fillColor: const Color(0xFF181818),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.grey[200] as Color),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.grey[200] as Color),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.grey[400] as Color),
                ),
                errorBorder:  OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.red[400] as Color),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.grey[100] as Color),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.red[800] as Color),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 4, 0),
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
