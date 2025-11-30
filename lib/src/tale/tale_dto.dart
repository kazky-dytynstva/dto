import 'package:dto/src/id_holder.dart';
import 'package:dto/src/tale/content/audio_content_dto.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import 'package:dto/src/tale/crew/crew_dto.dart';
import 'package:dto/src/to_json_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tale_dto.g.dart';

@JsonSerializable()
class TaleDto extends Equatable implements ToJsonItem, IdHolder {
  /// Creates a TaleDto object.
  TaleDto({
    required this.id,
    required this.name,
    required this.createDate,
    required this.updateDate,
    required this.summary,
    required this.tags,
    required this.text,
    required this.audio,
    required this.crew,
    bool? isHidden,
  }) : isHidden = isHidden == true ? true : null,
       assert(id >= 0, 'Tale id should be positive'),
       assert(id != stubId, 'Tale id should NOT be a stub id'),
       assert(
         name.length >= nameMinLength && name.length <= nameMaxLength,
         'Tale name should be between $nameMinLength and $nameMaxLength characters long',
       ),
       assert(
         updateDate == null || updateDate.isAfter(createDate),
         'updateDate can NOT be before createDate',
       ),
       assert(tags.isNotEmpty, 'There should be at least one tag'),
       assert(
         summary.length >= summaryMinLength &&
             summary.length <= summaryMaxLength,
         'Tale summary should be between $summaryMinLength and $summaryMaxLength characters long',
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

  final DateTime createDate;

  final DateTime? updateDate;

  final String summary;

  final Set<TaleTag> tags;

  final TextContentDto? text;
  final AudioContentDto? audio;

  final CrewDto? crew;

  /// Used for the development and testing purposes
  /// When flag is true, the tale should not be shown in the production tales list
  ///
  /// This value can be or true or null. False is not allowed.
  @JsonKey()
  final bool? isHidden;

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
    summary,
    tags,
    text,
    audio,
    crew,
    isHidden,
  ];

  TaleDto copyWith({
    int? id,
    String? name,
    DateTime? createDate,
    DateTime? updateDate,
    String? summary,
    Set<TaleTag>? tags,
    TextContentDto? text,
    AudioContentDto? audio,
    CrewDto? crew,
    bool? isHidden,
    bool resetUpdateDate = false,
  }) {
    return TaleDto(
      id: id ?? this.id,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
      updateDate: resetUpdateDate ? null : updateDate ?? this.updateDate,
      summary: summary ?? this.summary,
      tags: tags ?? this.tags,
      text: text ?? this.text,
      audio: audio ?? this.audio,
      crew: crew ?? this.crew,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  static const stubId = 4242424242;

  static const nameMinLength = 4;
  static const nameMaxLength = 50;

  static const summaryMinLength = 140;
  static const summaryMaxLength = 200;
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
