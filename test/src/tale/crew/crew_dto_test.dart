import 'package:test/test.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';

void main() {
  group('$CrewDto', () {
    test('given valid data '
        'when serializing and deserializing $CrewDto '
        'then the object remains consistent', () {
      // Given
      final crewDto = CrewDto(
        authors: [1, 2, 3],
        readers: [4, 5],
        musicians: [6],
        translators: null,
        graphics: [],
      );

      // When
      final json = crewDto.toJson();
      final deserialized = CrewDto.fromJson(json);

      // Then
      expect(deserialized, equals(crewDto));
    });

    test('given all lists are empty or null '
        'when creating $CrewDto '
        'then an AssertionError is thrown', () {
      // Given, When, Then
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

    test('given at least one non-empty list '
        'when creating $CrewDto '
        'then the object is created successfully', () {
      // Given
      final crewDto = CrewDto(
        authors: [1],
        readers: null,
        musicians: null,
        translators: null,
        graphics: null,
      );

      // When, Then
      expect(crewDto.authors, isNotNull);
      expect(crewDto.authors, isNotEmpty);
    });
  });
}
