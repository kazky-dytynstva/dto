import 'package:dto/src/tale/chapter/chapter_dto.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tale_dto.g.dart';

@JsonSerializable()
class TaleDto extends Equatable {
  final int id;
  final String name;

  /// in microsecondsSinceEpoch
  final int createDate;

  /// in microsecondsSinceEpoch
  final int? updateDate;
  final Set<TaleTag> tags;
  final List<ChapterDto> content;

  final CrewDto? crew;

  /// Used for the development and testing.
  /// When flag is true, the tale should not be shown in the production tales list
  @JsonKey(defaultValue: false)
  final bool? ignore;

  TaleDto({
    required this.id,
    required this.name,
    required this.createDate,
    required this.updateDate,
    required this.tags,
    required this.content,
    required this.crew,
    required this.ignore,
  })  : assert(
          id >= 0,
          'Tale id should be positive',
        ),
        assert(
          name.isNotEmpty,
          'Tale name should NOT be empty',
        ),
        assert(
          updateDate == null || updateDate > createDate,
          'updateDate can NOT be before createDate',
        ),
        assert(
          content.isNotEmpty == true,
          'Content can NOT be empty',
        ),
        assert(
          tags.isNotEmpty,
          'There should be at least one tag',
        );

  factory TaleDto.fromJson(Map<String, dynamic> json) =>
      _$TaleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaleDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        createDate,
        updateDate,
        tags,
        content,
        crew,
        ignore,
      ];
}

enum TaleTag {
  @JsonValue('audio')
  audio,
  @JsonValue('text')
  text,
  @JsonValue('poem')
  poem,
  @JsonValue('lullaby')
  lullaby,
  @JsonValue('author')
  author,
}
