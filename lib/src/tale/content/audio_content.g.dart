// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioContentDto _$AudioContentDtoFromJson(Map<String, dynamic> json) =>
    AudioContentDto(
      fileSize: (json['file_size'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$AudioContentDtoToJson(AudioContentDto instance) =>
    <String, dynamic>{
      'file_size': instance.fileSize,
      'duration': instance.duration,
    };
