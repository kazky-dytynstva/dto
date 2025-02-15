import 'package:json_annotation/json_annotation.dart';

enum PersonGenderDto {
  @JsonValue('female')
  female,
  @JsonValue('male')
  male,
}
