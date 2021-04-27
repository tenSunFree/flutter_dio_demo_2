import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dio_demo_2/common/remote/dio_utils.dart';
import 'package:flutter_dio_demo_2/common/remote/intercept.dart';
import 'package:flutter_dio_demo_2/home/view/home_screen.dart';

class App extends StatefulWidget {
  final Widget child;

  App({Key key, this.child}) : super(key: key);

  _appState createState() => _appState();
}

class _appState extends State<App> {
  @override
  void initState() {
    super.initState();
    initDio();
  }

  void initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];
    interceptors.add(AuthInterceptor());
    interceptors.add(TokenInterceptor());
    interceptors.add(LoggingInterceptor());
    interceptors.add(AdapterInterceptor());
    configDio(
      baseUrl: 'https://api.bitfinex.com/v1/',
      interceptors: interceptors,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamBuilder<ThemeData>(
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          title: 'FlutterDioDemo2',
          theme: snapshot.data,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}
