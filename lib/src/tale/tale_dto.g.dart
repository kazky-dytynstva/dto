// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaleDto _$TaleDtoFromJson(Map<String, dynamic> json) => TaleDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      createDate: (json['create_date'] as num).toInt(),
      updateDate: (json['update_date'] as num?)?.toInt(),
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
      ignore: json['ignore'] as bool?,
    );

Map<String, dynamic> _$TaleDtoToJson(TaleDto instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'create_date': instance.createDate,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('update_date', instance.updateDate);
  val['tags'] = instance.tags.map((e) => _$TaleTagEnumMap[e]!).toList();
  writeNotNull('text', instance.text?.toJson());
  writeNotNull('audio', instance.audio?.toJson());
  writeNotNull('crew', instance.crew?.toJson());
  writeNotNull('ignore', instance.ignore);
  return val;
}

const _$TaleTagEnumMap = {
  TaleTag.audio: 'audio',
  TaleTag.text: 'text',
  TaleTag.poem: 'poem',
  TaleTag.lullaby: 'lullaby',
  TaleTag.author: 'author',
};
