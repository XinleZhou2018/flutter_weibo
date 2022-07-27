import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weibo/core/network/api_util.dart';
import 'package:weibo/models/status.dart';
import 'package:weibo/utils/object_util.dart';

part 'status_api.g.dart';

@RestApi()
abstract class StatusApi {
  factory StatusApi(Dio dio) = _StatusApi;

  @GET(ApiUtil.USER_TIMELINE)
  Future<List<Status>?> queryUserTimeLine(@Query("page") int page, @Query("token") String token);
}
