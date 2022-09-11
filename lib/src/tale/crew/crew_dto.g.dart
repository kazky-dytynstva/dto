// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrewDto _$CrewDtoFromJson(Map<String, dynamic> json) => CrewDto(
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as int).toList(),
      readers:
          (json['readers'] as List<dynamic>?)?.map((e) => e as int).toList(),
      musicians:
          (json['musicians'] as List<dynamic>?)?.map((e) => e as int).toList(),
      translators: (json['translators'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      graphics:
          (json['graphics'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );
