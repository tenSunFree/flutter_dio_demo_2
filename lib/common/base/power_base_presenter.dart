import 'package:flutter_dio_demo_2/common/base/base_presenter.dart';
import 'package:flutter_dio_demo_2/common/base/base_screen.dart';
import 'package:flutter_dio_demo_2/common/base/base_screen_presenter.dart';

class PowerBasePresenter<IMvpView> extends BasePresenter {
  PowerBasePresenter(BaseScreenMixin state) {
    _state = state;
  }

  BaseScreenMixin _state;
  List<BaseScreenPresenter> _presenters = [];

  void requestPresenter(List<BaseScreenPresenter> presenters) {
    _presenters = presenters;
    _presenters.forEach((presenter) => presenter.view = _state);
  }

  @override
  void deactivate() {
    _presenters.forEach((presenter) => presenter.deactivate());
  }

  @override
  void didChangeDependencies() {
    _presenters.forEach((presenter) => presenter.didChangeDependencies());
  }

  @override
  void didUpdateWidgets<W>(W oldWidget) {
    _presenters
        .forEach((presenter) => presenter.didUpdateWidgets<W>(oldWidget));
  }

  @override
  void dispose() {
    _presenters.forEach((presenter) => presenter.dispose());
  }

  @override
  void initState() {
    _presenters.forEach((presenter) => presenter.initState());
  }
}
