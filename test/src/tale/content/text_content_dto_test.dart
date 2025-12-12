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
        items: [
          ContentItem.image(imageIndex: 0),
          ContentItem.text(text: 'ContentItem 1'),
          ContentItem.text(text: 'ContentItem 2'),
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

    test('given empty items '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(items: [], minReadingTime: 5, maxReadingTime: 10),
        throwsAssertErrorWithMessage('Items should contain more than 1 item'),
      );
    });

    test('given only 1 item '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          items: [ContentItem.image(imageIndex: 0)],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage('Items should contain more than 1 item'),
      );
    });

    test('given min reading time is zero '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          items: [
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'ContentItem 1'),
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
          items: [
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'ContentItem 1'),
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
          items: [
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'ContentItem 1'),
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
          items: [
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'ContentItem 1'),
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
        items: [
          ContentItem.image(imageIndex: 0),
          ContentItem.text(text: 'ContentItem 1'),
          ContentItem.text(text: 'ContentItem 2'),
        ],
        minReadingTime: 5,
        maxReadingTime: 10,
      );

      // When, Then
      expect(
        textContent.items,
        equals([
          ContentItem.image(imageIndex: 0),
          ContentItem.text(text: 'ContentItem 1'),
          ContentItem.text(text: 'ContentItem 2'),
        ]),
      );
      expect(textContent.minReadingTime, equals(5));
      expect(textContent.maxReadingTime, equals(10));
    });

    test('given first item is not an image '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          items: [
            ContentItem.text(text: 'ContentItem 1'),
            ContentItem.image(imageIndex: 0),
          ],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage(
          'First item should be an image with index 0',
        ),
      );
    });

    test('given first item is an image but not with index 0 '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          items: [
            ContentItem.image(imageIndex: 1),
            ContentItem.text(text: 'ContentItem 1'),
          ],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage(
          'First item should be an image with index 0',
        ),
      );
    });

    test('given image indexes are not sequential '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          items: [
            ContentItem.image(imageIndex: 0),
            ContentItem.text(text: 'Text'),
            ContentItem.image(imageIndex: 5),
            ContentItem.text(text: 'Text 2'),
          ],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage(
          'Image indexes should be sequential starting from 0',
        ),
      );
    });

    test('given image indexes skip a number '
        'when creating $TextContentDto '
        'then an AssertionError with a specific message is thrown', () {
      // Given, When, Then
      expect(
        () => TextContentDto(
          items: [
            ContentItem.image(imageIndex: 0),
            ContentItem.image(imageIndex: 1),
            ContentItem.image(imageIndex: 3),
          ],
          minReadingTime: 5,
          maxReadingTime: 10,
        ),
        throwsAssertErrorWithMessage(
          'Image indexes should be sequential starting from 0',
        ),
      );
    });

    test('given image indexes are sequential '
        'when creating $TextContentDto '
        'then the object is created successfully', () {
      // Given, When, Then
      final textContent = TextContentDto(
        items: [
          ContentItem.image(imageIndex: 0),
          ContentItem.text(text: 'Text 1'),
          ContentItem.image(imageIndex: 1),
          ContentItem.text(text: 'Text 2'),
          ContentItem.image(imageIndex: 2),
        ],
        minReadingTime: 5,
        maxReadingTime: 10,
      );

      expect(textContent.items.length, equals(5));
    });
  });
}
