import 'package:test/test.dart';
import '../../json_keys/person_keys.dart';
import '../../utils/throws_assert_error_with_message.dart';
import 'package:dto/dto.dart';

void main() {
  group('$PersonDto', () {
    group('$PersonDto constructor', () {
      group('id', () {
        test('given negative id '
            'when creating $PersonDto '
            'then throws assertion error with correct message', () {
          // Given/When/Then
          expect(
            () => PersonDto(
              id: -1,
              name: 'Neg',
              surname: 'Id',
              gender: PersonGenderDto.female,
              url: null,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            throwsAssertErrorWithMessage('Person id should be positive'),
          );
        });

        test('given id equal to stub id '
            'when creating $PersonDto '
            'then throws assertion error with correct message', () {
          // Given/When/Then
          expect(
            () => PersonDto(
              id: PersonDto.stubId,
              name: 'Neg',
              surname: 'Id',
              gender: PersonGenderDto.female,
              url: null,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            throwsAssertErrorWithMessage('Person id should NOT be a stub id'),
          );
        });
      });

      group('name', () {
        const error =
            'Person name should be between ${PersonDto.nameMinLength} and ${PersonDto.nameMaxLength} characters long';
        test('given empty for name '
            'when creating $PersonDto '
            'then throws assertion error with correct message', () {
          // Given/When/Then
          expect(
            () => PersonDto(
              id: 100,
              name: '',
              surname: 'Doe',
              gender: PersonGenderDto.male,
              url: null,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            throwsAssertErrorWithMessage(error),
          );
        });

        test('given name with length less than ${PersonDto.nameMinLength} '
            'when creating $PersonDto '
            'then throws assertion error with correct message', () {
          // Given/When/Then
          expect(
            () => PersonDto(
              id: 100,
              name: 'A' * (PersonDto.nameMinLength - 1),
              surname: 'Doe',
              gender: PersonGenderDto.male,
              url: null,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            throwsAssertErrorWithMessage(error),
          );
        });

        test('given name with length greater than ${PersonDto.nameMaxLength} '
            'when creating $PersonDto '
            'then throws assertion error with correct message', () {
          // Given/When/Then
          expect(
            () => PersonDto(
              id: 100,
              name: 'A' * (PersonDto.nameMaxLength + 1),
              surname: 'Doe',
              gender: PersonGenderDto.values.first,
              url: null,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            throwsAssertErrorWithMessage(error),
          );
        });
      });

      group('surname', () {
        const error =
            'Person surname should be between ${PersonDto.surnameMinLength} and ${PersonDto.surnameMaxLength} characters long';
        test('given empty for surname '
            'when creating $PersonDto '
            'then return normally', () {
          // Given/When/Then
          expect(
            () => PersonDto(
              id: 101,
              name: 'John',
              surname: '',
              gender: PersonGenderDto.male,
              url: null,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            returnsNormally,
          );
        });

        test(
          'given surname with length less than ${PersonDto.surnameMinLength} '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
            // Given/When/Then
            expect(
              () => PersonDto(
                id: 101,
                name: 'John',
                surname: 'D' * (PersonDto.surnameMinLength - 1),
                gender: PersonGenderDto.values.first,
                url: null,
                info: null,
                roles: null,
                createDate: DateTime.now(),
                updateDate: null,
              ),
              throwsAssertErrorWithMessage(error),
            );
          },
        );

        test(
          'given surname with length greater than ${PersonDto.surnameMaxLength} '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
            // Given/When/Then
            expect(
              () => PersonDto(
                id: 101,
                name: 'John',
                surname: 'D' * (PersonDto.surnameMaxLength + 1),
                gender: PersonGenderDto.values.first,
                url: null,
                info: null,
                roles: null,
                createDate: DateTime.now(),
                updateDate: null,
              ),
              throwsAssertErrorWithMessage(error),
            );
          },
        );
      });

      group('url', () {
        const error =
            'Person url should be a valid URL, with length between ${PersonDto.urlMinLength} and ${PersonDto.urlMaxLength} characters';
        final urlLessThanMinLength = Uri.parse('a.co');
        final urlGreaterThanMaxLength = Uri.parse(
          '${'b' * (PersonDto.urlMaxLength - 3)}.com',
        );

        test('given url with length less than ${PersonDto.urlMinLength} '
            'when creating $PersonDto '
            'then throws assertion error with correct message', () {
          // Given
          assert(
            urlLessThanMinLength.toString().length < PersonDto.urlMinLength,
            'Test setup failed: URL length is not less than minimum',
          );

          // When/Then
          expect(
            () => PersonDto(
              id: 102,
              name: 'John',
              surname: 'Doe',
              gender: PersonGenderDto.values.first,
              url: urlLessThanMinLength,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            throwsAssertErrorWithMessage(error),
          );
        });

        test('given url with length greater than ${PersonDto.urlMaxLength} '
            'when creating $PersonDto '
            'then throws assertion error with correct message', () {
          // Given
          assert(
            urlGreaterThanMaxLength.toString().length > PersonDto.urlMaxLength,
            'Test setup failed: URL length is not greater than maximum',
          );
          // When/Then
          expect(
            () => PersonDto(
              id: 102,
              name: 'John',
              surname: 'Doe',
              gender: PersonGenderDto.values.first,
              url: urlGreaterThanMaxLength,
              info: null,
              roles: null,
              createDate: DateTime.now(),
              updateDate: null,
            ),
            throwsAssertErrorWithMessage(error),
          );
        });
      });

      test('given valid data '
          'when creating $PersonDto '
          'then fields are set correctly', () {
        // Given
        final id = 1;
        final name = 'John';
        final surname = 'Doe';
        final gender = PersonGenderDto.male;
        final url = Uri.parse('https://example.com');
        final info = 'Some info';
        final roles = [PersonRoleDto.author, PersonRoleDto.reader];
        final createDate = DateTime.now();
        final updateDate = DateTime.now().add(Duration(hours: 1));

        // When
        final person = PersonDto(
          id: id,
          name: name,
          surname: surname,
          gender: gender,
          url: url,
          info: info,
          roles: roles,
          createDate: createDate,
          updateDate: updateDate,
        );

        // Then
        expect(person.id, id);
        expect(person.name, name);
        expect(person.surname, surname);
        expect(person.gender, gender);
        expect(person.url, url);
        expect(person.info, info);
        expect(person.roles, roles);
        expect(person.createDate, createDate);
        expect(person.updateDate, updateDate);
      });
    });

    group('$PersonDto.fromJson factory', () {
      test('given JSON with unknown gender '
          'when calling $PersonDto.fromJson '
          'then throws error', () {
        // Given
        final json = {
          PersonKeys.id: 11,
          PersonKeys.name: 'Unknown',
          PersonKeys.surname: 'Gender',
          PersonKeys.gender: 'other',
          PersonKeys.createDate: DateTime.now().toIso8601String(),
          PersonKeys.updateDate: null,
        };
        // Then
        expect(() => PersonDto.fromJson(json), throwsA(isA<ArgumentError>()));
      });

      test('given JSON with unknown role '
          'when calling $PersonDto.fromJson '
          'then throws error', () {
        // Given
        final json = {
          PersonKeys.id: 12,
          PersonKeys.name: 'Unknown',
          PersonKeys.surname: 'Role',
          PersonKeys.gender: 'male',
          PersonKeys.roles: ['alien'],
          PersonKeys.createDate: DateTime.now().toIso8601String(),
          PersonKeys.updateDate: null,
        };
        // Then
        expect(() => PersonDto.fromJson(json), throwsA(isA<ArgumentError>()));
      });

      test('given JSON with duplicate roles '
          'when calling $PersonDto.fromJson '
          'then throws assertion error with correct message', () {
        // Given
        final json = {
          PersonKeys.id: 13,
          PersonKeys.name: 'Dup',
          PersonKeys.surname: 'Role',
          PersonKeys.gender: 'female',
          PersonKeys.roles: ['author', 'author'],
          PersonKeys.createDate: DateTime.now().toIso8601String(),
          PersonKeys.updateDate: null,
        };
        // Then
        expect(
          () => PersonDto.fromJson(json),
          throwsAssertErrorWithMessage('Person roles should be unique'),
        );
      });

      test('given JSON with null in roles list '
          'when calling $PersonDto.fromJson '
          'then throws error', () {
        // Given
        final json = {
          PersonKeys.id: 14,
          PersonKeys.name: 'Null',
          PersonKeys.surname: 'Role',
          PersonKeys.gender: 'female',
          PersonKeys.roles: [null],
          PersonKeys.createDate: DateTime.now().toIso8601String(),
          PersonKeys.updateDate: null,
        };
        // Then
        expect(() => PersonDto.fromJson(json), throwsA(isA<ArgumentError>()));
      });

      test('given JSON with extra unknown fields '
          'when calling $PersonDto.fromJson '
          'then unknown fields are ignored', () {
        // Given
        final json = {
          PersonKeys.id: 15,
          PersonKeys.name: 'Extra',
          PersonKeys.surname: 'Fields',
          PersonKeys.gender: 'male',
          'unknown1': 123,
          'unknown2': 'abc',
          PersonKeys.createDate: DateTime.now().toIso8601String(),
          PersonKeys.updateDate: null,
        };
        // When
        final person = PersonDto.fromJson(json);
        // Then
        expect(person.id, 15);
        expect(person.name, 'Extra');
        expect(person.surname, 'Fields');
      });
      test('given JSON with all fields '
          'when calling $PersonDto.fromJson '
          'then PersonDto is created correctly', () {
        // Given
        final json = {
          PersonKeys.id: 2,
          PersonKeys.name: 'Jane',
          PersonKeys.surname: 'Smith',
          PersonKeys.gender: 'female',
          PersonKeys.url: 'https://example.org',
          PersonKeys.info: 'Other info',
          PersonKeys.roles: ['musician', 'graphic'],
          PersonKeys.createDate: DateTime.now().toIso8601String(),
          PersonKeys.updateDate: DateTime.now()
              .add(Duration(hours: 1))
              .toIso8601String(),
        };

        // When
        final person = PersonDto.fromJson(json);

        // Then
        expect(person.id, equals(2));
        expect(person.name, equals('Jane'));
        expect(person.surname, equals('Smith'));
        expect(person.gender, equals(PersonGenderDto.female));
        expect(person.url, equals(Uri.parse('https://example.org')));
        expect(person.info, equals('Other info'));
        expect(
          person.roles,
          equals([PersonRoleDto.musician, PersonRoleDto.graphic]),
        );
      });

      test('given JSON with missing optional fields '
          'when calling $PersonDto.fromJson '
          'then PersonDto is created with nulls', () {
        // Given
        final json = {
          PersonKeys.id: 3,
          PersonKeys.name: 'Alex',
          PersonKeys.surname: 'Brown',
          PersonKeys.gender: 'male',
          PersonKeys.createDate: DateTime.now().toIso8601String(),
          PersonKeys.updateDate: null,
        };

        // When
        final person = PersonDto.fromJson(json);

        // Then
        expect(person.id, 3);
        expect(person.name, 'Alex');
        expect(person.surname, 'Brown');
        expect(person.gender, PersonGenderDto.male);
        expect(person.url, isNull);
        expect(person.info, isNull);
        expect(person.roles, isNull);
      });
    });

    group('$PersonDto.toJson method', () {
      test('given two $PersonDto objects with same data '
          'when comparing with == '
          'then they are equal', () {
        // Given
        final a = PersonDto(
          id: 20,
          name: 'Eq',
          surname: 'Test',
          gender: PersonGenderDto.female,
          url: null,
          info: null,
          roles: [PersonRoleDto.author],
          createDate: DateTime.now(),
          updateDate: null,
        );
        final b = PersonDto(
          id: 20,
          name: 'Eq',
          surname: 'Test',
          gender: PersonGenderDto.female,
          url: null,
          info: null,
          roles: [PersonRoleDto.author],
          createDate: a.createDate,
          updateDate: null,
        );
        // Then
        expect(a, b);
        expect(a.hashCode, b.hashCode);
      });

      test('given two $PersonDto objects with different data '
          'when comparing with == '
          'then they are not equal', () {
        // Given
        final a = PersonDto(
          id: 21,
          name: 'Eq',
          surname: 'Test',
          gender: PersonGenderDto.female,
          url: null,
          info: null,
          roles: [PersonRoleDto.author],
          createDate: DateTime.now(),
          updateDate: null,
        );
        final b = PersonDto(
          id: 22,
          name: 'Eq',
          surname: 'Test',
          gender: PersonGenderDto.female,
          url: null,
          info: null,
          roles: [PersonRoleDto.author],
          createDate: DateTime.now(),
          updateDate: null,
        );
        // Then
        expect(a == b, isFalse);
      });
      test('given PersonDto '
          'when calling $PersonDto.toJson '
          'then correct map is returned', () {
        // Given
        final person = PersonDto(
          id: 4,
          name: 'Sam',
          surname: 'Green',
          gender: PersonGenderDto.female,
          url: null,
          info: null,
          roles: [PersonRoleDto.translator],
          createDate: DateTime.now(),
          updateDate: null,
        );
        final expectedJson = {
          PersonKeys.id: 4,
          PersonKeys.name: 'Sam',
          PersonKeys.surname: 'Green',
          PersonKeys.gender: 'female',
          PersonKeys.url: null,
          PersonKeys.info: null,
          PersonKeys.roles: ['translator'],
          PersonKeys.createDate: person.createDate.toIso8601String(),
          PersonKeys.updateDate: null,
        };

        // When
        final json = person.toJson();

        // Then
        expect(json, expectedJson);
      });

      test('given unsorted roles '
          'when calling copyWith '
          'then roles are sorted by index', () {
        // Given
        final person = PersonDto(
          id: 5,
          name: 'Test',
          surname: 'User',
          gender: PersonGenderDto.male,
          url: null,
          info: null,
          roles: null,
          createDate: DateTime.now(),
          updateDate: null,
        );
        final unsortedRoles = [
          PersonRoleDto.crew, // index 5
          PersonRoleDto.author, // index 0
          PersonRoleDto.translator, // index 4
          PersonRoleDto.reader, // index 1
          PersonRoleDto.graphic, // index 3
          PersonRoleDto.musician, // index 2
        ];
        final expectedSortedRoles = [
          PersonRoleDto.author, // index 0
          PersonRoleDto.reader, // index 1
          PersonRoleDto.musician, // index 2
          PersonRoleDto.graphic, // index 3
          PersonRoleDto.translator, // index 4
          PersonRoleDto.crew, // index 5
        ];

        // When
        final updatedPerson = person.copyWith(roles: unsortedRoles);

        // Then
        expect(updatedPerson.roles, equals(expectedSortedRoles));
      });
    });
  });
}
