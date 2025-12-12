import 'package:dto/src/tale/content/audio_content_dto.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';
import 'package:test/test.dart';
import 'package:dto/src/tale/tale_dto.dart';

import '../../utils/throws_assert_error_with_message.dart';

void main() {
  group('$TaleDto', () {
    final createDate = DateTime.fromMillisecondsSinceEpoch(1620000000000);
    final updateDate = DateTime.fromMillisecondsSinceEpoch(1620003600000);
    final summaryMin = 'a' * TaleDto.summaryMinLength;
    final summaryMax = 'a' * TaleDto.summaryMaxLength;

    group('constructor asserts', () {
      test('given id is negative '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: -1,
            name: 'Valid Name',
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin,
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [Paragraph.text(text: 'Paragraph 1')],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage('Tale id should be positive'),
        );
      });

      test('given id that equals ${TaleDto.stubId} '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: TaleDto.stubId,
            name: 'Valid Name',
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin,
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [Paragraph.text(text: 'Paragraph 1')],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage('Tale id should NOT be a stub id'),
        );
      });

      test('given name too short '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        final name = 'a' * (TaleDto.nameMinLength - 1);
        expect(
          () => TaleDto(
            id: 1,
            name: name,
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin,
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [Paragraph.text(text: 'Paragraph 1')],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage(
            'Tale name should be between ${TaleDto.nameMinLength} and ${TaleDto.nameMaxLength} characters long',
          ),
        );
      });

      test('given name too long '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        final name = 'a' * (TaleDto.nameMaxLength + 1);
        expect(
          () => TaleDto(
            id: 1,
            name: name,
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin,
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [Paragraph.text(text: 'Paragraph 1')],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage(
            'Tale name should be between ${TaleDto.nameMinLength} and ${TaleDto.nameMaxLength} characters long',
          ),
        );
      });

      test('given updateDate is before createDate '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: 1,
            name: 'Valid Name',
            createDate: updateDate,
            updateDate: createDate,
            summary: summaryMin,
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [Paragraph.text(text: 'Paragraph 1')],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage(
            'updateDate can NOT be before createDate',
          ),
        );
      });

      test('given tags is empty '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: 1,
            name: 'Valid Name',
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin,
            tags: {},
            text: null,
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage('There should be at least one tag'),
        );
      });

      test('given summary is too short '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: 1,
            name: 'Valid Name',
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin.substring(1),
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [Paragraph.text(text: 'Paragraph 1')],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage(
            'Tale summary should be between ${TaleDto.summaryMinLength} and ${TaleDto.summaryMaxLength} characters long',
          ),
        );
      });

      test('given summary is too long '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: 1,
            name: 'Valid Name',
            createDate: createDate,
            updateDate: updateDate,
            summary: '${summaryMax}a',
            tags: {TaleTag.text},
            text: TextContentDto(
              items: [Paragraph.text(text: 'Paragraph 1')],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage(
            'Tale summary should be between ${TaleDto.summaryMinLength} and ${TaleDto.summaryMaxLength} characters long',
          ),
        );
      });

      test('given tags contain text but text content is null '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: 1,
            name: 'Valid Name',
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin,
            tags: {TaleTag.text},
            text: null,
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage(
            'Text content should be present if and only if the tale has a TaleTag.text tag',
          ),
        );
      });

      test('given tags contain audio but audio content is null '
          'when creating $TaleDto '
          'then an AssertionError with a specific message is thrown', () {
        // Given, When, Then
        expect(
          () => TaleDto(
            id: 1,
            name: 'Valid Name',
            createDate: createDate,
            updateDate: updateDate,
            summary: summaryMin,
            tags: {TaleTag.audio},
            text: null,
            audio: null,
            crew: null,
            isHidden: false,
          ),
          throwsAssertErrorWithMessage(
            'Audio content should be present if and only if the tale has a TaleTag.audio tag',
          ),
        );
      });
    });

    group('factory fromJson', () {
      test('given valid JSON '
          'when deserializing $TaleDto '
          'then the object is created successfully', () {
        // Given
        final validJson = {
          'id': 1,
          'name': 'Tale Name',
          'create_date': createDate.toIso8601String(),
          'update_date': updateDate.toIso8601String(),
          'summary': summaryMin,
          'tags': ['text'],
          'text': {
            'items': ['Paragraph 1', 'Paragraph 2'],
            'min_reading_time': 5,
            'max_reading_time': 10,
          },
          'audio': null,
          'crew': null,
          'is_hidden': false,
        };

        // When
        final tale = TaleDto.fromJson(validJson);

        // Then
        expect(tale.id, equals(1));
        expect(tale.name, equals('Tale Name'));
        expect(tale.createDate, equals(createDate));
        expect(tale.updateDate, equals(updateDate));
        expect(tale.summary, equals(summaryMin));
        expect(tale.tags, equals({TaleTag.text}));
        expect(
          tale.text?.items,
          equals([
            Paragraph.text(text: 'Paragraph 1'),
            Paragraph.text(text: 'Paragraph 2'),
          ]),
        );
        expect(tale.text?.minReadingTime, equals(5));
        expect(tale.text?.maxReadingTime, equals(10));
        expect(tale.audio, isNull);
        expect(tale.crew, isNull);
        expect(tale.isHidden, isNull);
      });

      test('given JSON with missing required fields '
          'when deserializing $TaleDto '
          'then an error is thrown', () {
        // Given
        final invalidJson = {
          'name': 'Tale Name',
          'create_date': createDate.toIso8601String(),
        };

        // When, Then
        expect(() => TaleDto.fromJson(invalidJson), throwsA(isA<Error>()));
      });

      test('given JSON with invalid data types '
          'when deserializing $TaleDto '
          'then an error is thrown', () {
        // Given
        final invalidJson = {
          'id': 'invalid_id',
          'name': 'Tale Name',
          'create_date': createDate.toIso8601String(),
          'update_date': updateDate.toIso8601String(),
          'tags': [],
        };

        // When, Then
        expect(() => TaleDto.fromJson(invalidJson), throwsA(isA<Error>()));
      });

      test('given JSON with extra fields '
          'when deserializing $TaleDto '
          'then the extra fields are ignored', () {
        // Given
        final jsonWithExtraFields = {
          'id': 1,
          'name': 'Tale Name',
          'create_date': createDate.toIso8601String(),
          'update_date': updateDate.toIso8601String(),
          'summary': summaryMin,
          'tags': ['text'],
          'text': {
            'items': ['Paragraph 1', 'Paragraph 2'],
            'min_reading_time': 5,
            'max_reading_time': 10,
          },
          'extra_field': 'unexpected',
        };

        // When
        final tale = TaleDto.fromJson(jsonWithExtraFields);

        // Then
        expect(tale.id, equals(1));
        expect(tale.name, equals('Tale Name'));
        expect(tale.createDate, equals(createDate));
        expect(tale.updateDate, equals(updateDate));
        expect(tale.summary, equals(summaryMin));
        expect(tale.tags, equals({TaleTag.text}));
        expect(
          tale.text?.items,
          equals([
            Paragraph.text(text: 'Paragraph 1'),
            Paragraph.text(text: 'Paragraph 2'),
          ]),
        );
        expect(tale.text?.minReadingTime, equals(5));
        expect(tale.text?.maxReadingTime, equals(10));
      });

      test('given JSON with null optional fields '
          'when deserializing $TaleDto '
          'then the object is created successfully', () {
        // Given
        final jsonWithNullFields = {
          'id': 1,
          'name': 'Tale Name',
          'create_date': createDate.toIso8601String(),
          'update_date': updateDate.toIso8601String(),
          'summary': summaryMin,
          'tags': ['text'],
          'text': {
            'items': ['Paragraph 1', 'Paragraph 2'],
            'min_reading_time': 5,
            'max_reading_time': 10,
          },
          'audio': null,
          'crew': null,
          'is_hidden': null,
        };

        // When
        final tale = TaleDto.fromJson(jsonWithNullFields);

        // Then
        expect(tale.id, equals(1));
        expect(tale.name, equals('Tale Name'));
        expect(tale.createDate, equals(createDate));
        expect(tale.updateDate, equals(updateDate));
        expect(tale.summary, equals(summaryMin));
        expect(tale.tags, equals({TaleTag.text}));
        expect(
          tale.text?.items,
          equals([
            Paragraph.text(text: 'Paragraph 1'),
            Paragraph.text(text: 'Paragraph 2'),
          ]),
        );
        expect(tale.text?.minReadingTime, equals(5));
        expect(tale.text?.maxReadingTime, equals(10));
        expect(tale.audio, isNull);
        expect(tale.crew, isNull);
        expect(tale.isHidden, isNull);
      });
    });

    group('toJson', () {
      test('given all fields are present '
          'when calling toJson on $TaleDto '
          'then the resulting map contains all expected key-value pairs', () {
        // Given
        final tale = TaleDto(
          id: 1,
          name: 'Tale Name',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [Paragraph.text(text: 'Paragraph 1')],
            minReadingTime: 5,
            maxReadingTime: 10,
          ),
          audio: null,
          crew: null,
          isHidden: null,
        );

        final expectedJson = {
          'id': 1,
          'name': 'Tale Name',
          'create_date': createDate.toIso8601String(),
          'update_date': updateDate.toIso8601String(),
          'summary': summaryMin,
          'tags': ['text'],
          'text': {
            'items': ['Paragraph 1'],
            'min_reading_time': 5,
            'max_reading_time': 10,
          },
        };

        // When
        final json = tale.toJson();

        // Then
        expect(json, equals(expectedJson));
      });

      test('given only required fields are present '
          'when calling toJson on $TaleDto '
          'then the resulting map contains only required key-value pairs', () {
        // Given
        final tale = TaleDto(
          id: 2,
          name: 'Minimal Tale',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [Paragraph.text(text: 'Only one')],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
        );

        final expectedJson = {
          'id': 2,
          'name': 'Minimal Tale',
          'create_date': createDate.toIso8601String(),
          'update_date': updateDate.toIso8601String(),
          'summary': summaryMin,
          'tags': ['text'],
          'text': {
            'items': ['Only one'],
            'min_reading_time': 1,
            'max_reading_time': 2,
          },
        };

        // When
        final json = tale.toJson();

        // Then
        expect(json, equals(expectedJson));
      });

      test('given optional fields are null '
          'when calling toJson on $TaleDto '
          'then the resulting map contains null for those fields', () {
        // Given
        final tale = TaleDto(
          id: 3,
          name: 'Null Optionals',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [Paragraph.text(text: 'A')],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          isHidden: null,
        );

        // When
        final json = tale.toJson();

        // Then
        expect(json['audio'], isNull);
        expect(json['crew'], isNull);
        expect(json['is_hidden'], isNull);
      });

      test('given $TaleDto with both text and audio tags and content '
          'when calling toJson '
          'then both text and audio fields are present in the map', () {
        // Given
        final tale = TaleDto(
          id: 4,
          name: 'Text and Audio',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text, TaleTag.audio},
          text: TextContentDto(
            items: [Paragraph.text(text: 'A')],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: AudioContentDto(
            fileSize: 123,
            duration: Duration(seconds: 456),
          ),
          crew: null,
          isHidden: false,
        );
        final expectedAudioJson = {'file_size': 123, 'duration': 456000000};
        final expectedTextJson = {
          'items': ['A'],
          'min_reading_time': 1,
          'max_reading_time': 2,
        };

        // When
        final json = tale.toJson();

        // Then
        expect(json['text'], equals(expectedTextJson));
        expect(json['audio'], equals(expectedAudioJson));
      });

      test('given $TaleDto with crew '
          'when calling toJson '
          'then crew field is present in the map', () {
        // Given
        final tale = TaleDto(
          id: 5,
          name: 'With Crew',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [Paragraph.text(text: 'A')],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: CrewDto(
            authors: [1],
            readers: [42],
            musicians: [43, 42],
            translators: [1, 2, 3, 4, 5, 6],
            graphics: [1, 2, 3],
          ),
          isHidden: false,
        );
        final expectedCrewJson = {
          'authors': [1],
          'readers': [42],
          'musicians': [43, 42],
          'translators': [1, 2, 3, 4, 5, 6],
          'graphics': [1, 2, 3],
        };

        // When
        final json = tale.toJson();

        // Then
        expect(json['crew'], equals(expectedCrewJson));
      });
    });
  });
}
