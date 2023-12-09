import 'package:flutter/material.dart';

import 'package:cc_clip_app/api/ApiBase.dart';
import 'package:cc_clip_app/api/ApiAuth.dart';
import 'package:cc_clip_app/config/Config.dart';
import 'package:cc_clip_app/util/UserStorage.dart';

// 用户卡片
class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
  });

  @override
  UserCardState createState() => UserCardState();
}

class UserCardState extends State<UserCard> with TickerProviderStateMixin {
  String userName = '';
  String roleName = '';

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }
  // 获取用户信息
  Future<void> initUserInfo() async {
    String? name = await UserStorage().getStorage(StoreKeys.userName);
    int? role= await UserStorage().getStorage(StoreKeys.userRole);
    setState(() {
      userName = name ?? '';
      roleName = role != null ? StoreKeys.roleNameMap[role] : '';
    });
  }

  void userLogout(context) async {
    CustomResponse logoutRes = await ApiAuth.logout();
    if(logoutRes.success && !logoutRes.hasError) {
      UserStorage().removeStorage(StoreKeys.userName);
      UserStorage().removeStorage(StoreKeys.userPhone);
      UserStorage().removeStorage(StoreKeys.userEmail);
      UserStorage().removeStorage(StoreKeys.userUuid);
      UserStorage().removeStorage(StoreKeys.userRole);
      UserStorage().removeStorage(StoreKeys.userStatus);
      Navigator.of(context).pushReplacementNamed('/LoginPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(10,10,10,0),
      decoration: BoxDecoration(
          gradient:  const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Color(0xffdbc0a8),
              Color(0xffa7876d),
              Color(0xff886a52),
              Color(0xff6e523c),
            ],
          ),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: const Color(0xff93918f),
              width: 1
          )
      ),
      child: userName.isNotEmpty && roleName.isNotEmpty ? Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: const Color(0xfff1e7eb),
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                        color: const Color(0xfff1e7eb),
                        width: 1
                    )
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () => {},
                  child: Image.asset('assets/image/head.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(child: Container(
                  padding: const EdgeInsets.fromLTRB(14, 10, 0, 4),
                  alignment: Alignment.topLeft,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(0, 6, 0, 0), child: Text(roleName, style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[300]
                      ),))
                    ],
                  )
              )
              ),
              Container(
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.all(0),
                  transform: Matrix4.translationValues(8, -10, 0),
                  child: IconButton(
                    iconSize: 20,
                    padding: const EdgeInsets.all(0),
                    color: Colors.grey[100],
                    icon: const Icon(Icons.logout_outlined),
                    tooltip: '退出登录',
                    onPressed: () => userLogout(context),
                  )
              )
            ],
          ),
          Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: Text('会员到期时间：2024-12-12', style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400
                ))),
              ],
            ),
          )
        ],
      ) : SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  color: const Color(0xfff1e7eb),
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                      color: const Color(0xfff1e7eb),
                      width: 1
                  )
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () => {
                  Navigator.of(context).pushReplacementNamed('/LoginPage')
                },
                child: Image.asset('assets/image/icons8-user.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(top: 10, left: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 20, right: 20)),
                  overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey[700] as Color),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0XFFECE9E5)),
                  foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey[900] as Color),
                  side: MaterialStateProperty.resolveWith((states) => BorderSide(width: 1, color: Colors.grey[100] as Color)),
                ),
                onPressed: () =>  Navigator.of(context).pushReplacementNamed('/LoginPage'),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: const Icon(Icons.login_outlined, size: 20,),
                    ),
                    const Text('立即登录', style: TextStyle(
                      fontSize: 16,
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}