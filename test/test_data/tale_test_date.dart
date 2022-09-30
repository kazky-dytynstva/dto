import 'package:dto/dto.dart';

import 'test_data.dart';

const taleId = 777;
const taleName = 'Tale name';
const taleCreateDate = 12323;
const taleUpdateDate = 122323;
final taleTags = TaleTag.values.toSet();
final taleContent = [getChapter()];
final taleCrew = getCrew();
const taleIgnore = true;

const _keyId = 'id';
const _keyName = 'name';
const _keyCreateDate = 'create_date';
const _keyUpdateDate = 'update_date';
const _keyTags = 'tags';
const _keyContent = 'content';
const _keyCrew = 'crew';
const _keyIgnore = 'ignore';

List<String> taleTagsJson = TaleTag.values.map((e) => e.name).toList();

Map<String, dynamic> taleJsonFull = {
  _keyId: taleId,
  _keyName: taleName,
  _keyCreateDate: taleCreateDate,
  _keyUpdateDate: taleUpdateDate,
  _keyTags: taleTagsJson,
  _keyContent: [chapterJson],
  _keyCrew: crewJson,
  _keyIgnore: taleIgnore,
};
Map<String, dynamic> taleJsonMin = {
  _keyId: taleId,
  _keyName: taleName,
  _keyCreateDate: taleCreateDate,
  _keyTags: taleTagsJson,
  _keyContent: [chapterJson],
};

TaleDto getTale({
  int id = taleId,
  String name = taleName,
  int createDate = taleCreateDate,
  int? updateDate = taleUpdateDate,
  Set<TaleTag>? tags,
  List<ChapterDto>? content,
  CrewDto? crew,
  bool? ignore = taleIgnore,
}) =>
    TaleDto(
      id: id,
      name: name,
      createDate: createDate,
      updateDate: updateDate,
      tags: tags ?? taleTags,
      content: content ?? taleContent,
      crew: crew,
      ignore: ignore ?? false,
    );
