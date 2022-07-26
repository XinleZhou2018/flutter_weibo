import 'package:json_annotation/json_annotation.dart';
import 'package:weibo/models/status.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? idstr;
  String? screenName;
  String? name;

  String? province;
  String? city;

  String? location;
  String? description;
  String? url;
  String? profileImageUrl;
  String? profileUrl;
  String? domain;
  String? weihao;
  String? gender;

  int? followersCount;
  int? friendsCount;
  int? statusesCount;
  int? favouritesCount;

  String? createdAt;

  bool? allowAllActMsg;
  bool? geoEnabled;
  bool? verified;

  String? remark;

  Status? status;

  bool? allowAllComment;

  String? avatarLarge;

  String? avatarHd;

  String? verifiedReason;
  bool? followMe;
  int? onlineStatus;
  int? biFollowersCount;
  String? lang;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
