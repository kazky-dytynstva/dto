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
      imageCount: json['imageCount'] as int?,
    );
