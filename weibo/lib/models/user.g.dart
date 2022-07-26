// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int?
    ..idstr = json['idstr'] as String?
    ..screenName = json['screenName'] as String?
    ..name = json['name'] as String?
    ..province = json['province'] as String?
    ..city = json['city'] as String?
    ..location = json['location'] as String?
    ..description = json['description'] as String?
    ..url = json['url'] as String?
    ..profileImageUrl = json['profile_image_url'] as String?
    ..profileUrl = json['profile_url'] as String?
    ..domain = json['domain'] as String?
    ..weihao = json['weihao'] as String?
    ..gender = json['gender'] as String?
    ..followersCount = json['followers_count'] as int?
    ..friendsCount = json['friends_count'] as int?
    ..statusesCount = json['statuses_count'] as int?
    ..favouritesCount = json['favourites_count'] as int?
    ..createdAt = json['created_at'] as String?
    ..allowAllActMsg = json['allow_all_act_msg'] as bool?
    ..geoEnabled = json['geo_enabled'] as bool?
    ..verified = json['verified'] as bool?
    ..remark = json['remark'] as String?
    ..status = json['status'] == null ? null : Status.fromJson(json['status'])
    ..allowAllComment = json['allow_all_comment'] as bool?
    ..avatarLarge = json['avatar_large'] as String?
    ..avatarHd = json['avatar_hd'] as String?
    ..verifiedReason = json['verified_reason'] as String?
    ..followMe = json['follow_me'] as bool?
    ..onlineStatus = json['online_status'] as int?
    ..biFollowersCount = json['bi_followers_count'] as int?
    ..lang = json['lang'] as String?;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
    };
