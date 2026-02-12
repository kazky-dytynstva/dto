// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_config_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminConfigDto _$AdminConfigDtoFromJson(Map<String, dynamic> json) =>
    AdminConfigDto(
      isHidden: json['is_hidden'] as bool?,
      isReviewed: json['is_reviewed'] as bool?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$AdminConfigDtoToJson(AdminConfigDto instance) =>
    <String, dynamic>{
      'is_hidden': ?instance.isHidden,
      'is_reviewed': ?instance.isReviewed,
      'comment': ?instance.comment,
    };
