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

Map<String, dynamic> _$CrewDtoToJson(CrewDto instance) => <String, dynamic>{
  'authors': ?instance.authors,
  'readers': ?instance.readers,
  'musicians': ?instance.musicians,
  'translators': ?instance.translators,
  'graphics': ?instance.graphics,
};
