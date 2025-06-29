// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaleDto _$TaleDtoFromJson(Map<String, dynamic> json) => TaleDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      createDate: DateTime.parse(json['create_date'] as String),
      updateDate: json['update_date'] == null
          ? null
          : DateTime.parse(json['update_date'] as String),
      summary: json['summary'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => $enumDecode(_$TaleTagEnumMap, e))
          .toSet(),
      text: json['text'] == null
          ? null
          : TextContentDto.fromJson(json['text'] as Map<String, dynamic>),
      audio: json['audio'] == null
          ? null
          : AudioContentDto.fromJson(json['audio'] as Map<String, dynamic>),
      crew: json['crew'] == null
          ? null
          : CrewDto.fromJson(json['crew'] as Map<String, dynamic>),
      isHidden: json['is_hidden'] as bool?,
    );

Map<String, dynamic> _$TaleDtoToJson(TaleDto instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'create_date': instance.createDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('update_date', instance.updateDate?.toIso8601String());
  val['summary'] = instance.summary;
  val['tags'] = instance.tags.map((e) => _$TaleTagEnumMap[e]!).toList();
  writeNotNull('text', instance.text?.toJson());
  writeNotNull('audio', instance.audio?.toJson());
  writeNotNull('crew', instance.crew?.toJson());
  writeNotNull('is_hidden', instance.isHidden);
  return val;
}

const _$TaleTagEnumMap = {
  TaleTag.audio: 'audio',
  TaleTag.text: 'text',
  TaleTag.poem: 'poem',
  TaleTag.lullaby: 'lullaby',
  TaleTag.author: 'author',
};
