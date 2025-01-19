import 'package:json_annotation/json_annotation.dart';

enum PersonRoleDto {
  @JsonValue('author')
  author,
  @JsonValue('reader')
  reader,
  @JsonValue('musician')
  musician,
  @JsonValue('graphic')
  graphic,
  @JsonValue('translator')
  translator,
  @JsonValue('crew')
  crew,
}
