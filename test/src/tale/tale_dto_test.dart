import 'package:dto/src/admin_config/admin_config_dto.dart';
import 'package:dto/src/tale/content/audio_content_dto.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';
import 'package:test/test.dart';
import 'package:dto/src/tale/tale_dto.dart';

import '../../json_keys/admin_config_keys.dart';
import '../../json_keys/audio_content_keys.dart';
import '../../json_keys/crew_keys.dart';
import '../../json_keys/tale_keys.dart';
import '../../json_keys/text_content_keys.dart';
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
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'ContentItem 1'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            adminConfig: null,
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
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'ContentItem 1'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            adminConfig: null,
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
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'ContentItem 1'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            adminConfig: null,
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
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'ContentItem 1'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            adminConfig: null,
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
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'ContentItem 1'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            adminConfig: null,
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
            adminConfig: null,
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
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'ContentItem 1'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            adminConfig: null,
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
              items: [
                ContentItem.image(imageIndex: 0),
                ContentItem.text(text: 'ContentItem 1'),
              ],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            adminConfig: null,
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
            adminConfig: null,
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
            adminConfig: null,
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
          TaleKeys.id: 1,
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
          TaleKeys.updateDate: updateDate.toIso8601String(),
          TaleKeys.summary: summaryMin,
          TaleKeys.tags: ['text'],
          TaleKeys.text: {
            TextContentKeys.items: ['[0]', 'ContentItem 1', 'ContentItem 2'],
            TextContentKeys.minReadingTime: 5,
            TextContentKeys.maxReadingTime: 10,
          },
          TaleKeys.audio: null,
          TaleKeys.crew: null,
          TaleKeys.adminConfig: null,
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
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'ContentItem 1'),
            ContentItem.text(text: 'ContentItem 2'),
          ]),
        );
        expect(tale.text?.minReadingTime, equals(5));
        expect(tale.text?.maxReadingTime, equals(10));
        expect(tale.audio, isNull);
        expect(tale.crew, isNull);
        expect(tale.adminConfig, isNull);
      });

      test('given JSON with missing required fields '
          'when deserializing $TaleDto '
          'then an error is thrown', () {
        // Given
        final invalidJson = {
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
        };

        // When, Then
        expect(() => TaleDto.fromJson(invalidJson), throwsA(isA<Error>()));
      });

      test('given JSON with invalid data types '
          'when deserializing $TaleDto '
          'then an error is thrown', () {
        // Given
        final invalidJson = {
          TaleKeys.id: 'invalid_id',
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
          TaleKeys.updateDate: updateDate.toIso8601String(),
          TaleKeys.tags: [],
        };

        // When, Then
        expect(() => TaleDto.fromJson(invalidJson), throwsA(isA<Error>()));
      });

      test('given JSON with extra fields '
          'when deserializing $TaleDto '
          'then the extra fields are ignored', () {
        // Given
        final jsonWithExtraFields = {
          TaleKeys.id: 1,
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
          TaleKeys.updateDate: updateDate.toIso8601String(),
          TaleKeys.summary: summaryMin,
          TaleKeys.tags: ['text'],
          TaleKeys.text: {
            TextContentKeys.items: ['[0]', 'ContentItem 1', 'ContentItem 2'],
            TextContentKeys.minReadingTime: 5,
            TextContentKeys.maxReadingTime: 10,
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
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'ContentItem 1'),
            ContentItem.text(text: 'ContentItem 2'),
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
          TaleKeys.id: 1,
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
          TaleKeys.updateDate: updateDate.toIso8601String(),
          TaleKeys.summary: summaryMin,
          TaleKeys.tags: ['text'],
          TaleKeys.text: {
            TextContentKeys.items: ['[0]', 'ContentItem 1', 'ContentItem 2'],
            TextContentKeys.minReadingTime: 5,
            TextContentKeys.maxReadingTime: 10,
          },
          TaleKeys.audio: null,
          TaleKeys.crew: null,
          TaleKeys.adminConfig: null,
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
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'ContentItem 1'),
            ContentItem.text(text: 'ContentItem 2'),
          ]),
        );
        expect(tale.text?.minReadingTime, equals(5));
        expect(tale.text?.maxReadingTime, equals(10));
        expect(tale.audio, isNull);
        expect(tale.crew, isNull);
        expect(tale.adminConfig, isNull);
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
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'ContentItem 1'),
            ],
            minReadingTime: 5,
            maxReadingTime: 10,
          ),
          audio: null,
          crew: null,
          adminConfig: null,
        );

        final expectedJson = {
          TaleKeys.id: 1,
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
          TaleKeys.updateDate: updateDate.toIso8601String(),
          TaleKeys.summary: summaryMin,
          TaleKeys.tags: ['text'],
          TaleKeys.text: {
            TextContentKeys.items: ['[0]', 'ContentItem 1'],
            TextContentKeys.minReadingTime: 5,
            TextContentKeys.maxReadingTime: 10,
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
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Only one'),
            ],
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
            'items': ['[0]', 'Only one'],
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
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'A'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: null,
        );

        // When
        final json = tale.toJson();

        // Then
        expect(json[TaleKeys.audio], isNull);
        expect(json[TaleKeys.crew], isNull);
        expect(json[TaleKeys.adminConfig], isNull);
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
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'A'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: AudioContentDto(
            fileSize: 123,
            duration: Duration(seconds: 456),
          ),
          crew: null,
          adminConfig: null,
        );
        final expectedAudioJson = {
          AudioContentKeys.fileSize: 123,
          AudioContentKeys.duration: 456000000,
        };
        final expectedTextJson = {
          TextContentKeys.items: ['[0]', 'A'],
          TextContentKeys.minReadingTime: 1,
          TextContentKeys.maxReadingTime: 2,
        };

        // When
        final json = tale.toJson();

        // Then
        expect(json[TaleKeys.text], equals(expectedTextJson));
        expect(json[TaleKeys.audio], equals(expectedAudioJson));
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
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'A'),
            ],
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
          adminConfig: null,
        );
        final expectedCrewJson = {
          CrewKeys.authors: [1],
          CrewKeys.readers: [42],
          CrewKeys.musicians: [43, 42],
          CrewKeys.translators: [1, 2, 3, 4, 5, 6],
          CrewKeys.graphics: [1, 2, 3],
        };

        // When
        final json = tale.toJson();

        // Then
        expect(json[TaleKeys.crew], equals(expectedCrewJson));
      });
    });

    group('adminConfig', () {
      test('given adminConfig with non-empty values '
          'when creating $TaleDto '
          'then adminConfig is preserved', () {
        // Given/When
        final tale = TaleDto(
          id: 1,
          name: 'Tale Name',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: AdminConfigDto(
            isHidden: true,
            isReviewed: true,
            comment: 'Test comment',
          ),
        );

        // Then
        expect(tale.adminConfig, isNotNull);
        expect(tale.adminConfig?.isHidden, isTrue);
        expect(tale.adminConfig?.isReviewed, isTrue);
        expect(tale.adminConfig?.comment, equals('Test comment'));
      });

      test('given adminConfig with empty values '
          'when creating $TaleDto '
          'then adminConfig becomes null', () {
        // Given/When
        final tale = TaleDto(
          id: 1,
          name: 'Tale Name',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: AdminConfigDto(),
        );

        // Then
        expect(tale.adminConfig, isNull);
      });

      test('given adminConfig is null '
          'when creating $TaleDto '
          'then adminConfig is null', () {
        // Given/When
        final tale = TaleDto(
          id: 1,
          name: 'Tale Name',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: null,
        );

        // Then
        expect(tale.adminConfig, isNull);
      });

      test('given $TaleDto with adminConfig '
          'when calling toJson '
          'then admin_config field is in the map', () {
        // Given
        final tale = TaleDto(
          id: 1,
          name: 'Tale Name',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: AdminConfigDto(
            isHidden: true,
            isReviewed: false,
            comment: 'Admin comment',
          ),
        );
        final expectedAdminConfigJson = {
          AdminConfigKeys.isHidden: true,
          AdminConfigKeys.comment: 'Admin comment',
        };

        // When
        final json = tale.toJson();

        // Then
        expect(json[TaleKeys.adminConfig], equals(expectedAdminConfigJson));
      });

      test('given $TaleDto without adminConfig '
          'when calling toJson '
          'then admin_config field is null in the map', () {
        // Given
        final tale = TaleDto(
          id: 1,
          name: 'Tale Name',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: null,
        );

        // When
        final json = tale.toJson();

        // Then
        expect(json[TaleKeys.adminConfig], isNull);
      });

      test('given JSON with admin_config '
          'when calling fromJson '
          'then $TaleDto with adminConfig is created', () {
        // Given
        final json = {
          TaleKeys.id: 1,
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
          TaleKeys.updateDate: updateDate.toIso8601String(),
          TaleKeys.summary: summaryMin,
          TaleKeys.tags: ['text'],
          TaleKeys.text: {
            TextContentKeys.items: ['[0]', 'Content'],
            TextContentKeys.minReadingTime: 1,
            TextContentKeys.maxReadingTime: 2,
          },
          TaleKeys.audio: null,
          TaleKeys.crew: null,
          TaleKeys.adminConfig: {
            AdminConfigKeys.isHidden: true,
            AdminConfigKeys.isReviewed: true,
            AdminConfigKeys.comment: 'From JSON',
          },
        };

        // When
        final tale = TaleDto.fromJson(json);

        // Then
        expect(tale.adminConfig, isNotNull);
        expect(tale.adminConfig?.isHidden, isTrue);
        expect(tale.adminConfig?.isReviewed, isTrue);
        expect(tale.adminConfig?.comment, equals('From JSON'));
      });

      test('given JSON without admin_config '
          'when calling fromJson '
          'then $TaleDto with null adminConfig is created', () {
        // Given
        final json = {
          TaleKeys.id: 1,
          TaleKeys.name: 'Tale Name',
          TaleKeys.createDate: createDate.toIso8601String(),
          TaleKeys.updateDate: updateDate.toIso8601String(),
          TaleKeys.summary: summaryMin,
          TaleKeys.tags: ['text'],
          TaleKeys.text: {
            TextContentKeys.items: ['[0]', 'Content'],
            TextContentKeys.minReadingTime: 1,
            TextContentKeys.maxReadingTime: 2,
          },
          TaleKeys.audio: null,
          TaleKeys.crew: null,
          TaleKeys.adminConfig: null,
        };

        // When
        final tale = TaleDto.fromJson(json);

        // Then
        expect(tale.adminConfig, isNull);
      });

      test('given $TaleDto '
          'when calling copyWith with adminConfig '
          'then new instance with updated adminConfig is returned', () {
        // Given
        final original = TaleDto(
          id: 1,
          name: 'Original',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: null,
        );

        // When
        final copied = original.copyWith(
          adminConfig: AdminConfigDto(
            isHidden: true,
            isReviewed: true,
            comment: 'New config',
          ),
        );

        // Then
        expect(copied.adminConfig, isNotNull);
        expect(copied.adminConfig?.isHidden, isTrue);
        expect(copied.adminConfig?.isReviewed, isTrue);
        expect(copied.adminConfig?.comment, equals('New config'));
        expect(copied.id, equals(original.id));
        expect(copied.name, equals(original.name));
      });

      test('given $TaleDto with adminConfig '
          'when calling copyWith without adminConfig parameter '
          'then new instance preserves existing adminConfig', () {
        // Given
        final original = TaleDto(
          id: 1,
          name: 'Original',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: AdminConfigDto(
            isHidden: true,
            isReviewed: true,
            comment: 'Original config',
          ),
        );

        // When
        final copied = original.copyWith(name: 'Updated');

        // Then
        expect(copied.adminConfig, isNotNull);
        expect(copied.adminConfig?.isHidden, isTrue);
        expect(copied.adminConfig?.isReviewed, isTrue);
        expect(copied.adminConfig?.comment, equals('Original config'));
        expect(copied.name, equals('Updated'));
      });

      test('given $TaleDto with adminConfig '
          'when calling copyWith with null adminConfig '
          'then existing adminConfig is preserved', () {
        // Given
        final original = TaleDto(
          id: 1,
          name: 'Original',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: AdminConfigDto(
            isHidden: true,
            isReviewed: true,
            comment: 'Original config',
          ),
        );

        // When
        // Note: copyWith uses adminConfig ?? this.adminConfig, so passing null preserves the original
        final copied = original.copyWith(adminConfig: null);

        // Then
        expect(copied.adminConfig, isNotNull);
        expect(copied.adminConfig?.isHidden, isTrue);
        expect(copied.adminConfig?.isReviewed, isTrue);
        expect(copied.adminConfig?.comment, equals('Original config'));
      });

      test('given $TaleDto with adminConfig '
          'when calling copyWith with empty AdminConfigDto '
          'then adminConfig becomes null due to isEmpty normalization', () {
        // Given
        final original = TaleDto(
          id: 1,
          name: 'Original',
          createDate: createDate,
          updateDate: updateDate,
          summary: summaryMin,
          tags: {TaleTag.text},
          text: TextContentDto(
            items: [
              ContentItem.image(imageIndex: 0),
              ContentItem.text(text: 'Content'),
            ],
            minReadingTime: 1,
            maxReadingTime: 2,
          ),
          audio: null,
          crew: null,
          adminConfig: AdminConfigDto(
            isHidden: true,
            isReviewed: true,
            comment: 'Original config',
          ),
        );

        // When
        final copied = original.copyWith(adminConfig: AdminConfigDto());

        // Then
        expect(copied.adminConfig, isNull);
      });
    });
  });
}
