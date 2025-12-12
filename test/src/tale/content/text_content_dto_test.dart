import 'package:test/test.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import '../../../utils/throws_assert_error_with_message.dart';

void main() {
  group('$TextContentDto', () {
    test('given valid data '
        'when serializing and deserializing $TextContentDto '
        'then the object remains consistent', () {
      // Given
      final textContent = TextContentDto(
        paragraphs: [
          Paragraph.image(imageIndex: 0),
          Paragraph.text(text: 'Paragraph 1'),
          Paragraph.text(text: 'Paragraph 2'),
        ],
        minReadingTime: 5,
        maxReadingTime: 10,
      );

      // When
      final json = textContent.toJson();
      final deserialized = TextContentDto.fromJson(json);

      // Then
      expect(deserialized, equals(textContent));
    });

    test('given empty paragraphs '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          paragraphs: [],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage('Paragraphs should not be empty'),
      );
    });

    test('given min reading time is zero '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          paragraphs: [
            Paragraph.image(imageIndex: 0),
            Paragraph.text(text: 'Paragraph 1'),
          ],
          minReadingTime: 0,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage('Min reading time should be positive'),
      );
    });

    test('given min reading time is negative '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          paragraphs: [
            Paragraph.image(imageIndex: 0),
            Paragraph.text(text: 'Paragraph 1'),
          ],
          minReadingTime: -1,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage('Min reading time should be positive'),
      );
    });

    test('given max reading time is less than or equal to min reading time '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          paragraphs: [
            Paragraph.image(imageIndex: 0),
            Paragraph.text(text: 'Paragraph 1'),
          ],
          minReadingTime: 5,
          maxReadingTime: 5,
        ),
        throwsAssertErrorWithMessage(
          'Max reading time should be greater than min reading time',
        ),
      );

      expect(
        () => TextContentDto(
          paragraphs: [
            Paragraph.image(imageIndex: 0),
            Paragraph.text(text: 'Paragraph 1'),
          ],
          minReadingTime: 5,
          maxReadingTime: 4,
        ),
        throwsAssertErrorWithMessage(
          'Max reading time should be greater than min reading time',
        ),
      );
    });

    test('given valid data '
        'when accessing fields of $TextContentDto '
        'then the fields return correct values', () {
      // Given
      final textContent = TextContentDto(
        paragraphs: [
          Paragraph.image(imageIndex: 0),
          Paragraph.text(text: 'Paragraph 1'),
          Paragraph.text(text: 'Paragraph 2'),
        ],
        minReadingTime: 5,
        maxReadingTime: 10,
      );

      // When, Then
      expect(
        textContent.paragraphs,
        equals([
          Paragraph.image(imageIndex: 0),
          Paragraph.text(text: 'Paragraph 1'),
          Paragraph.text(text: 'Paragraph 2'),
        ]),
      );
      expect(textContent.minReadingTime, equals(5));
      expect(textContent.maxReadingTime, equals(10));
    });

    test('given first paragraph is not an image '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          paragraphs: [
            Paragraph.text(text: 'Paragraph 1'),
            Paragraph.image(imageIndex: 0),
          ],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage(
          'First paragraph should be an image with index 0',
        ),
      );
    });

    test('given first paragraph is an image but not with index 0 '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          paragraphs: [
            Paragraph.image(imageIndex: 1),
            Paragraph.text(text: 'Paragraph 1'),
          ],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage(
          'First paragraph should be an image with index 0',
        ),
      );
    });
  });
}
