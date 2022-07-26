// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status()
    ..createdAt = json['created_at'] as String?
    ..id = json['id'] as int?
    ..mid = json['mid'] as String?
    ..idstr = json['idstr'] as String?
    ..text = json['text'] as String?
    ..source = json['source'] as String?
    ..favorited = json['favorited'] as bool?
    ..truncated = json['truncated'] as bool?
    ..picUrls = json['pic_urls'] as List<dynamic>?
    ..thumbnailPic = json['thumbnail_pic'] as String?
    ..bmiddlePic = json['bmiddle_pic'] as String?
    ..originalPic = json['original_pic'] as String?
    ..user = json['user'] == null ? null : User.fromJson(json['user'])
    ..retweetedStatus = json['retweeted_status'] == null
        ? null
        : Status.fromJson(json['retweeted_status'])
    ..repostsCount = json['reposts_count'] as int?
    ..commentsCount = json['comments_count'] as int?
    ..attitudesCount = json['attitudes_count'] as int?
    ..type = json['type'] as int?
    ..videoUrl = json['video_url'] as String?;
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
    };
