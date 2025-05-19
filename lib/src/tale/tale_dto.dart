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
    required this.summary,
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
          summary.isNotEmpty,
          'Tale summary should NOT be empty',
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

  final String summary;

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
        summary,
        tags,
        text,
        audio,
        crew,
        ignore,
      ];

  factory TaleDto.fromSupaJson(Map<String, dynamic> json) {
    json[_keyCreateDate] =
        DateTime.parse(json[_keyCreateDate] as String).millisecondsSinceEpoch;

    if (json[_keyUpdateDate] != null) {
      json[_keyUpdateDate] =
          DateTime.parse(json[_keyUpdateDate] as String).millisecondsSinceEpoch;
    }

    final dto = TaleDto.fromJson(json);

    final text = TextContentDto.fromJson(json);

    final audioSize = json[_keyAudioSize] as int?;
    final audioDuration = json[_keyAudioDuration] as int?;
    assert(
      audioSize == null && audioDuration == null ||
          audioSize != null && audioDuration != null,
      'Audio size and duration should be both present or absent',
    );

    final audio = audioSize != null && audioDuration != null
        ? AudioContentDto(
            fileSize: audioSize,
            duration: audioDuration,
          )
        : null;

    final crew = CrewDto.fromJson(json);

    return dto._copyWith(
      text: text,
      audio: audio,
      crew: crew,
    );
  }

  Map<String, dynamic> toSupaJsonItem() {
    final json = toJson();
    json[_keyCreateDate] =
        DateTime.fromMillisecondsSinceEpoch(createDate).toIso8601String();

    if (json[_keyUpdateDate] != null) {
      json[_keyUpdateDate] =
          DateTime.fromMillisecondsSinceEpoch(updateDate!).toIso8601String();
    }

    final Map<String, dynamic>? textJson = json.remove('text');
    if (textJson != null) {
      for (final entry in textJson.entries) {
        json[entry.key] = entry.value;
      }
    }

    json.remove('audio');
    if (audio != null) {
      json[_keyAudioSize] = audio!.fileSize;
      json[_keyAudioDuration] = audio!.duration;
    }

    final Map<String, dynamic>? crewJson = json.remove('crew');
    if (crewJson != null) {
      for (final entry in crewJson.entries) {
        json[entry.key] = entry.value;
      }
    }

    return json;
  }

  TaleDto _copyWith({
    TextContentDto? text,
    AudioContentDto? audio,
    CrewDto? crew,
  }) {
    return TaleDto(
      id: id,
      name: name,
      createDate: createDate,
      updateDate: updateDate,
      summary: summary,
      tags: tags,
      text: text ?? this.text,
      audio: audio ?? this.audio,
      crew: crew ?? this.crew,
      ignore: ignore,
    );
  }

  static final _keyCreateDate = 'create_date';
  static final _keyUpdateDate = 'update_date';

  static final _keyAudioSize = 'audio_file_size';
  static final _keyAudioDuration = 'audio_duration';
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
