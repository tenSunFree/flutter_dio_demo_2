import 'package:flutter/material.dart';
import 'package:flutter_dio_demo_2/common/base/i_lifecycle.dart';

abstract class IMvpView {
  BuildContext getContext();
}

abstract class IPresenter extends ILifecycle {}
