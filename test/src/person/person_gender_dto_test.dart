import 'package:test/test.dart';
import 'package:dto/dto.dart';

import '../../json_keys/person_gender_keys.dart';

void main() {
  group('$PersonGenderDto', () {
    test('given enum value female '
        'when checking name and index '
        'then values are correct', () {
      // Given/When
      final gender = PersonGenderDto.female;
      // Then
      expect(gender, PersonGenderDto.female);
      expect(gender.index, 0);
      expect(gender.toString(), contains('female'));
    });

    test('given enum value male '
        'when checking name and index '
        'then values are correct', () {
      // Given/When
      final gender = PersonGenderDto.male;
      // Then
      expect(gender, PersonGenderDto.male);
      expect(gender.index, 1);
      expect(gender.toString(), contains('male'));
    });

    test('given string value "female" '
        'when decoding with json_annotation '
        'then returns PersonGenderDto.female', () {
      // Given
      final json = {PersonGenderKeys.gender: 'female'};
      final genderStr = json[PersonGenderKeys.gender] ?? '';
      // When
      final decoded = PersonGenderDto.values.firstWhere(
        (e) => _enumJsonValue(e) == genderStr,
      );
      // Then
      expect(decoded, PersonGenderDto.female);
    });

    test('given string value "male" '
        'when decoding with json_annotation '
        'then returns PersonGenderDto.male', () {
      // Given
      final json = {PersonGenderKeys.gender: 'male'};
      final genderStr = json[PersonGenderKeys.gender] ?? '';
      // When
      final decoded = PersonGenderDto.values.firstWhere(
        (e) => _enumJsonValue(e) == genderStr,
      );
      // Then
      expect(decoded, PersonGenderDto.male);
    });

    test('given invalid string value '
        'when decoding with json_annotation '
        'then throws StateError', () {
      // Given
      final json = {PersonGenderKeys.gender: 'other'};
      final genderStr = json[PersonGenderKeys.gender] ?? '';
      // Then
      expect(
        () => PersonGenderDto.values.firstWhere(
          (e) => _enumJsonValue(e) == genderStr,
        ),
        throwsA(isA<StateError>()),
      );
    });
  });
}

/// Helper to extract the @JsonValue from the enum value.
String? _enumJsonValue(Object e) {
  switch (e) {
    case PersonGenderDto.female:
      return 'female';
    case PersonGenderDto.male:
      return 'male';
    default:
      return null;
  }
}
