import 'package:test/test.dart';
import 'package:dto/dto.dart';

void main() {
  group('PersonGenderDto', () {
    test('should have correct JSON values', () {
      // Given
      final female = PersonGenderDto.female;
      final male = PersonGenderDto.male;

      // When/Then
      expect(female.toString(), equals('PersonGenderDto.female'));
      expect(male.toString(), equals('PersonGenderDto.male'));
    });

    test('should parse from JSON correctly', () {
      // Given
      final femaleJson = 'PersonGenderDto.female';
      final maleJson = 'PersonGenderDto.male';

      // When
      final female =
          PersonGenderDto.values.firstWhere((e) => e.toString() == femaleJson);
      final male =
          PersonGenderDto.values.firstWhere((e) => e.toString() == maleJson);

      // Then
      expect(female, equals(PersonGenderDto.female));
      expect(male, equals(PersonGenderDto.male));
    });

    test('should serialize to JSON correctly', () {
      // Given
      final female = PersonGenderDto.female;
      final male = PersonGenderDto.male;

      // When/Then
      expect(female.toString(), equals('female'));
      expect(male.toString(), equals('male'));
    });
  });
}
