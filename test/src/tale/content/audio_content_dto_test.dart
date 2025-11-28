import 'package:test/test.dart';
import 'package:dto/src/tale/content/audio_content_dto.dart';
import '../../../utils/throws_assert_error_with_message.dart';

void main() {
  group(
    '$AudioContentDto',
    () {
      test(
        'given valid data '
        'when serializing and deserializing $AudioContentDto '
        'then the object remains consistent',
        () {
          // Given
          final audioContent = AudioContentDto(
            fileSize: 1024,
            duration: Duration(seconds: 120),
          );

          // When
          final json = audioContent.toJson();
          final deserialized = AudioContentDto.fromJson(json);

          // Then
          expect(deserialized, equals(audioContent));
        },
      );

      test(
        'given file size is negative '
        'when creating $AudioContentDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => AudioContentDto(
              fileSize: -1,
              duration: Duration(seconds: 100),
            ),
            throwsAssertErrorWithMessage('File size should be positive'),
          );
        },
      );

      test(
        'given file size is zero '
        'when creating $AudioContentDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => AudioContentDto(
              fileSize: 0,
              duration: Duration(seconds: 100),
            ),
            throwsAssertErrorWithMessage('File size should be positive'),
          );
        },
      );

      test(
        'given duration is negative '
        'when creating $AudioContentDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => AudioContentDto(
              fileSize: 100,
              duration: Duration(milliseconds: -1),
            ),
            throwsAssertErrorWithMessage('Duration should be positive'),
          );
        },
      );

      test(
        'given duration is zero '
        'when creating $AudioContentDto '
        'then an AssertionError with a specific message is thrown',
        () {
          // Given, When, Then
          expect(
            () => AudioContentDto(
              fileSize: 100,
              duration: Duration.zero,
            ),
            throwsAssertErrorWithMessage('Duration should be positive'),
          );
        },
      );

      test(
        'given valid data '
        'when accessing fields of $AudioContentDto '
        'then the fields return correct values',
        () {
          // Given
          final audioContent = AudioContentDto(
            fileSize: 1024,
            duration: Duration(seconds: 120),
          );

          // When, Then
          expect(audioContent.fileSize, equals(1024));
          expect(audioContent.duration, equals(Duration(seconds: 120)));
        },
      );
    },
  );
}
