// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingDto _$RatingDtoFromJson(Map<String, dynamic> json) => RatingDto(
      (json['id'] as num).toInt(),
      (json['amount'] as num).toInt(),
      (json['avg_rating'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingDtoToJson(RatingDto instance) => <String, dynamic>{
      'id': instance.taleId,
      'amount': instance.amount,
      'avg_rating': instance.averageRating,
    };
