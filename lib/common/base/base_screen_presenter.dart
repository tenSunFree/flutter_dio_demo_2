import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio_demo_2/common/base/base_presenter.dart';
import 'package:flutter_dio_demo_2/common/base/mvps.dart';
import 'package:flutter_dio_demo_2/common/remote/dio_utils.dart';
import 'package:flutter_dio_demo_2/common/remote/error_handle.dart';

class BaseScreenPresenter<V extends IMvpView> extends BasePresenter<V> {
  BaseScreenPresenter() {
    _cancelToken = CancelToken();
  }

  CancelToken _cancelToken;

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
  }

  Future requestNetwork<T>(
    Method method, {
    @required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T> onSuccess,
    NetErrorCallback onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    return DioUtils.instance.requestNetwork<T>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        if (onSuccess != null) onSuccess(data);
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      },
    );
  }

  void _onError(int code, String msg, NetErrorCallback onError) {
    if (code != ExceptionHandle.cancel_error) debugPrint(msg);
    if (onError != null && view.getContext() != null) onError(code, msg);
  }
}
