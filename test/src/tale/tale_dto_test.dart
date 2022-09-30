import 'package:dto/dto.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

import '../../test_data/test_data.dart';

void main() {
  final taleDto = getTale(crew: getCrew());

  test('GIVEN instance THEN verify it is equatable', () {
    expect(taleDto, isA<Equatable>());
  });

  test('GIVEN instance THEN verify all props correct', () {
    final props = [
      taleId,
      taleName,
      taleCreateDate,
      taleUpdateDate,
      taleTags,
      taleContent,
      taleCrew,
      taleIgnore,
    ];
    expect(taleDto.props, equals(props));
  });

  test('GIVEN same params and 2 instances THEN objects are equal', () {
    const id = 124;
    const name = 'Custom tale name';
    const createDate = 11232323;
    const updateDate = 11232323123;
    final tags = {TaleTag.values.first, TaleTag.values.last};
    final content = [
      getChapter(title: 'first title'),
      getChapter(title: 'second title'),
    ];
    final crew = getCrew(authors: [23, 21, 22]);
    const ignore = false;

    final instanceOne = getTale(
      id: id,
      name: name,
      createDate: createDate,
      updateDate: updateDate,
      tags: tags,
      content: content,
      crew: crew,
      ignore: ignore,
    );
    final instanceTwo = getTale(
      id: id,
      name: name,
      createDate: createDate,
      updateDate: updateDate,
      tags: tags,
      content: content,
      crew: crew,
      ignore: ignore,
    );

    expect(instanceOne, equals(instanceTwo));
  });

  test('GIVEN json with min params THEN parsed correctly', () {
    expect(
      TaleDto.fromJson(taleJsonFull),
      equals(taleDto),
    );
    expect(
      TaleDto.fromJson(taleJsonMin),
      equals(
        getTale(
          updateDate: null,
          ignore: null,
          crew: null,
        ),
      ),
    );
  });

  test('GIVEN empty content THEN throw exception', () {
    expect(
      () => getTale(content: []),
      throwsA(isA<AssertionError>()),
    );
  });

  test('GIVEN empty tags THEN throw exception', () {
    expect(
      () => getTale(tags: {}),
      throwsA(isA<AssertionError>()),
    );
  });

  test('GIVEN negative tale id THEN throw exception', () {
    expect(
      () => getTale(id: -1),
      throwsA(isA<AssertionError>()),
    );
    expect(
      getTale(id: 0),
      isA<TaleDto>(),
    );
  });

  test('GIVEN empty tale name THEN throw exception', () {
    expect(
      () => getTale(name: ''),
      throwsA(isA<AssertionError>()),
    );
    expect(
      getTale(name: ' '),
      isA<TaleDto>(),
    );
  });

  test('GIVEN updateDate before or equal createDate THEN throw exception', () {
    final date = DateTime(2022, 12, 2).microsecondsSinceEpoch;
    expect(
      () => getTale(
        createDate: date,
        updateDate: date,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => getTale(
        createDate: date,
        updateDate: date - 1,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      getTale(
        createDate: date,
        updateDate: date + 1,
      ),
      isA<TaleDto>(),
    );
  });

  test('GIVEN model with all params THEN converted to json correctly', () {
    final model = taleDto;
    expect(model.toJson(), equals(taleJsonFull));
  });
}
