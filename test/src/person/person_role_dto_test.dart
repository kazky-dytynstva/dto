import 'package:test/test.dart';
import 'package:dto/dto.dart';

void main() {
  group('$PersonRoleDto', () {
    test(
      'given enum value author '
      'when checking name and index '
      'then values are correct',
      () {
        // Given
        final role = PersonRoleDto.author;
        // When/Then
        expect(role, equals(PersonRoleDto.author));
        expect(role.index, equals(0));
        expect(role.toString(), contains('author'));
      },
    );

    test(
      'given enum value reader '
      'when checking name and index '
      'then values are correct',
      () {
        // Given
        final role = PersonRoleDto.reader;
        // When/Then
        expect(role, equals(PersonRoleDto.reader));
        expect(role.index, equals(1));
        expect(role.toString(), contains('reader'));
      },
    );

    test(
      'given enum value musician '
      'when checking name and index '
      'then values are correct',
      () {
        // Given
        final role = PersonRoleDto.musician;
        // When/Then
        expect(role, equals(PersonRoleDto.musician));
        expect(role.index, equals(2));
        expect(role.toString(), contains('musician'));
      },
    );

    test(
      'given enum value graphic '
      'when checking name and index '
      'then values are correct',
      () {
        // Given
        final role = PersonRoleDto.graphic;
        // When/Then
        expect(role, equals(PersonRoleDto.graphic));
        expect(role.index, equals(3));
        expect(role.toString(), contains('graphic'));
      },
    );

    test(
      'given enum value translator '
      'when checking name and index '
      'then values are correct',
      () {
        // Given
        final role = PersonRoleDto.translator;
        // When/Then
        expect(role, equals(PersonRoleDto.translator));
        expect(role.index, equals(4));
        expect(role.toString(), contains('translator'));
      },
    );

    test(
      'given enum value crew '
      'when checking name and index '
      'then values are correct',
      () {
        // Given
        final role = PersonRoleDto.crew;
        // When/Then
        expect(role, equals(PersonRoleDto.crew));
        expect(role.index, equals(5));
        expect(role.toString(), contains('crew'));
      },
    );

    final allRoles = [
      'author',
      'reader',
      'musician',
      'graphic',
      'translator',
      'crew',
    ];

    for (final roleStr in allRoles) {
      test(
        'given string value "$roleStr" '
        'when decoding with json_annotation '
        'then returns PersonRoleDto.$roleStr',
        () {
          // Given
          final json = {'role': roleStr};
          final roleValue = json['role'] ?? '';
          // When
          final decoded = PersonRoleDto.values.firstWhere(
            (e) => _enumJsonValue(e) == roleValue,
          );
          // Then
          expect(
            decoded == PersonRoleDto.values[allRoles.indexOf(roleStr)],
            isTrue,
          );
        },
      );
    }

    test(
      'given invalid string value '
      'when decoding with json_annotation '
      'then throws StateError',
      () {
        // Given
        final json = {'role': 'invalid'};
        final roleValue = json['role'] ?? '';
        // Then
        expect(
          () => PersonRoleDto.values.firstWhere(
            (e) => _enumJsonValue(e) == roleValue,
          ),
          throwsA(isA<StateError>()),
        );
      },
    );
  });
}

/// Helper to extract the @JsonValue from the enum value.
String? _enumJsonValue(Object e) {
  switch (e) {
    case PersonRoleDto.author:
      return 'author';
    case PersonRoleDto.reader:
      return 'reader';
    case PersonRoleDto.musician:
      return 'musician';
    case PersonRoleDto.graphic:
      return 'graphic';
    case PersonRoleDto.translator:
      return 'translator';
    case PersonRoleDto.crew:
      return 'crew';
    default:
      return null;
  }
}
