// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_content_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextContentDto _$TextContentDtoFromJson(Map<String, dynamic> json) =>
    TextContentDto(
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      minReadingTime: (json['min_reading_time'] as num).toInt(),
      maxReadingTime: (json['max_reading_time'] as num).toInt(),
    );

Map<String, dynamic> _$TextContentDtoToJson(TextContentDto instance) =>
    <String, dynamic>{
      'paragraphs': instance.paragraphs,
      'min_reading_time': instance.minReadingTime,
      'max_reading_time': instance.maxReadingTime,
    };
