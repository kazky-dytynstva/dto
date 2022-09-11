import 'package:dto/dto.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

import '../../../test_data/test_data.dart';

void main() {
  final crew = getCrew();

  test('GIVEN instance THEN verify it is equatable', () {
    expect(crew, isA<Equatable>());
  });

  test('GIVEN instance THEN verify all props correct', () {
    const props = [
      crewAuthors,
      crewReaders,
      crewMusicians,
      crewTranslators,
      crewGraphics,
    ];
    expect(crew.props, equals(props));
  });

  test('GIVEN same params and 2 instances THEN objects are equal', () {
    const authors = [0, 1, 2];
    const readers = [2, 3, 4];
    const musicians = [1, 3, 5];
    const translators = [3, 5];
    const graphics = [5];

    final instanceOne = getCrew(
      authors: authors,
      readers: readers,
      musicians: musicians,
      translators: translators,
      graphics: graphics,
    );
    final instanceTwo = getCrew(
      authors: authors,
      musicians: musicians,
      readers: readers,
      translators: translators,
      graphics: graphics,
    );

    expect(instanceOne, equals(instanceTwo));
  });

  test('GIVEN json with min params THEN parsed correctly', () {
    final dto = CrewDto.fromJson(crewJson);
    expect(dto, equals(crew));
  });

  test('GIVEN empty list THEN throw exception', () {
    expect(
      () => CrewDto(
        authors: [],
        readers: null,
        musicians: null,
        translators: null,
        graphics: null,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => CrewDto(
        authors: null,
        readers: [],
        musicians: null,
        translators: null,
        graphics: null,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => CrewDto(
        authors: null,
        readers: null,
        musicians: [],
        translators: null,
        graphics: null,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => CrewDto(
        authors: null,
        readers: null,
        musicians: null,
        translators: [],
        graphics: null,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => CrewDto(
          authors: null,
          readers: null,
          musicians: null,
          translators: null,
          graphics: []),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => CrewDto(
        authors: null,
        readers: null,
        musicians: null,
        translators: null,
        graphics: null,
      ),
      throwsA(isA<AssertionError>()),
    );
  });
}
