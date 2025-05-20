import 'package:dto/src/tale/content/audio_content_dto.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';
import 'package:test/test.dart';
import 'package:dto/src/tale/tale_dto.dart';

import '../../utils/throws_assert_error_with_message.dart';

void main() {
  group('$TaleDto', () {
    group('constructor asserts', () {
      test(
        'given id is negative '
        'when creating $TaleDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => TaleDto(
              id: -1,
              name: 'Valid Name',
              createDate: 1620000000000,
              updateDate: 1620003600000,
              summary: 'Valid Summary',
              tags: {TaleTag.text},
              text: TextContentDto(
                paragraphs: ['Paragraph 1'],
                minReadingTime: 5,
                maxReadingTime: 10,
              ),
              audio: null,
              crew: null,
              ignore: false,
            ),
            throwsAssertErrorWithMessage('Tale id should be positive'),
          );
        },
      );

      test(
        'given name is empty '
        'when creating $TaleDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => TaleDto(
              id: 1,
              name: '',
              createDate: 1620000000000,
              updateDate: 1620003600000,
              summary: 'Valid Summary',
              tags: {TaleTag.text},
              text: TextContentDto(
                paragraphs: ['Paragraph 1'],
                minReadingTime: 5,
                maxReadingTime: 10,
              ),
              audio: null,
              crew: null,
              ignore: false,
            ),
            throwsAssertErrorWithMessage('Tale name should NOT be empty'),
          );
        },
      );

      test(
        'given updateDate is before createDate '
        'when creating $TaleDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => TaleDto(
              id: 1,
              name: 'Valid Name',
              createDate: 1620003600000,
              updateDate: 1620000000000,
              summary: 'Valid Summary',
              tags: {TaleTag.text},
              text: TextContentDto(
                paragraphs: ['Paragraph 1'],
                minReadingTime: 5,
                maxReadingTime: 10,
              ),
              audio: null,
              crew: null,
              ignore: false,
            ),
            throwsAssertErrorWithMessage(
                'updateDate can NOT be before createDate'),
          );
        },
      );

      test(
        'given tags is empty '
        'when creating $TaleDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => TaleDto(
              id: 1,
              name: 'Valid Name',
              createDate: 1620000000000,
              updateDate: 1620003600000,
              summary: 'Valid Summary',
              tags: {},
              text: null,
              audio: null,
              crew: null,
              ignore: false,
            ),
            throwsAssertErrorWithMessage('There should be at least one tag'),
          );
        },
      );

      test(
        'given summary is empty '
        'when creating $TaleDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => TaleDto(
              id: 1,
              name: 'Valid Name',
              createDate: 1620000000000,
              updateDate: 1620003600000,
              summary: '',
              tags: {TaleTag.text},
              text: TextContentDto(
                paragraphs: ['Paragraph 1'],
                minReadingTime: 5,
                maxReadingTime: 10,
              ),
              audio: null,
              crew: null,
              ignore: false,
            ),
            throwsAssertErrorWithMessage('Tale summary should NOT be empty'),
          );
        },
      );

      test(
        'given tags contain text but text content is null '
        'when creating $TaleDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => TaleDto(
              id: 1,
              name: 'Valid Name',
              createDate: 1620000000000,
              updateDate: 1620003600000,
              summary: 'Valid Summary',
              tags: {TaleTag.text},
              text: null,
              audio: null,
              crew: null,
              ignore: false,
            ),
            throwsAssertErrorWithMessage(
                'Text content should be present if and only if the tale has a TaleTag.text tag'),
          );
        },
      );

      test(
        'given tags contain audio but audio content is null '
        'when creating $TaleDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => TaleDto(
              id: 1,
              name: 'Valid Name',
              createDate: 1620000000000,
              updateDate: 1620003600000,
              summary: 'Valid Summary',
              tags: {TaleTag.audio},
              text: null,
              audio: null,
              crew: null,
              ignore: false,
            ),
            throwsAssertErrorWithMessage(
                'Audio content should be present if and only if the tale has a TaleTag.audio tag'),
          );
        },
      );
    });

    group('factory fromJson', () {
      test(
        'given valid JSON '
        'when deserializing $TaleDto '
        'then the object is created successfully',
        () {
          // Given
          final validJson = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': 1620000000000,
            'update_date': 1620003600000,
            'summary': 'A short summary',
            'tags': ['text'],
            'text': {
              'paragraphs': ['Paragraph 1', 'Paragraph 2'],
              'min_reading_time': 5,
              'max_reading_time': 10,
            },
            'audio': null,
            'crew': null,
            'ignore': false,
          };

          // When
          final tale = TaleDto.fromJson(validJson);

          // Then
          expect(tale.id, equals(1));
          expect(tale.name, equals('Tale Name'));
          expect(tale.createDate, equals(1620000000000));
          expect(tale.updateDate, equals(1620003600000));
          expect(tale.summary, equals('A short summary'));
          expect(tale.tags, equals({TaleTag.text}));
          expect(tale.text?.paragraphs, equals(['Paragraph 1', 'Paragraph 2']));
          expect(tale.text?.minReadingTime, equals(5));
          expect(tale.text?.maxReadingTime, equals(10));
          expect(tale.audio, isNull);
          expect(tale.crew, isNull);
          expect(tale.ignore, isFalse);
        },
      );

      test(
        'given JSON with missing required fields '
        'when deserializing $TaleDto '
        'then an error is thrown',
        () {
          // Given
          final invalidJson = {
            'name': 'Tale Name',
            'create_date': 1620000000000,
          };

          // When, Then
          expect(
            () => TaleDto.fromJson(invalidJson),
            throwsA(isA<Error>()),
          );
        },
      );

      test(
        'given JSON with invalid data types '
        'when deserializing $TaleDto '
        'then an error is thrown',
        () {
          // Given
          final invalidJson = {
            'id': 'invalid_id',
            'name': 'Tale Name',
            'create_date': 1620000000000,
            'update_date': 1620003600000,
            'tags': [],
          };

          // When, Then
          expect(
            () => TaleDto.fromJson(invalidJson),
            throwsA(isA<Error>()),
          );
        },
      );

      test(
        'given JSON with extra fields '
        'when deserializing $TaleDto '
        'then the extra fields are ignored',
        () {
          // Given
          final jsonWithExtraFields = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': 1620000000000,
            'update_date': 1620003600000,
            'summary': 'A short summary',
            'tags': ['text'],
            'text': {
              'paragraphs': ['Paragraph 1', 'Paragraph 2'],
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
          expect(tale.createDate, equals(1620000000000));
          expect(tale.updateDate, equals(1620003600000));
          expect(tale.summary, equals('A short summary'));
          expect(tale.tags, equals({TaleTag.text}));
          expect(tale.text?.paragraphs, equals(['Paragraph 1', 'Paragraph 2']));
          expect(tale.text?.minReadingTime, equals(5));
          expect(tale.text?.maxReadingTime, equals(10));
        },
      );

      test(
        'given JSON with null optional fields '
        'when deserializing $TaleDto '
        'then the object is created successfully',
        () {
          // Given
          final jsonWithNullFields = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': 1620000000000,
            'update_date': 1620003600000,
            'summary': 'A short summary',
            'tags': ['text'],
            'text': {
              'paragraphs': ['Paragraph 1', 'Paragraph 2'],
              'min_reading_time': 5,
              'max_reading_time': 10,
            },
            'audio': null,
            'crew': null,
            'ignore': null,
          };

          // When
          final tale = TaleDto.fromJson(jsonWithNullFields);

          // Then
          expect(tale.id, equals(1));
          expect(tale.name, equals('Tale Name'));
          expect(tale.createDate, equals(1620000000000));
          expect(tale.updateDate, equals(1620003600000));
          expect(tale.summary, equals('A short summary'));
          expect(tale.tags, equals({TaleTag.text}));
          expect(tale.text?.paragraphs, equals(['Paragraph 1', 'Paragraph 2']));
          expect(tale.text?.minReadingTime, equals(5));
          expect(tale.text?.maxReadingTime, equals(10));
          expect(tale.audio, isNull);
          expect(tale.crew, isNull);
          expect(tale.ignore, isNull);
        },
      );
    });

    group('factory fromSupaJson', () {
      final createDate = DateTime.now();
      final updateDate = createDate.add(const Duration(hours: 1));

      test(
        'given valid Supabase JSON '
        'when deserializing $TaleDto '
        'then the object is created successfully',
        () {
          // Given
          final validSupaJson = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'A short summary',
            'tags': ['text', 'audio'],
            'paragraphs': ['Paragraph 1', 'Paragraph 2'],
            'min_reading_time': 5,
            'max_reading_time': 10,
            'audio_file_size': 42,
            'audio_duration': 120,
            'audio': null,
            'crew': null,
            'ignore': false,
          };

          // When
          final tale = TaleDto.fromSupaJson(validSupaJson);

          // Then
          expect(tale.id, equals(1));
          expect(tale.name, equals('Tale Name'));
          expect(tale.createDate, equals(createDate.millisecondsSinceEpoch));
          expect(tale.updateDate, equals(updateDate.millisecondsSinceEpoch));
          expect(tale.summary, equals('A short summary'));
          expect(tale.tags, equals({TaleTag.text, TaleTag.audio}));
          expect(tale.text?.paragraphs, equals(['Paragraph 1', 'Paragraph 2']));
          expect(tale.text?.minReadingTime, equals(5));
          expect(tale.text?.maxReadingTime, equals(10));
          expect(tale.audio?.fileSize, equals(42));
          expect(tale.audio?.duration, equals(120));
          expect(tale.crew, isNull);
          expect(tale.ignore, isFalse);
        },
      );

      test(
        'given Supabase JSON with missing required fields '
        'when deserializing $TaleDto '
        'then an error is thrown',
        () {
          // Given
          final invalidSupaJson = {
            'name': 'Tale Name',
            'create_date': 1620000000000,
          };

          // When, Then
          expect(
            () => TaleDto.fromSupaJson(invalidSupaJson),
            throwsA(isA<Error>()),
          );
        },
      );

      test(
        'given Supabase JSON with invalid data types '
        'when deserializing $TaleDto '
        'then an error is thrown',
        () {
          // Given
          final invalidSupaJson = {
            'id': 'invalid_id',
            'name': 'Tale Name',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'tags': [],
          };

          // When, Then
          expect(
            () => TaleDto.fromSupaJson(invalidSupaJson),
            throwsA(isA<Error>()),
          );
        },
      );

      test(
        'given Supabase JSON with extra fields '
        'when deserializing $TaleDto '
        'then the extra fields are ignored',
        () {
          // Given
          final supaJsonWithExtraFields = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'A short summary',
            'tags': ['text'],
            'paragraphs': ['Paragraph 1', 'Paragraph 2'],
            'min_reading_time': 5,
            'max_reading_time': 10,
            'extra_field': 'unexpected',
          };

          // When
          final tale = TaleDto.fromSupaJson(supaJsonWithExtraFields);

          // Then
          expect(tale.id, equals(1));
          expect(tale.name, equals('Tale Name'));
          expect(tale.createDate, equals(createDate.millisecondsSinceEpoch));
          expect(tale.updateDate, equals(updateDate.millisecondsSinceEpoch));
          expect(tale.summary, equals('A short summary'));
          expect(tale.tags, equals({TaleTag.text}));
          expect(tale.text?.paragraphs, equals(['Paragraph 1', 'Paragraph 2']));
          expect(tale.text?.minReadingTime, equals(5));
          expect(tale.text?.maxReadingTime, equals(10));
        },
      );

      test(
        'given Supabase JSON with null optional fields '
        'when deserializing $TaleDto '
        'then the object is created successfully',
        () {
          // Given
          final supaJsonWithNullFields = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'A short summary',
            'tags': ['text'],
            'paragraphs': ['Paragraph 1', 'Paragraph 2'],
            'min_reading_time': 5,
            'max_reading_time': 10,
            'text': {},
            'audio': null,
            'crew': null,
            'ignore': null,
          };

          // When
          final tale = TaleDto.fromSupaJson(supaJsonWithNullFields);

          // Then
          expect(tale.id, equals(1));
          expect(tale.name, equals('Tale Name'));
          expect(tale.createDate, equals(createDate.millisecondsSinceEpoch));
          expect(tale.updateDate, equals(updateDate.millisecondsSinceEpoch));
          expect(tale.summary, equals('A short summary'));
          expect(tale.tags, equals({TaleTag.text}));
          expect(tale.text?.paragraphs, equals(['Paragraph 1', 'Paragraph 2']));
          expect(tale.text?.minReadingTime, equals(5));
          expect(tale.text?.maxReadingTime, equals(10));
          expect(tale.audio, isNull);
          expect(tale.crew, isNull);
          expect(tale.ignore, isNull);
        },
      );
    });

    group('toJson', () {
      test(
        'given all fields are present '
        'when calling toJson on $TaleDto '
        'then the resulting map contains all expected key-value pairs',
        () {
          // Given
          final tale = TaleDto(
            id: 1,
            name: 'Tale Name',
            createDate: 1620000000000,
            updateDate: 1620003600000,
            summary: 'Valid Summary',
            tags: {TaleTag.text},
            text: TextContentDto(
              paragraphs: ['Paragraph 1'],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: null,
            crew: null,
            ignore: null,
          );

          final expectedJson = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': 1620000000000,
            'update_date': 1620003600000,
            'summary': 'Valid Summary',
            'tags': ['text'],
            'text': {
              'paragraphs': ['Paragraph 1'],
              'min_reading_time': 5,
              'max_reading_time': 10,
            },
          };

          // When
          final json = tale.toJson();

          // Then
          expect(json, equals(expectedJson));
        },
      );

      test(
        'given only required fields are present '
        'when calling toJson on $TaleDto '
        'then the resulting map contains only required key-value pairs',
        () {
          // Given
          final tale = TaleDto(
            id: 2,
            name: 'Minimal Tale',
            createDate: 1620000000000,
            updateDate: 1620003600000,
            summary: 'Summary',
            tags: {TaleTag.text},
            text: TextContentDto(
              paragraphs: ['Only one'],
              minReadingTime: 1,
              maxReadingTime: 2,
            ),
            audio: null,
            crew: null,
          );

          final expectedJson = {
            'id': 2,
            'name': 'Minimal Tale',
            'create_date': 1620000000000,
            'update_date': 1620003600000,
            'summary': 'Summary',
            'tags': ['text'],
            'text': {
              'paragraphs': ['Only one'],
              'min_reading_time': 1,
              'max_reading_time': 2,
            },
          };

          // When
          final json = tale.toJson();

          // Then
          expect(json, equals(expectedJson));
        },
      );

      test(
        'given optional fields are null '
        'when calling toJson on $TaleDto '
        'then the resulting map contains null for those fields',
        () {
          // Given
          final tale = TaleDto(
            id: 3,
            name: 'Null Optionals',
            createDate: 1620000000000,
            updateDate: 1620003600000,
            summary: 'Summary',
            tags: {TaleTag.text},
            text: TextContentDto(
              paragraphs: ['A'],
              minReadingTime: 1,
              maxReadingTime: 2,
            ),
            audio: null,
            crew: null,
            ignore: null,
          );

          // When
          final json = tale.toJson();

          // Then
          expect(json['audio'], isNull);
          expect(json['crew'], isNull);
          expect(json['ignore'], isNull);
        },
      );

      test(
        'given $TaleDto with both text and audio tags and content '
        'when calling toJson '
        'then both text and audio fields are present in the map',
        () {
          // Given
          final tale = TaleDto(
            id: 4,
            name: 'Text and Audio',
            createDate: 1620000000000,
            updateDate: 1620003600000,
            summary: 'Summary',
            tags: {TaleTag.text, TaleTag.audio},
            text: TextContentDto(
              paragraphs: ['A'],
              minReadingTime: 1,
              maxReadingTime: 2,
            ),
            audio: AudioContentDto(
              fileSize: 123,
              duration: 456,
            ),
            crew: null,
            ignore: false,
          );
          final expectedAudioJson = {
            'file_size': 123,
            'duration': 456,
          };
          final expectedTextJson = {
            'paragraphs': ['A'],
            'min_reading_time': 1,
            'max_reading_time': 2,
          };

          // When
          final json = tale.toJson();

          // Then
          expect(json['text'], equals(expectedTextJson));
          expect(json['audio'], equals(expectedAudioJson));
        },
      );

      test(
        'given $TaleDto with crew '
        'when calling toJson '
        'then crew field is present in the map',
        () {
          // Given
          final tale = TaleDto(
            id: 5,
            name: 'With Crew',
            createDate: 1620000000000,
            updateDate: 1620003600000,
            summary: 'Summary',
            tags: {TaleTag.text},
            text: TextContentDto(
              paragraphs: ['A'],
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
            ignore: false,
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
        },
      );
    });

    group('toSupaJson', () {
      test(
        'given all fields are present\n'
        'when calling toSupaJson on $TaleDto\n'
        'then the resulting map contains all expected key-value pairs with ISO8601 dates',
        () {
          // Given
          final createDate = DateTime.fromMillisecondsSinceEpoch(1620000000000);
          final updateDate = DateTime.fromMillisecondsSinceEpoch(1620003600000);
          final tale = TaleDto(
            id: 1,
            name: 'Tale Name',
            createDate: createDate.millisecondsSinceEpoch,
            updateDate: updateDate.millisecondsSinceEpoch,
            summary: 'A short summary',
            tags: {TaleTag.text, TaleTag.audio},
            text: TextContentDto(
              paragraphs: ['Paragraph 1', 'Paragraph 2'],
              minReadingTime: 5,
              maxReadingTime: 10,
            ),
            audio: AudioContentDto(
              fileSize: 123,
              duration: 456,
            ),
            crew: CrewDto(
              authors: [1],
              readers: [2],
              musicians: [3],
              translators: [4],
              graphics: [5],
            ),
            ignore: true,
          );

          final expectedJson = {
            'id': 1,
            'name': 'Tale Name',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'A short summary',
            'tags': ['text', 'audio'],
            'paragraphs': ['Paragraph 1', 'Paragraph 2'],
            'min_reading_time': 5,
            'max_reading_time': 10,
            'audio_file_size': 123,
            'audio_duration': 456,
            'authors': [1],
            'readers': [2],
            'musicians': [3],
            'translators': [4],
            'graphics': [5],
            'ignore': true,
          };

          // When
          final json = tale.toSupaJsonItem();

          // Then
          expect(json, equals(expectedJson));
        },
      );

      test(
        'given only required fields are present\n'
        'when calling toSupaJson on $TaleDto\n'
        'then the resulting map contains only required key-value pairs',
        () {
          // Given
          final createDate = DateTime.fromMillisecondsSinceEpoch(1620000000000);
          final updateDate = DateTime.fromMillisecondsSinceEpoch(1620003600000);
          final tale = TaleDto(
            id: 2,
            name: 'Minimal Tale',
            createDate: createDate.millisecondsSinceEpoch,
            updateDate: updateDate.millisecondsSinceEpoch,
            summary: 'Summary',
            tags: {TaleTag.text},
            text: TextContentDto(
              paragraphs: ['Only one'],
              minReadingTime: 1,
              maxReadingTime: 2,
            ),
            audio: null,
            crew: null,
            ignore: null,
          );

          final expectedJson = {
            'id': 2,
            'name': 'Minimal Tale',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'Summary',
            'tags': ['text'],
            'paragraphs': ['Only one'],
            'min_reading_time': 1,
            'max_reading_time': 2,
          };

          // When
          final json = tale.toSupaJsonItem();

          // Then
          expect(json, equals(expectedJson));
        },
      );

      test(
        'given optional fields are null\n'
        'when calling toSupaJson on $TaleDto\n'
        'then the resulting map omits those fields',
        () {
          // Given
          final createDate = DateTime.fromMillisecondsSinceEpoch(1620000000000);
          final updateDate = DateTime.fromMillisecondsSinceEpoch(1620003600000);
          final tale = TaleDto(
            id: 3,
            name: 'Null Optionals',
            createDate: createDate.millisecondsSinceEpoch,
            updateDate: updateDate.millisecondsSinceEpoch,
            summary: 'Summary',
            tags: {TaleTag.text},
            text: TextContentDto(
              paragraphs: ['A'],
              minReadingTime: 1,
              maxReadingTime: 2,
            ),
            audio: null,
            crew: null,
            ignore: null,
          );

          final expectedJson = {
            'id': 3,
            'name': 'Null Optionals',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'Summary',
            'tags': ['text'],
            'paragraphs': ['A'],
            'min_reading_time': 1,
            'max_reading_time': 2,
          };

          // When
          final json = tale.toSupaJsonItem();

          // Then
          expect(json, equals(expectedJson));
        },
      );

      test(
        'given $TaleDto with both text and audio tags and content\n'
        'when calling toSupaJson\n'
        'then both text and audio fields are present in the map',
        () {
          // Given
          final createDate = DateTime.fromMillisecondsSinceEpoch(1620000000000);
          final updateDate = DateTime.fromMillisecondsSinceEpoch(1620003600000);
          final tale = TaleDto(
            id: 4,
            name: 'Text and Audio',
            createDate: createDate.millisecondsSinceEpoch,
            updateDate: updateDate.millisecondsSinceEpoch,
            summary: 'Summary',
            tags: {TaleTag.text, TaleTag.audio},
            text: TextContentDto(
              paragraphs: ['A'],
              minReadingTime: 1,
              maxReadingTime: 2,
            ),
            audio: AudioContentDto(
              fileSize: 123,
              duration: 456,
            ),
            crew: null,
            ignore: false,
          );

          final expectedJson = {
            'id': 4,
            'name': 'Text and Audio',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'Summary',
            'tags': ['text', 'audio'],
            'paragraphs': ['A'],
            'min_reading_time': 1,
            'max_reading_time': 2,
            'audio_file_size': 123,
            'audio_duration': 456,
            'ignore': false,
          };

          // When
          final json = tale.toSupaJsonItem();

          // Then
          expect(json, equals(expectedJson));
        },
      );

      test(
        'given $TaleDto with crew\n'
        'when calling toSupaJson\n'
        'then crew fields are present in the map',
        () {
          // Given
          final createDate = DateTime.fromMillisecondsSinceEpoch(1620000000000);
          final updateDate = DateTime.fromMillisecondsSinceEpoch(1620003600000);
          final tale = TaleDto(
            id: 5,
            name: 'With Crew',
            createDate: createDate.millisecondsSinceEpoch,
            updateDate: updateDate.millisecondsSinceEpoch,
            summary: 'Summary',
            tags: {TaleTag.text},
            text: TextContentDto(
              paragraphs: ['A'],
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
            ignore: null,
          );

          final expectedJson = {
            'id': 5,
            'name': 'With Crew',
            'create_date': createDate.toIso8601String(),
            'update_date': updateDate.toIso8601String(),
            'summary': 'Summary',
            'tags': ['text'],
            'paragraphs': ['A'],
            'min_reading_time': 1,
            'max_reading_time': 2,
            'authors': [1],
            'readers': [42],
            'musicians': [43, 42],
            'translators': [1, 2, 3, 4, 5, 6],
            'graphics': [1, 2, 3],
          };

          // When
          final json = tale.toSupaJsonItem();

          // Then
          expect(json, equals(expectedJson));
        },
      );
    });
  });
}
