import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_demo_2/common/base/base_list_provider.dart';
import 'package:flutter_dio_demo_2/common/base/base_screen.dart';
import 'package:flutter_dio_demo_2/common/base/power_base_presenter.dart';
import 'package:flutter_dio_demo_2/home/model/home_entity.dart';
import 'package:flutter_dio_demo_2/home/presenter/home_presenter.dart';
import 'package:flutter_dio_demo_2/home/view/home_i_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with BaseScreenMixin<HomeScreen, PowerBasePresenter>
    implements HomeIMvpView {
  HomePresenter _presenter;

  @override
  PowerBasePresenter createPresenter() {
    final PowerBasePresenter powerPresenter = PowerBasePresenter<dynamic>(this);
    _presenter = HomePresenter();
    powerPresenter.requestPresenter([_presenter]);
    return powerPresenter;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () => _presenter.getData());
  }

  @override
  BaseListProvider<HomeAsks> provider = BaseListProvider<HomeAsks>();

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<HomeAsks>>(
        create: (_) => provider,
        child: Consumer<BaseListProvider<HomeAsks>>(builder: (_, provider, __) {
          return Scaffold(
              backgroundColor: Color(0xFF1B262D),
              appBar: AppBar(
                  backgroundColor: Color(0xFF1B262D),
                  title: Text('Trading', style: TextStyle(color: Colors.white)),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.settings_input_antenna_rounded,
                            color: Color(0xFF05CB9E)),
                        onPressed: () => {debugPrint('搜尋')})
                  ]),
              body: provider.list.length == 0
                  ? buildLoadingContainer()
                  : buildListSingleChildScrollView(provider));
        }));
  }

  Container buildLoadingContainer() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))));
  }

  SingleChildScrollView buildListSingleChildScrollView(
      BaseListProvider<HomeAsks> provider) {
    return SingleChildScrollView(
        child: ListBody(children: <Widget>[
      Image.asset('assets/icon_top.png',
          fit: BoxFit.fitWidth, width: double.infinity),
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 0.0),
        itemBuilder: (ctx, i) => buildListItem(provider.list[i], ctx),
        itemCount: provider.list.length,
      )
    ]));
  }
}

Widget buildListItem(HomeAsks item, BuildContext ctx) {
  var name = '${item.frr}/${item.timestamp}';
  var isUp = (item.period + Random().nextInt(5)) % 2 == 0;
  var rate = item.rate.take(5);
  return Container(
      color: Color(0xFF1B262D),
      child: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Column(children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(ctx).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Container()));
                },
                child: buildNameRow(name, rate, isUp)),
            Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(color: Color(0xFF161B1F)),
                ))
          ])));
}

Row buildNameRow(String name, String rate, bool isUp) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.monetization_on_outlined,
                      size: 23, color: Colors.white),
                  SizedBox(width: 3),
                  Text(name, style: TextStyle(color: Colors.white))
                ])),
        buildRateContainer(rate, isUp)
      ]);
}

Container buildRateContainer(String rate, bool isUp) {
  return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
    Text('$rate%',
        style: TextStyle(color: isUp ? Color(0xFF03CA9B) : Color(0xFFE44B44))),
    Icon(isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        size: 30, color: isUp ? Color(0xFF03CA9B) : Color(0xFFE44B44))
  ]));
}

extension StringX on String {
  String take(int nbChars) => substring(0, nbChars.clamp(0, length));
}
