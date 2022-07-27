part of 'status_api.dart';

class _StatusApi implements StatusApi {
  _StatusApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  @override
  queryUserTimeLine(int page, String token) async {
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(token, 'token');

    final queryParameters = <String, dynamic>{'page': page, 'token':token};
    final Response _result = await _dio.request(
      '/weibo/queryWeibo',
      queryParameters: queryParameters,
      options: Options(method: 'GET', headers: <String, dynamic>{}, extra: {}),
    );
    final value = _result.data?['data'];

    if (ObjectUtil.isEmptyList(value)) return null;

    List<Status> statusList = [];

    for (var item in value) {
      if (item != null) {
        statusList.add(Status.fromJson(item));
      }
    }

    return statusList;
  }
}
