// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaleDto _$TaleDtoFromJson(Map<String, dynamic> json) => TaleDto(
      id: json['id'] as int,
      name: json['name'] as String,
      createDate: json['create_date'] as int,
      updateDate: json['update_date'] as int?,
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
  val['content'] = instance.content.map((e) => e.toJson()).toList();
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
