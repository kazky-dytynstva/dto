import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_dto.g.dart';

@JsonSerializable()
class RatingDto extends Equatable {
  RatingDto(this.taleId, this.amount, this.averageRating)
    : assert(taleId >= 0),
      assert(amount > 0),
      assert(averageRating > 0 && averageRating <= 5);

  @JsonKey(name: "id")
  final int taleId;
  final int amount;
  @JsonKey(name: "avg_rating")
  final double averageRating;

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      _$RatingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RatingDtoToJson(this);

  @override
  List<Object> get props => [taleId, amount, averageRating];
}
