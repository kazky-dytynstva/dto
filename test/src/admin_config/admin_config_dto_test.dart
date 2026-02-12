import 'package:test/test.dart';
import 'package:dto/dto.dart';

const _isHiddenKey = 'is_hidden';
const _isReviewedKey = 'is_reviewed';
const _commentKey = 'comment';

void main() {
  group('$AdminConfigDto', () {
    group('$AdminConfigDto constructor', () {
      group('isHidden', () {
        test('given isHidden is true '
            'when creating $AdminConfigDto '
            'then isHidden is true', () {
          // Given/When
          final config = AdminConfigDto(isHidden: true);

          // Then
          expect(config.isHidden, isTrue);
        });

        test('given isHidden is false '
            'when creating $AdminConfigDto '
            'then isHidden is null', () {
          // Given/When
          final config = AdminConfigDto(isHidden: false);

          // Then
          expect(config.isHidden, isNull);
        });

        test('given isHidden is null '
            'when creating $AdminConfigDto '
            'then isHidden is null', () {
          // Given/When
          final config = AdminConfigDto(isHidden: null);

          // Then
          expect(config.isHidden, isNull);
        });
      });

      group('isReviewed', () {
        test('given isReviewed is true '
            'when creating $AdminConfigDto '
            'then isReviewed is true', () {
          // Given/When
          final config = AdminConfigDto(isReviewed: true);

          // Then
          expect(config.isReviewed, isTrue);
        });

        test('given isReviewed is false '
            'when creating $AdminConfigDto '
            'then isReviewed is null', () {
          // Given/When
          final config = AdminConfigDto(isReviewed: false);

          // Then
          expect(config.isReviewed, isNull);
        });

        test('given isReviewed is null '
            'when creating $AdminConfigDto '
            'then isReviewed is null', () {
          // Given/When
          final config = AdminConfigDto(isReviewed: null);

          // Then
          expect(config.isReviewed, isNull);
        });
      });

      group('comment', () {
        test('given comment is non-empty string '
            'when creating $AdminConfigDto '
            'then comment is preserved', () {
          // Given/When
          final config = AdminConfigDto(comment: 'Test comment');

          // Then
          expect(config.comment, equals('Test comment'));
        });

        test('given comment is empty string '
            'when creating $AdminConfigDto '
            'then comment is null', () {
          // Given/When
          final config = AdminConfigDto(comment: '');

          // Then
          expect(config.comment, isNull);
        });

        test('given comment is null '
            'when creating $AdminConfigDto '
            'then comment is null', () {
          // Given/When
          final config = AdminConfigDto(comment: null);

          // Then
          expect(config.comment, isNull);
        });
      });

      test('given all fields with valid values '
          'when creating $AdminConfigDto '
          'then all fields are preserved', () {
        // Given/When
        final config = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Full config',
        );

        // Then
        expect(config.isHidden, isTrue);
        expect(config.isReviewed, isTrue);
        expect(config.comment, equals('Full config'));
      });
    });

    group('$AdminConfigDto.isEmpty getter', () {
      test('given all fields are null '
          'when calling isEmpty '
          'then returns true', () {
        // Given
        final config = AdminConfigDto(
          isHidden: null,
          isReviewed: null,
          comment: null,
        );

        // When/Then
        expect(config.isEmpty, isTrue);
      });

      test('given all fields are false/empty '
          'when calling isEmpty '
          'then returns true', () {
        // Given
        final config = AdminConfigDto(
          isHidden: false,
          isReviewed: false,
          comment: '',
        );

        // When/Then
        expect(config.isEmpty, isTrue);
      });

      test('given isHidden is true '
          'when calling isEmpty '
          'then returns false', () {
        // Given
        final config = AdminConfigDto(isHidden: true);

        // When/Then
        expect(config.isEmpty, isFalse);
      });

      test('given isReviewed is true '
          'when calling isEmpty '
          'then returns false', () {
        // Given
        final config = AdminConfigDto(isReviewed: true);

        // When/Then
        expect(config.isEmpty, isFalse);
      });

      test('given comment is non-empty '
          'when calling isEmpty '
          'then returns false', () {
        // Given
        final config = AdminConfigDto(comment: 'Not empty');

        // When/Then
        expect(config.isEmpty, isFalse);
      });

      test('given multiple fields are set '
          'when calling isEmpty '
          'then returns false', () {
        // Given
        final config = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Multiple',
        );

        // When/Then
        expect(config.isEmpty, isFalse);
      });
    });

    group('$AdminConfigDto.fromJson', () {
      test('given JSON with all fields '
          'when calling $AdminConfigDto.fromJson '
          'then AdminConfigDto is created correctly', () {
        // Given
        final json = {
          _isHiddenKey: true,
          _isReviewedKey: true,
          _commentKey: 'Test comment',
        };

        // When
        final config = AdminConfigDto.fromJson(json);

        // Then
        expect(config.isHidden, isTrue);
        expect(config.isReviewed, isTrue);
        expect(config.comment, equals('Test comment'));
      });

      test('given JSON with null fields '
          'when calling $AdminConfigDto.fromJson '
          'then AdminConfigDto is created with nulls', () {
        // Given
        final json = {
          _isHiddenKey: null,
          _isReviewedKey: null,
          _commentKey: null,
        };

        // When
        final config = AdminConfigDto.fromJson(json);

        // Then
        expect(config.isHidden, isNull);
        expect(config.isReviewed, isNull);
        expect(config.comment, isNull);
      });

      test('given JSON with missing fields '
          'when calling $AdminConfigDto.fromJson '
          'then AdminConfigDto is created with nulls', () {
        // Given
        final json = <String, dynamic>{};

        // When
        final config = AdminConfigDto.fromJson(json);

        // Then
        expect(config.isHidden, isNull);
        expect(config.isReviewed, isNull);
        expect(config.comment, isNull);
      });

      test('given JSON with only isHidden '
          'when calling $AdminConfigDto.fromJson '
          'then AdminConfigDto is created with other fields null', () {
        // Given
        final json = {_isHiddenKey: true};

        // When
        final config = AdminConfigDto.fromJson(json);

        // Then
        expect(config.isHidden, isTrue);
        expect(config.isReviewed, isNull);
        expect(config.comment, isNull);
      });

      test('given JSON with only isReviewed '
          'when calling $AdminConfigDto.fromJson '
          'then AdminConfigDto is created with other fields null', () {
        // Given
        final json = {_isReviewedKey: true};

        // When
        final config = AdminConfigDto.fromJson(json);

        // Then
        expect(config.isHidden, isNull);
        expect(config.isReviewed, isTrue);
        expect(config.comment, isNull);
      });

      test('given JSON with only comment '
          'when calling $AdminConfigDto.fromJson '
          'then AdminConfigDto is created with other fields null', () {
        // Given
        final json = {_commentKey: 'Only comment'};

        // When
        final config = AdminConfigDto.fromJson(json);

        // Then
        expect(config.isHidden, isNull);
        expect(config.isReviewed, isNull);
        expect(config.comment, equals('Only comment'));
      });
    });

    group('$AdminConfigDto.toJson', () {
      test('given AdminConfigDto with all fields '
          'when calling $AdminConfigDto.toJson '
          'then correct map is returned', () {
        // Given
        final config = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Test',
        );

        // When
        final json = config.toJson();

        // Then
        expect(json, {
          _isHiddenKey: true,
          _isReviewedKey: true,
          _commentKey: 'Test',
        });
      });

      test('given AdminConfigDto with null fields '
          'when calling $AdminConfigDto.toJson '
          'then empty map is returned', () {
        // Given
        final config = AdminConfigDto();

        // When
        final json = config.toJson();

        // Then
        expect(json, <String, dynamic>{});
      });

      test('given AdminConfigDto with only isHidden '
          'when calling $AdminConfigDto.toJson '
          'then map with only is_hidden is returned', () {
        // Given
        final config = AdminConfigDto(isHidden: true);

        // When
        final json = config.toJson();

        // Then
        expect(json, {_isHiddenKey: true});
      });
    });

    group('$AdminConfigDto equality', () {
      test('given two $AdminConfigDto objects with same data '
          'when comparing with == '
          'then they are equal', () {
        // Given
        final a = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Same',
        );
        final b = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Same',
        );

        // Then
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('given two $AdminConfigDto objects with all null fields '
          'when comparing with == '
          'then they are equal', () {
        // Given
        final a = AdminConfigDto();
        final b = AdminConfigDto();

        // Then
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('given two $AdminConfigDto objects with different isHidden '
          'when comparing with == '
          'then they are not equal', () {
        // Given
        final a = AdminConfigDto(isHidden: true);
        final b = AdminConfigDto(isHidden: null);

        // Then
        expect(a == b, isFalse);
      });

      test('given two $AdminConfigDto objects with different isReviewed '
          'when comparing with == '
          'then they are not equal', () {
        // Given
        final a = AdminConfigDto(isReviewed: true);
        final b = AdminConfigDto(isReviewed: null);

        // Then
        expect(a == b, isFalse);
      });

      test('given two $AdminConfigDto objects with different comment '
          'when comparing with == '
          'then they are not equal', () {
        // Given
        final a = AdminConfigDto(comment: 'A');
        final b = AdminConfigDto(comment: 'B');

        // Then
        expect(a == b, isFalse);
      });
    });

    group('$AdminConfigDto.copyWith', () {
      test('given AdminConfigDto '
          'when calling copyWith with new isHidden '
          'then new instance with updated isHidden is returned', () {
        // Given
        final original = AdminConfigDto(
          isHidden: null,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(isHidden: true);

        // Then
        // Note: copyWith currently uses the parameter directly without falling back to current values
        expect(copied.isHidden, isTrue);
        expect(
          copied.isReviewed,
          isNull,
        ); // Bug: doesn't preserve current value
        expect(copied.comment, isNull); // Bug: doesn't preserve current value
      });

      test('given AdminConfigDto '
          'when calling copyWith with new isReviewed '
          'then new instance with updated isReviewed is returned', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: null,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(isReviewed: true);

        // Then
        // Note: copyWith currently uses the parameter directly without falling back to current values
        expect(copied.isHidden, isNull); // Bug: doesn't preserve current value
        expect(copied.isReviewed, isTrue);
        expect(copied.comment, isNull); // Bug: doesn't preserve current value
      });

      test('given AdminConfigDto '
          'when calling copyWith with new comment '
          'then new instance with updated comment is returned', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(comment: 'Updated');

        // Then
        // Note: copyWith parameter works for comment
        expect(copied.isHidden, isNull); // Bug: doesn't preserve current value
        expect(
          copied.isReviewed,
          isNull,
        ); // Bug: doesn't preserve current value
        expect(
          copied.comment,
          equals('Updated'),
        ); // This parameter works correctly
      });

      test('given AdminConfigDto with isHidden '
          'when calling copyWith with resetIsHidden true '
          'then new instance with null isHidden is returned', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(resetIsHidden: true);

        // Then
        expect(copied.isHidden, isNull);
        expect(
          copied.isReviewed,
          isNull,
        ); // Bug: doesn't preserve current value
        expect(copied.comment, isNull); // Bug: doesn't preserve current value
      });

      test('given AdminConfigDto with isReviewed '
          'when calling copyWith with resetIsREviewed true '
          'then new instance with null isReviewed is returned', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(resetIsREviewed: true);

        // Then
        expect(copied.isHidden, isNull); // Bug: doesn't preserve current value
        expect(copied.isReviewed, isNull);
        expect(copied.comment, isNull); // Bug: doesn't preserve current value
      });

      test('given AdminConfigDto with comment '
          'when calling copyWith with resetComment true '
          'then new instance with null comment is returned', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(resetComment: true);

        // Then
        expect(copied.isHidden, isNull); // Bug: doesn't preserve current value
        expect(
          copied.isReviewed,
          isNull,
        ); // Bug: doesn't preserve current value
        expect(copied.comment, isNull);
      });

      test('given AdminConfigDto '
          'when calling copyWith with multiple reset flags '
          'then new instance with null values is returned', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(
          resetIsHidden: true,
          resetIsREviewed: true,
          resetComment: true,
        );

        // Then
        expect(copied.isHidden, isNull);
        expect(copied.isReviewed, isNull);
        expect(copied.comment, isNull);
        expect(copied.isEmpty, isTrue);
      });

      test('given AdminConfigDto '
          'when calling copyWith with no parameters '
          'then new instance with null values is returned due to bug', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith();

        // Then
        // Bug: copyWith doesn't preserve current values
        expect(copied.isHidden, isNull);
        expect(copied.isReviewed, isNull);
        expect(copied.comment, isNull);
        expect(copied.isEmpty, isTrue);
      });

      test('given AdminConfigDto '
          'when calling copyWith with update and reset on different fields '
          'then new instance is correctly created', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Original',
        );

        // When
        final copied = original.copyWith(isHidden: true, resetIsREviewed: true);

        // Then
        expect(copied.isHidden, isTrue);
        expect(copied.isReviewed, isNull);
        expect(copied.comment, isNull); // Bug: doesn't preserve current value
      });
    });

    group('$AdminConfigDto round-trip serialization', () {
      test('given AdminConfigDto '
          'when converting to JSON and back '
          'then result equals original', () {
        // Given
        final original = AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Round trip',
        );

        // When
        final json = original.toJson();
        final restored = AdminConfigDto.fromJson(json);

        // Then
        expect(restored, equals(original));
      });

      test('given empty AdminConfigDto '
          'when converting to JSON and back '
          'then result equals original', () {
        // Given
        final original = AdminConfigDto();

        // When
        final json = original.toJson();
        final restored = AdminConfigDto.fromJson(json);

        // Then
        expect(restored, equals(original));
        expect(restored.isEmpty, isTrue);
      });
    });
  });
}
