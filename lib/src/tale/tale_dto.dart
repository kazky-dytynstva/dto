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
  })  : isHidden = isHidden == true ? true : null,
        assert(
          id >= 0,
          'Tale id should be positive',
        ),
        assert(id != stubId, 'Tale id should NOT be a stub id'),
        assert(
          name.length >= nameMinLength && name.length <= nameMaxLength,
          'Tale name should be between $nameMinLength and $nameMaxLength characters long',
        ),
        assert(
          updateDate == null || updateDate.isAfter(createDate),
          'updateDate can NOT be before createDate',
        ),
        assert(
          tags.isNotEmpty,
          'There should be at least one tag',
        ),
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

  /// In millisecondsSinceEpoch
  final DateTime createDate;

  /// In millisecondsSinceEpoch
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

  factory TaleDto.fromSupaJson(Map<String, dynamic> json) {
    json[_keyCreateDate] =
        DateTime.parse(json[_keyCreateDate] as String).toIso8601String();

    if (json[_keyUpdateDate] != null) {
      json[_keyUpdateDate] =
          DateTime.parse(json[_keyUpdateDate] as String).toIso8601String();
    }

    TextContentDto? textDto;
    final paragrphs = json[_keyParagraphs] as List<dynamic>?;
    final minReadingTime = json[_keyMinReadingTime] as int?;
    final maxReadingTime = json[_keyMaxReadingTime] as int?;

    if (paragrphs != null && minReadingTime != null && maxReadingTime != null) {
      textDto = TextContentDto(
        paragraphs: paragrphs.cast<String>(),
        minReadingTime: minReadingTime,
        maxReadingTime: maxReadingTime,
      );
      json[_keyText] = textDto.toJson();
    } else if (paragrphs != null ||
        minReadingTime != null ||
        maxReadingTime != null) {
      throw Exception(
        'Text content should be present if and only if the tale has a ${TaleTag.text} tag',
      );
    }

    final audioSize = json[_keyAudioSize] as int?;
    final audioDuration = json[_keyAudioDuration] as int?;
    assert(
      audioSize == null && audioDuration == null ||
          audioSize != null && audioDuration != null,
      'Audio size and duration should be both present or absent',
    );

    if (audioSize != null && audioDuration != null) {
      final audioDto = AudioContentDto(
        fileSize: audioSize,
        duration: audioDuration,
      );

      json[_keyAudio] = audioDto.toJson();
    }

    final authors = json[_keyAuthors] as List<dynamic>?;
    final readers = json[_keyReaders] as List<dynamic>?;
    final graphics = json[_keyGraphics] as List<dynamic>?;
    final musicians = json[_keyMusicians] as List<dynamic>?;
    final translators = json[_keyTranslators] as List<dynamic>?;

    if (authors != null ||
        readers != null ||
        graphics != null ||
        musicians != null ||
        translators != null) {
      json[_keyCrew] = CrewDto.fromJson(json).toJson();
    }

    return TaleDto.fromJson(json);
  }

  Map<String, dynamic> toSupaJson() {
    final json = toJson();
    json[_keyCreateDate] = createDate.toIso8601String();

    if (json[_keyUpdateDate] != null) {
      json[_keyUpdateDate] = updateDate!.toIso8601String();
    }

    final Map<String, dynamic>? textJson = json.remove(_keyText);
    if (textJson != null) {
      for (final entry in textJson.entries) {
        json[entry.key] = entry.value;
      }
    }

    json.remove(_keyAudio);
    if (audio != null) {
      json[_keyAudioSize] = audio!.fileSize;
      json[_keyAudioDuration] = audio!.duration;
    }

    final Map<String, dynamic>? crewJson = json.remove(_keyCrew);
    if (crewJson != null) {
      for (final entry in crewJson.entries) {
        json[entry.key] = entry.value;
      }
    }

    return json;
  }

  TaleDto copyWith({
    int? id,
  }) {
    return TaleDto(
      id: id ?? this.id,
      name: name,
      createDate: createDate,
      updateDate: updateDate,
      summary: summary,
      tags: tags,
      text: text,
      audio: audio,
      crew: crew,
      isHidden: isHidden,
    );
  }

  static const stubId = 4242424242;

  static const nameMinLength = 2;
  static const nameMaxLength = 50;

  static const summaryMinLength = 140;
  static const summaryMaxLength = 200;

  static const _keyCreateDate = 'create_date';
  static const _keyUpdateDate = 'update_date';

  static const _keyAudioSize = 'audio_file_size';
  static const _keyAudioDuration = 'audio_duration';
  static const _keyAudio = 'audio';
  static const _keyCrew = 'crew';
  static const _keyText = 'text';
  static const _keyParagraphs = 'paragraphs';
  static const _keyMinReadingTime = 'min_reading_time';
  static const _keyMaxReadingTime = 'max_reading_time';

  static const _keyAuthors = 'authors';
  static const _keyReaders = 'readers';
  static const _keyGraphics = 'graphics';
  static const _keyMusicians = 'musicians';
  static const _keyTranslators = 'translators';
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
