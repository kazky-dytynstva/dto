import 'package:dto/src/id_holder.dart';
import 'package:dto/src/tale/content/audio_content.dart';
import 'package:dto/src/tale/content/text_content.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';
import 'package:dto/src/to_json_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tale_dto.g.dart';

@JsonSerializable()
class TaleDto extends Equatable implements ToJsonItem, IdHolder {
  TaleDto({
    required this.id,
    required this.name,
    required this.createDate,
    required this.updateDate,
    required this.tags,
    required this.text,
    required this.audio,
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
          tags.isNotEmpty,
          'There should be at least one tag',
        ),
        assert(
          tags.contains(TaleTag.text) == false && text == null ||
              tags.contains(TaleTag.text) == true && text != null,
          'Text content should be present if and only if the tale has a ${TaleTag.text} tag',
        ),
        assert(
          tags.contains(TaleTag.audio) == false && audio == null ||
              tags.contains(TaleTag.audio) == true && audio != null,
          'Audio content should be present if and only if the tale has a ${TaleTag.audio} tag',
        );

  @override
  final int id;
  final String name;

  /// In millisecondsSinceEpoch
  final int createDate;

  /// In millisecondsSinceEpoch
  final int? updateDate;

  final Set<TaleTag> tags;

  final TextContentDto? text;
  final AudioContentDto? audio;

  final CrewDto? crew;

  /// Used for the development and testing.
  /// When flag is true, the tale should not be shown in the production tales list
  @JsonKey()
  final bool? ignore;

  factory TaleDto.fromJson(Map<String, dynamic> json) =>
      _$TaleDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaleDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        createDate,
        updateDate,
        tags,
        text,
        audio,
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
