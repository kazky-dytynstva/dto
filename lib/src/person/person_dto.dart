import 'package:dto/src/id_holder.dart';
import 'package:dto/src/person/person_gender_dto.dart';
import 'package:dto/src/person/person_role_dto.dart';
import 'package:dto/src/to_json_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_dto.g.dart';

@JsonSerializable()
class PersonDto extends Equatable implements ToJsonItem, IdHolder {
  @override
  final int id;
  final String name;
  final String surname;
  final PersonGenderDto gender;
  final String? url;
  final String? info;
  final List<PersonRoleDto>? roles;

  PersonDto({
    required this.id,
    required this.name,
    required this.surname,
    required this.gender,
    required this.url,
    required this.info,
    required this.roles,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) =>
      _$PersonDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PersonDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        gender,
        url,
        info,
        roles,
      ];
}
