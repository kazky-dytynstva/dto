// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_audio_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterAudioDto _$ChapterAudioDtoFromJson(Map<String, dynamic> json) =>
    ChapterAudioDto(
      size: (json['size'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$ChapterAudioDtoToJson(ChapterAudioDto instance) =>
    <String, dynamic>{
      'size': instance.size,
      'duration': instance.duration,
    };
