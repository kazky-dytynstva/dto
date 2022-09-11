// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaleDto _$TaleDtoFromJson(Map<String, dynamic> json) => TaleDto(
      id: json['id'] as int,
      name: json['name'] as String,
      createDate: json['createDate'] as int,
      updateDate: json['updateDate'] as int?,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => $enumDecode(_$TaleTagEnumMap, e))
          .toSet(),
      content: (json['content'] as List<dynamic>)
          .map((e) => ChapterDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: json['crew'] == null
          ? null
          : CrewDto.fromJson(json['crew'] as Map<String, dynamic>),
      ignore: json['ignore'] as bool? ?? false,
    );

const _$TaleTagEnumMap = {
  TaleTag.audio: 'audio',
  TaleTag.text: 'text',
  TaleTag.poem: 'poem',
  TaleTag.lullaby: 'lullaby',
  TaleTag.author: 'author',
};
