import 'package:dto/dto.dart';

const personId = 1;
const personName = "Person Name";
const personUrl = "https://test.url.com";
const personInfo = "Some info about";

const _keyId = "id";
const _keyName = "name";
const _keyUrl = "url";
const _keyInfo = "info";

Map<String, dynamic> personJsonWithMinFields = {
  _keyId: personId,
  _keyName: personName,
};

Map<String, dynamic> personJsonWithAllFields = {
  _keyId: personId,
  _keyName: personName,
  _keyUrl: personUrl,
  _keyInfo: personInfo,
};

PersonDto getPerson({
  int id = personId,
  String name = personName,
  String? url,
  String? info,
}) =>
    PersonDto(
      id: id,
      name: name,
      url: url,
      info: info,
    );

PersonDto getPersonFull({
  int id = personId,
  String name = personName,
  String url = personUrl,
  String info = personInfo,
}) =>
    PersonDto(
      id: id,
      name: name,
      url: url,
      info: info,
    );
