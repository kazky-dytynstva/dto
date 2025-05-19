import 'package:dto/src/id_holder.dart';
import 'package:dto/src/person/person_gender_dto.dart';
import 'package:dto/src/person/person_role_dto.dart';
import 'package:dto/src/to_json_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_dto.g.dart';

@JsonSerializable()
class PersonDto extends Equatable implements ToJsonItem, IdHolder {
  PersonDto({
    required this.id,
    required this.name,
    required this.surname,
    required this.gender,
    required this.url,
    required this.info,
    required this.roles,
  })  : assert(
          id >= 0,
          'Person id should be positive',
        ),
        assert(
          name.isNotEmpty,
          'Person name should NOT be empty',
        ),
        assert(
          surname.isNotEmpty,
          'Person surname should NOT be empty',
        ),
        assert(
          roles == null || roles.isNotEmpty,
          'Person roles should NOT be empty',
        ),
        assert(
          roles == null || roles.length == roles.toSet().length,
          'Person roles should be unique',
        ),
        assert(
          url == null || Uri.tryParse(url) != null,
          'Person url should be a valid URL',
        );

  @override
  final int id;
  final String name;
  final String surname;
  final PersonGenderDto gender;
  final String? url;
  final String? info;
  final List<PersonRoleDto>? roles;

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

  factory PersonDto.fromSupaJson(Map<String, dynamic> json) {
    final dto = PersonDto.fromJson(json);

    final isCrew = json[_keyIsCrew] as bool?;
    if (isCrew == null || isCrew == false) {
      return dto;
    }

    return dto._copyWith(
      roles: [PersonRoleDto.crew],
    );
  }

  Map<String, dynamic> toSupaJson() {
    final json = toJson();

    if (roles == null) {
      return json;
    }

    json.remove('roles');

    final isCrew = roles!.contains(PersonRoleDto.crew);
    if (isCrew) {
      json[_keyIsCrew] = true;
    }
    return json;
  }

  PersonDto _copyWith({
    List<PersonRoleDto>? roles,
  }) {
    return PersonDto(
      id: id,
      name: name,
      surname: surname,
      gender: gender,
      url: url,
      info: info,
      roles: roles ?? this.roles,
    );
  }

  static final _keyIsCrew = 'is_crew';
}
