import 'package:dto/dto.dart';

const ratingTaleId = 157;
const ratingAmount = 34;
const ratingAvg = 3.34;

const _keyId = "id";
const _keyAmount = "amount";
const _keyAvgRating = "avg_rating";

Map<String, dynamic> ratingJson = {
  _keyId: ratingTaleId,
  _keyAmount: ratingAmount,
  _keyAvgRating: ratingAvg,
};

RatingDto getRating({
  int taleRatingId = ratingTaleId,
  int amount = ratingAmount,
  double avgRating = ratingAvg,
}) =>
    RatingDto(
      taleRatingId,
      amount,
      avgRating,
    );
