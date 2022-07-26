import 'package:json_annotation/json_annotation.dart';
import 'package:weibo/models/user.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  String? createdAt;
  int? id;
  String? mid;
  String? idstr;
  String? text;
  String? source;

  bool? favorited;

  bool? truncated;

  List<dynamic>? picUrls;

  String? thumbnailPic;
  String? bmiddlePic;
  String? originalPic;

  User? user;
  Status? retweetedStatus;

  int? repostsCount;
  int? commentsCount;
  int? attitudesCount;

  int? type; //2是视频
  String? videoUrl;

  Status();

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
