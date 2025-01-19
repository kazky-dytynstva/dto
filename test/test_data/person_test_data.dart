import 'dart:math';

import 'package:dto/dto.dart';
import 'package:dto/src/person/person_role_dto.dart';

const personId = 1;
const personName = "Person Name";
const personUrl = "https://test.url.com";
const personInfo = "Some info about";
final personRoles = PersonRoleDto.values;

const _keyId = "id";
const _keyName = "name";
const _keyUrl = "url";
const _keyInfo = "info";
const _keyRoles = "roles";

Map<String, dynamic> personJsonWithMinFields = {
  _keyId: personId,
  _keyName: personName,
  _keyRoles: [],
};

Map<String, dynamic> personJsonWithAllFields = {
  _keyId: personId,
  _keyName: personName,
  _keyUrl: personUrl,
  _keyInfo: personInfo,
  _keyRoles: personRoles.map((e) => e.toString().split('.').last).toList(),
};

PersonDto getPerson({
  int id = personId,
  String name = personName,
  String? url,
  String? info,
  List<PersonRoleDto> roles = const [],
}) {
  return PersonDto(
    id: id,
    name: name,
    url: url,
    info: info,
    roles: roles,
  );
}

PersonDto getPersonFull({
  int id = personId,
  String name = personName,
  String url = personUrl,
  String info = personInfo,
  List<PersonRoleDto> roles = PersonRoleDto.values,
}) {
  return PersonDto(
    id: id,
    name: name,
    url: url,
    info: info,
    roles: personRoles,
  );
}
