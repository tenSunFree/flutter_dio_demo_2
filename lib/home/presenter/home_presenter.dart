import 'package:flutter_dio_demo_2/common/base/base_screen_presenter.dart';
import 'package:flutter_dio_demo_2/common/remote/dio_utils.dart';
import 'package:flutter_dio_demo_2/common/remote/http_api.dart';
import 'package:flutter_dio_demo_2/home/model/home_entity.dart';
import 'package:flutter_dio_demo_2/home/view/home_i_view.dart';

class HomePresenter extends BaseScreenPresenter<HomeIMvpView> {
  Future getData() {
    return requestNetwork<HomeEntity>(Method.get, url: HttpApi.search2,
        onSuccess: (data) {
      if (data != null) {
        view.provider.list.clear();
        if (data.asks.isNotEmpty) view.provider.addAll(data.asks);
      }
    }, onError: (_, __) {});
  }
}
