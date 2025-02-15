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
      url: json['url'] as String?,
      info: json['info'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PersonRoleDtoEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$PersonDtoToJson(PersonDto instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'surname': instance.surname,
    'gender': _$PersonGenderDtoEnumMap[instance.gender]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('info', instance.info);
  writeNotNull(
      'roles', instance.roles?.map((e) => _$PersonRoleDtoEnumMap[e]!).toList());
  return val;
}

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
