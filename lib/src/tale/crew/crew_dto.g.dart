// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrewDto _$CrewDtoFromJson(Map<String, dynamic> json) => CrewDto(
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      readers: (json['readers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      musicians: (json['musicians'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      translators: (json['translators'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      graphics: (json['graphics'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CrewDtoToJson(CrewDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('authors', instance.authors);
  writeNotNull('readers', instance.readers);
  writeNotNull('musicians', instance.musicians);
  writeNotNull('translators', instance.translators);
  writeNotNull('graphics', instance.graphics);
  return val;
}
