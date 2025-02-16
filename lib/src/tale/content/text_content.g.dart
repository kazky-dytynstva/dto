// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextContentDto _$TextContentDtoFromJson(Map<String, dynamic> json) =>
    TextContentDto(
      text: (json['text'] as List<dynamic>).map((e) => e as String).toList(),
      minReadingTime: (json['min_reading_time'] as num).toInt(),
      maxReadingTime: (json['max_reading_time'] as num).toInt(),
    );

Map<String, dynamic> _$TextContentDtoToJson(TextContentDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'min_reading_time': instance.minReadingTime,
      'max_reading_time': instance.maxReadingTime,
    };
