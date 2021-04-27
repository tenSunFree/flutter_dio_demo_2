import 'package:flutter_dio_demo_2/common/base/base_list_provider.dart';
import 'package:flutter_dio_demo_2/common/base/mvps.dart';
import 'package:flutter_dio_demo_2/home/model/home_entity.dart';

abstract class HomeIMvpView implements IMvpView {
  BaseListProvider<HomeAsks> get provider;
}
