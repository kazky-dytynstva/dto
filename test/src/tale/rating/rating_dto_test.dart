import 'package:dto/dto.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

import '../../../test_data/test_data.dart';

void main() {
  final taleRating = getRating();

  test('GIVEN instance THEN verify it is equatable', () {
    expect(taleRating, isA<Equatable>());
  });

  test('GIVEN instance THEN verify all props correct', () {
    const props = [
      ratingTaleId,
      ratingAmount,
      ratingAvg,
    ];
    expect(taleRating.props, equals(props));
  });

  test('GIVEN same params and 2 instances THEN objects are equal', () {
    const taleRatingId = 124;
    const amount = 2048;
    const avgRating = 1.234;

    final instanceOne = getRating(
      taleRatingId: taleRatingId,
      amount: amount,
      avgRating: avgRating,
    );
    final instanceTwo = getRating(
      taleRatingId: taleRatingId,
      avgRating: avgRating,
      amount: amount,
    );

    expect(instanceOne, equals(instanceTwo));
  });

  test('GIVEN json with min params THEN parsed correctly', () {
    final dto = RatingDto.fromJson(ratingJson);
    expect(dto, equals(taleRating));
  });

  test('GIVEN id less than 0 THEN throw exception', () {
    expect(
      () => getRating(taleRatingId: -1),
      throwsA(isA<AssertionError>()),
    );
  });

  test('GIVEN amount 0 or less THEN throw exception', () {
    expect(
      () => getRating(amount: 0),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => getRating(amount: -1),
      throwsA(isA<AssertionError>()),
    );
  });

  test('GIVEN avg rating 0 or less THEN throw exception', () {
    expect(
      () => getRating(avgRating: 0),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => getRating(avgRating: -0.01),
      throwsA(isA<AssertionError>()),
    );
  });

  test('GIVEN avg rating greater than 5 THEN throw exception', () {
    expect(
      () => getRating(avgRating: 5.01),
      throwsA(isA<AssertionError>()),
    );
  });

  test('GIVEN instance WHEN call toJson THEN map correctly', () {
    final instance = getRating();
    expect(instance.toJson(), equals(ratingJson));
  });
}
