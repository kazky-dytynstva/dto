import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crew_dto.g.dart';

@JsonSerializable()
class CrewDto extends Equatable {
  CrewDto({
    this.authors,
    this.readers,
    this.musicians,
    this.translators,
    this.graphics,
  }) : assert(
          (authors?.isNotEmpty == true) ||
              (readers?.isNotEmpty == true) ||
              (musicians?.isNotEmpty == true) ||
              (translators?.isNotEmpty == true) ||
              (graphics?.isNotEmpty == true),
        );

  final List<int>? authors;
  final List<int>? readers;
  final List<int>? musicians;
  final List<int>? translators;
  final List<int>? graphics;

  factory CrewDto.fromJson(Map<String, dynamic> json) =>
      _$CrewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CrewDtoToJson(this);

  @override
  List<Object?> get props => [
        authors,
        readers,
        musicians,
        translators,
        graphics,
      ];
}
