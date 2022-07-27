import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:weibo/core/network/core/dio_builder.dart';
import 'package:weibo/models/status.dart';
import 'package:weibo/network/status_api.dart';
import 'package:weibo/network/token.dart';
import 'package:weibo/utils/log_util.dart';
import 'package:weibo/utils/object_util.dart';

class HomeController extends GetxController {
  int page = 1;

  List<Status>? statusList;

  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    LogUtil.v("onInit");

    _queryHomeTimeLine();
  }

  @override
  void onReady() async {
    super.onReady();

    LogUtil.v("onReady");
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _queryHomeTimeLine() {
    StatusApi statusApi = StatusApi(dio!);

    statusApi.queryUserTimeLine(page, AccessToken.accessToken).then((value) {
      statusList = value;

      update(['list_view']);
    }).catchError((error) {
      LogUtil.v(error);
      showToast("请关注公众号 fullstack2022 获取Token", duration: Duration(seconds: 60));
    });
  }

  void refreshData() {
    if (statusList != null) {
      statusList!.clear();
    }

    page = 1;
    StatusApi statusApi = StatusApi(dio!);

    statusApi.queryUserTimeLine(page, AccessToken.accessToken).then((value) {
      statusList = value;

      update(['list_view']);

      refreshController.refreshCompleted();

      page++;
    }).catchError((error) {
      LogUtil.v(error);

      refreshController.refreshCompleted();
    });
  }

  void loadMoreData() {
    StatusApi statusApi = StatusApi(dio!);

    statusApi.queryUserTimeLine(page, AccessToken.accessToken).then((value) {
      if (ObjectUtil.isEmptyList(value)) {
        refreshController.loadNoData();
      } else {
        statusList!.addAll(value!);

        update(['list_view']);

        refreshController.loadComplete();

        page++;
      }
    }).catchError((error) {
      LogUtil.v(error);

      refreshController.loadComplete();
    });
  }
}
