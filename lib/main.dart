
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/provider/user_model.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'global.dart';
import 'page/index_page.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    Global.init().then((e) => runApp(MyApp(info: e)));
  });
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
}

class MyApp extends StatelessWidget {
  MyApp({Key key, this.info}) : super(key: key);
  final info;
  @override
  Widget build(BuildContext context) {
    UserModle newUserModel = new UserModle();
    return MultiProvider(
      providers: [
        //  用户信息
        ListenableProvider<UserModle>.value(value: newUserModel),
      ],
      child: Container(
        child: MaterialApp(
          //        debugShowCheckedModeBanner: false,
          home: IndexPage(),
          theme: ThemeData(
              primarySwatch: Colors.blue
          ),
        ),
      )

    );
  }
}
