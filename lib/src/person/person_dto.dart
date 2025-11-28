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
    required this.createDate,
    required this.updateDate,
  })  : assert(
          id >= 0,
          'Person id should be positive',
        ),
        assert(id != stubId, 'Person id should NOT be a stub id'),
        assert(
          name.length >= nameMinLength && name.length <= nameMaxLength,
          'Person name should be between $nameMinLength and $nameMaxLength characters long',
        ),
        assert(
          updateDate == null || updateDate.isAfter(createDate),
          'updateDate can NOT be before createDate',
        ),
        assert(
          surname.isEmpty ||
              surname.length >= surnameMinLength &&
                  surname.length <= surnameMaxLength,
          'Person surname should be between $surnameMinLength and $surnameMaxLength characters long',
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
          url == null ||
              url.toString().length >= urlMinLength &&
                  url.toString().length <= urlMaxLength,
          'Person url should be a valid URL, with length between $urlMinLength and $urlMaxLength characters',
        );

  @override
  final int id;
  final String name;
  final String surname;
  final PersonGenderDto gender;
  final Uri? url;
  final String? info;
  final List<PersonRoleDto>? roles;
  final DateTime createDate;
  final DateTime? updateDate;

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
        createDate,
        updateDate,
      ];

  PersonDto copyWith({
    int? id,
    List<PersonRoleDto>? roles,
    Uri? url,
    String? info,
    String? name,
    String? surname,
    PersonGenderDto? gender,
    DateTime? createDate,
    DateTime? updateDate,
  }) {
    return PersonDto(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      gender: gender ?? this.gender,
      url: url ?? this.url,
      info: info ?? this.info,
      roles: roles ?? this.roles,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  static const stubId = 4242424242;

  static const nameMinLength = 2;
  static const nameMaxLength = 50;

  static const surnameMinLength = 2;
  static const surnameMaxLength = 50;

  static const urlMinLength = 8;
  static const urlMaxLength = 256;

  static const infoMinLength = 0;
  static const infoMaxLength = 200;
}
