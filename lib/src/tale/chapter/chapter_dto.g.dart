// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterDto _$ChapterDtoFromJson(Map<String, dynamic> json) => ChapterDto(
      title: json['title'] as String?,
      text: (json['text'] as List<dynamic>?)?.map((e) => e as String).toList(),
      audio: json['audio'] == null
          ? null
          : ChapterAudioDto.fromJson(json['audio'] as Map<String, dynamic>),
      imageCount: json['image_count'] as int?,
    );

Map<String, dynamic> _$ChapterDtoToJson(ChapterDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('text', instance.text);
  writeNotNull('audio', instance.audio?.toJson());
  writeNotNull('image_count', instance.imageCount);
  return val;
}
