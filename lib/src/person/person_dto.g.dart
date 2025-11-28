// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) => PersonDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  surname: json['surname'] as String,
  gender: $enumDecode(_$PersonGenderDtoEnumMap, json['gender']),
  url: json['url'] == null ? null : Uri.parse(json['url'] as String),
  info: json['info'] as String?,
  roles: (json['roles'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$PersonRoleDtoEnumMap, e))
      .toList(),
  createDate: DateTime.parse(json['create_date'] as String),
  updateDate: json['update_date'] == null
      ? null
      : DateTime.parse(json['update_date'] as String),
);

Map<String, dynamic> _$PersonDtoToJson(PersonDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'surname': instance.surname,
  'gender': _$PersonGenderDtoEnumMap[instance.gender]!,
  'url': ?instance.url?.toString(),
  'info': ?instance.info,
  'roles': ?instance.roles?.map((e) => _$PersonRoleDtoEnumMap[e]!).toList(),
  'create_date': instance.createDate.toIso8601String(),
  'update_date': ?instance.updateDate?.toIso8601String(),
};

const _$PersonGenderDtoEnumMap = {
  PersonGenderDto.female: 'female',
  PersonGenderDto.male: 'male',
};

const _$PersonRoleDtoEnumMap = {
  PersonRoleDto.author: 'author',
  PersonRoleDto.reader: 'reader',
  PersonRoleDto.musician: 'musician',
  PersonRoleDto.graphic: 'graphic',
  PersonRoleDto.translator: 'translator',
  PersonRoleDto.crew: 'crew',
};
