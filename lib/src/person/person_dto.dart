import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_dto.g.dart';

@JsonSerializable(
  createToJson: false,
)
class PersonDto extends Equatable {
  final int id;
  final String name;
  final String? url;
  final String? info;

  PersonDto({
    required this.id,
    required this.name,
    this.url,
    this.info,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        url,
        info,
      ];
}
