import 'dart:typed_data';
import 'package:dto/src/compression/dto_compression.dart';
import 'package:dto/src/person/person_dto.dart';
import 'package:dto/src/person/person_gender_dto.dart';
import 'package:dto/src/person/person_role_dto.dart';
import 'package:dto/src/tale/tale_dto.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';
import 'package:test/test.dart';

void main() {
  group('DTOCompression', () {
    group('Tales compression', () {
      test('should compress and decompress empty list of tales', () {
        final tales = <TaleDto>[];

        final compressed = DTOCompression.compressTales(tales);
        final decompressed = DTOCompression.decompressTales(compressed);

        expect(decompressed, isEmpty);
      });

      test('should compress and decompress single tale', () {
        final tale = TaleDto(
          id: 1,
          name: 'Test Tale',
          createDate: DateTime(2023, 1, 1),
          updateDate: DateTime(2023, 1, 2),
          summary: 'This is a test summary for the tale.' + ('a' * 104),
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Once upon a time...'),
            ],
            minReadingTime: 5,
            maxReadingTime: 10,
          ),
          audio: null,
          crew: CrewDto(
            authors: [1],
            readers: null,
            translators: null,
            musicians: null,
            graphics: null,
          ),
        );

        final compressed = DTOCompression.compressTales([tale]);
        final decompressed = DTOCompression.decompressTales(compressed);

        expect(decompressed.length, 1);
        expect(decompressed.first, tale);
      });

      test('should compress and decompress multiple tales', () {
        final tales = [
          TaleDto(
            id: 1,
            name: 'First Tale',
            createDate: DateTime(2023, 1, 1),
            updateDate: null,
            summary: 'This is the first test summary.' + ('a' * 109),
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'First tale content...'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: CrewDto(
              authors: [1],
              readers: null,
              translators: null,
              musicians: null,
              graphics: null,
            ),
          ),
          TaleDto(
            id: 2,
            name: 'Second Tale',
            createDate: DateTime(2023, 2, 1),
            updateDate: DateTime(2023, 2, 2),
            summary: 'This is the second test summary.' + ('a' * 108),
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'Second tale content...'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: CrewDto(
              authors: [2],
              readers: null,
              translators: null,
              musicians: null,
              graphics: null,
            ),
          ),
        ];

        final compressed = DTOCompression.compressTales(tales);
        final decompressed = DTOCompression.decompressTales(compressed);

        expect(decompressed.length, 2);
        expect(decompressed[0], tales[0]);
        expect(decompressed[1], tales[1]);
      });

      test('should produce compressed data smaller than original JSON', () {
        final tales = List.generate(
          100,
          (i) => TaleDto(
            id: i + 1,
            name: 'Tale number ${i + 1}',
            createDate: DateTime(2023, 1, 1),
            updateDate: null,
            summary: 'a' * TaleDto.summaryMinLength,

            tags: {TaleTag.text},
            text: TextContentDto(
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'Content for tale ${i + 1}. ' * 10),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: CrewDto(
              authors: [1],
              readers: null,
              translators: null,
              musicians: null,
              graphics: null,
            ),
          ),
        );

        final compressed = DTOCompression.compressTales(tales);
        final decompressed = DTOCompression.decompressTales(compressed);

        expect(decompressed.length, 100);
        expect(compressed, isA<Uint8List>());
        // Verify compression actually reduced size
        expect(compressed.length, lessThan(tales.toString().length));
      });
    });

    group('People compression', () {
      test('should compress and decompress empty list of people', () {
        final people = <PersonDto>[];

        final compressed = DTOCompression.compressPeople(people);
        final decompressed = DTOCompression.decompressPeople(compressed);

        expect(decompressed, isEmpty);
      });

      test('should compress and decompress single person', () {
        final person = PersonDto(
          id: 1,
          name: 'John',
          surname: 'Doe',
          gender: PersonGenderDto.male,
          url: Uri.parse('https://example.com/john'),
          info: 'A test person',
          roles: [PersonRoleDto.author],
          createDate: DateTime(2023, 1, 1),
          updateDate: null,
        );

        final compressed = DTOCompression.compressPeople([person]);
        final decompressed = DTOCompression.decompressPeople(compressed);

        expect(decompressed.length, 1);
        expect(decompressed.first, person);
      });

      test('should compress and decompress multiple people', () {
        final people = [
          PersonDto(
            id: 1,
            name: 'John',
            surname: 'Doe',
            gender: PersonGenderDto.male,
            url: Uri.parse('https://example.com/john'),
            info: 'First test person',
            roles: [PersonRoleDto.author],
            createDate: DateTime(2023, 1, 1),
            updateDate: null,
          ),
          PersonDto(
            id: 2,
            name: 'Jane',
            surname: 'Smith',
            gender: PersonGenderDto.female,
            url: Uri.parse('https://example.com/jane'),
            info: 'Second test person',
            roles: [PersonRoleDto.reader, PersonRoleDto.translator],
            createDate: DateTime(2023, 2, 1),
            updateDate: DateTime(2023, 2, 2),
          ),
        ];

        final compressed = DTOCompression.compressPeople(people);
        final decompressed = DTOCompression.decompressPeople(compressed);

        expect(decompressed.length, 2);
        expect(decompressed[0], people[0]);
        expect(decompressed[1], people[1]);
      });

      test('should produce compressed data smaller than original JSON', () {
        final people = List.generate(
          100,
          (i) => PersonDto(
            id: i + 1,
            name: 'Person${i + 1}',
            surname: 'Surname${i + 1}',
            gender: i % 2 == 0 ? PersonGenderDto.male : PersonGenderDto.female,
            url: Uri.parse('https://example.com/person${i + 1}'),
            info: 'Information about person ${i + 1}. ' * 5,
            roles: [PersonRoleDto.author],
            createDate: DateTime(2023, 1, 1),
            updateDate: null,
          ),
        );

        final compressed = DTOCompression.compressPeople(people);
        final decompressed = DTOCompression.decompressPeople(compressed);

        expect(decompressed.length, 100);
        expect(compressed, isA<Uint8List>());
        // Verify compression actually reduced size
        expect(compressed.length, lessThan(people.toString().length));
      });

      test('should handle person with minimal data', () {
        final person = PersonDto(
          id: 1,
          name: 'MinimalPerson',
          surname: '',
          gender: PersonGenderDto.male,
          url: null,
          info: '',
          roles: null,
          createDate: DateTime(2023, 1, 1),
          updateDate: null,
        );

        final compressed = DTOCompression.compressPeople([person]);
        final decompressed = DTOCompression.decompressPeople(compressed);

        expect(decompressed.length, 1);
        expect(decompressed.first, person);
      });
    });
  });
}
