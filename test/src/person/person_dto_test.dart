import 'package:test/test.dart';
import '../../utils/throws_assert_error_with_message.dart';
import 'package:dto/dto.dart';

void main() {
  group('$PersonDto', () {
    group('$PersonDto constructor', () {
      group('id', () {
        test(
          'given negative id '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
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
          },
        );

        test(
          'given id equal to stub id '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
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
          },
        );
      });

      group('name', () {
        const error =
            'Person name should be between ${PersonDto.nameMinLength} and ${PersonDto.nameMaxLength} characters long';
        test(
          'given empty for name '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
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
          },
        );

        test(
          'given name with length less than ${PersonDto.nameMinLength} '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
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
          },
        );

        test(
          'given name with length greater than ${PersonDto.nameMaxLength} '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
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
          },
        );
      });

      group('surname', () {
        const error =
            'Person surname should be between ${PersonDto.surnameMinLength} and ${PersonDto.surnameMaxLength} characters long';
        test(
          'given empty for surname '
          'when creating $PersonDto '
          'then return normally',
          () {
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
          },
        );

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
        final urlGreaterThanMaxLength =
            Uri.parse('${'b' * (PersonDto.urlMaxLength - 3)}.com');

        test(
          'given url with length less than ${PersonDto.urlMinLength} '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
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
          },
        );

        test(
          'given url with length greater than ${PersonDto.urlMaxLength} '
          'when creating $PersonDto '
          'then throws assertion error with correct message',
          () {
            // Given
            assert(
              urlGreaterThanMaxLength.toString().length >
                  PersonDto.urlMaxLength,
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
          },
        );
      });

      test(
        'given valid data '
        'when creating $PersonDto '
        'then fields are set correctly',
        () {
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
        },
      );
    });

    group('$PersonDto.fromJson factory', () {
      test(
        'given JSON with unknown gender '
        'when calling $PersonDto.fromJson '
        'then throws error',
        () {
          // Given
          final json = {
            'id': 11,
            'name': 'Unknown',
            'surname': 'Gender',
            'gender': 'other',
            'create_date': DateTime.now().toIso8601String(),
            'update_date': null,
          };
          // Then
          expect(() => PersonDto.fromJson(json), throwsA(isA<ArgumentError>()));
        },
      );

      test(
        'given JSON with unknown role '
        'when calling $PersonDto.fromJson '
        'then throws error',
        () {
          // Given
          final json = {
            'id': 12,
            'name': 'Unknown',
            'surname': 'Role',
            'gender': 'male',
            'roles': ['alien'],
            'create_date': DateTime.now().toIso8601String(),
            'update_date': null,
          };
          // Then
          expect(() => PersonDto.fromJson(json), throwsA(isA<ArgumentError>()));
        },
      );

      test(
        'given JSON with duplicate roles '
        'when calling $PersonDto.fromJson '
        'then throws assertion error with correct message',
        () {
          // Given
          final json = {
            'id': 13,
            'name': 'Dup',
            'surname': 'Role',
            'gender': 'female',
            'roles': ['author', 'author'],
            'create_date': DateTime.now().toIso8601String(),
            'update_date': null,
          };
          // Then
          expect(
            () => PersonDto.fromJson(json),
            throwsAssertErrorWithMessage('Person roles should be unique'),
          );
        },
      );

      test(
        'given JSON with null in roles list '
        'when calling $PersonDto.fromJson '
        'then throws error',
        () {
          // Given
          final json = {
            'id': 14,
            'name': 'Null',
            'surname': 'Role',
            'gender': 'female',
            'roles': [null],
            'create_date': DateTime.now().toIso8601String(),
            'update_date': null,
          };
          // Then
          expect(() => PersonDto.fromJson(json), throwsA(isA<ArgumentError>()));
        },
      );

      test(
        'given JSON with extra unknown fields '
        'when calling $PersonDto.fromJson '
        'then unknown fields are ignored',
        () {
          // Given
          final json = {
            'id': 15,
            'name': 'Extra',
            'surname': 'Fields',
            'gender': 'male',
            'unknown1': 123,
            'unknown2': 'abc',
            'create_date': DateTime.now().toIso8601String(),
            'update_date': null,
          };
          // When
          final person = PersonDto.fromJson(json);
          // Then
          expect(person.id, 15);
          expect(person.name, 'Extra');
          expect(person.surname, 'Fields');
        },
      );
      test(
        'given JSON with all fields '
        'when calling $PersonDto.fromJson '
        'then PersonDto is created correctly',
        () {
          // Given
          final json = {
            'id': 2,
            'name': 'Jane',
            'surname': 'Smith',
            'gender': 'female',
            'url': 'https://example.org',
            'info': 'Other info',
            'roles': ['musician', 'graphic'],
            'create_date': DateTime.now().toIso8601String(),
            'update_date': DateTime.now().add(Duration(hours: 1)).toIso8601String(),
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
        },
      );

      test(
        'given JSON with missing optional fields '
        'when calling $PersonDto.fromJson '
        'then PersonDto is created with nulls',
        () {
          // Given
          final json = {
            'id': 3,
            'name': 'Alex',
            'surname': 'Brown',
            'gender': 'male',
            'create_date': DateTime.now().toIso8601String(),
            'update_date': null,
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
        },
      );
    });

    group('$PersonDto.toJson method', () {
      test(
        'given two $PersonDto objects with same data '
        'when comparing with == '
        'then they are equal',
        () {
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
        },
      );

      test(
        'given two $PersonDto objects with different data '
        'when comparing with == '
        'then they are not equal',
        () {
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
        },
      );
      test(
        'given PersonDto '
        'when calling $PersonDto.toJson '
        'then correct map is returned',
        () {
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

          // When
          final json = person.toJson();

          // Then
          expect(json['id'], 4);
          expect(json['name'], 'Sam');
          expect(json['surname'], 'Green');
          expect(json['gender'], 'female');
          expect(json['url'], isNull);
          expect(json['info'], isNull);
          expect(json['roles'], ['translator']);
        },
      );
    });
  });
}
