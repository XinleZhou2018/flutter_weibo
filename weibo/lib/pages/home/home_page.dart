import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:weibo/common/widget/status_item.dart';
import 'package:weibo/pages/home/home_controller.dart';
import 'package:weibo/utils/log_util.dart';
import 'package:weibo/utils/object_util.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  //创建key
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    LogUtil.v("HomePage");

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                child: GetBuilder<HomeController>(
                    id: "list_view",
                    builder: (controller) {
                      if (ObjectUtil.isEmptyList(controller.statusList)) {
                        return Container();
                      }

                      return Scrollbar(
                          thickness: 4,
                          child: SmartRefresher(
                              controller: controller.refreshController,
                              enablePullDown: true,
                              enablePullUp: true,
                              header: const ClassicHeader(
                                idleText: '下拉刷新',
                                releaseText: '松开手指，刷新',
                                completeText: '刷新完成',
                              ),
                              footer: const ClassicFooter(
                                idleText: '上拉，加载更多',
                                loadingText: '正在加载...',
                                noDataText: '没有更多数据了...',
                              ),
                              onRefresh: () {
                                controller.refreshData();
                              },
                              onLoading: () {
                                controller.loadMoreData();
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                  itemCount: controller.statusList!.length,
                                  itemBuilder: ((context, index) {
                                    LogUtil.v("---------Item Builder---------");
                                    return StatusItem(
                                        status: controller.statusList![index]);
                                  }))));
                    }))));
  }
}
