import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crew_dto.g.dart';

@JsonSerializable(
  createToJson: false,
)
class CrewDto extends Equatable {
  final List<int>? authors;
  final List<int>? readers;
  final List<int>? musicians;
  final List<int>? translators;
  final List<int>? graphics;

  CrewDto({
    required this.authors,
    required this.readers,
    required this.musicians,
    required this.translators,
    required this.graphics,
  }) : assert(
          (authors?.isNotEmpty == true) ||
              (readers?.isNotEmpty == true) ||
              (musicians?.isNotEmpty == true) ||
              (translators?.isNotEmpty == true) ||
              (graphics?.isNotEmpty == true),
        );

  factory CrewDto.fromJson(Map<String, dynamic> json) =>
      _$CrewDtoFromJson(json);

  @override
  List<Object?> get props => [
        authors,
        readers,
        musicians,
        translators,
        graphics,
      ];
}
