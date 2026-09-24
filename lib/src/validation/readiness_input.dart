import 'package:dto/src/person/person_dto.dart';
import 'package:dto/src/person/person_gender_dto.dart';
import 'package:dto/src/person/person_role_dto.dart';
import 'package:dto/src/tale/content/audio_content_dto.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import 'package:dto/src/tale/tale_dto.dart';

class MediaFileEvidence {
  const MediaFileEvidence({
    required this.byteLength,
    required this.extension,
    required this.isDecodable,
  });

  final int byteLength;
  final String extension;
  final bool isDecodable;
}

class MediaPairEvidence {
  const MediaPairEvidence({this.original, this.thumbnail});

  final MediaFileEvidence? original;
  final MediaFileEvidence? thumbnail;
}

class PersonReadinessInput {
  PersonReadinessInput({
    this.id,
    this.name,
    this.surname,
    this.gender,
    this.url,
    this.createDate,
    this.updateDate,
    List<PersonRoleDto>? roles,
    this.photo = const MediaPairEvidence(),
  }) : roles = roles == null ? null : List.unmodifiable(roles);

  factory PersonReadinessInput.fromDto(
    PersonDto dto, {
    required MediaPairEvidence photo,
  }) => PersonReadinessInput(
    id: dto.id,
    name: dto.name,
    surname: dto.surname,
    gender: dto.gender,
    url: dto.url,
    createDate: dto.createDate,
    updateDate: dto.updateDate,
    roles: dto.roles,
    photo: photo,
  );

  final int? id;
  final String? name;
  final String? surname;
  final PersonGenderDto? gender;
  final Uri? url;
  final DateTime? createDate;
  final DateTime? updateDate;
  final List<PersonRoleDto>? roles;
  final MediaPairEvidence photo;
}

class IndexedImageEvidence {
  const IndexedImageEvidence({required this.index, required this.media});

  final int index;
  final MediaPairEvidence media;
}

class TextReadinessInput {
  TextReadinessInput({
    List<ContentItem>? items,
    this.minReadingTime,
    this.maxReadingTime,
  }) : items = items == null ? null : List.unmodifiable(items);

  factory TextReadinessInput.fromDto(TextContentDto dto) => TextReadinessInput(
    items: dto.items,
    minReadingTime: dto.minReadingTime,
    maxReadingTime: dto.maxReadingTime,
  );

  final List<ContentItem>? items;
  final int? minReadingTime;
  final int? maxReadingTime;
}

class AudioReadinessInput {
  const AudioReadinessInput({this.fileSize, this.duration});

  factory AudioReadinessInput.fromDto(AudioContentDto dto) =>
      AudioReadinessInput(fileSize: dto.fileSize, duration: dto.duration);

  final int? fileSize;
  final Duration? duration;
}

class TaleReadinessInput {
  TaleReadinessInput({
    this.id,
    this.name,
    this.summary,
    this.createDate,
    this.updateDate,
    Set<TaleTag>? tags,
    this.text,
    this.audio,
    Map<PersonRoleDto, List<int>>? crew,
    List<IndexedImageEvidence> images = const [],
    this.audioFiles = const MediaPairEvidence(),
  }) : tags = tags == null ? null : Set.unmodifiable(tags),
       crew = crew == null
           ? null
           : Map.unmodifiable({
               for (final entry in crew.entries)
                 entry.key: List<int>.unmodifiable(entry.value),
             }),
       images = List.unmodifiable(images);

  factory TaleReadinessInput.fromDto(
    TaleDto dto, {
    required List<IndexedImageEvidence> images,
    required MediaPairEvidence audioFiles,
  }) {
    final crew = dto.crew;
    return TaleReadinessInput(
      id: dto.id,
      name: dto.name,
      summary: dto.summary,
      createDate: dto.createDate,
      updateDate: dto.updateDate,
      tags: dto.tags,
      text: dto.text == null ? null : TextReadinessInput.fromDto(dto.text!),
      audio: dto.audio == null ? null : AudioReadinessInput.fromDto(dto.audio!),
      crew: crew == null
          ? null
          : {
              if (crew.authors != null) PersonRoleDto.author: crew.authors!,
              if (crew.readers != null) PersonRoleDto.reader: crew.readers!,
              if (crew.musicians != null)
                PersonRoleDto.musician: crew.musicians!,
              if (crew.graphics != null) PersonRoleDto.graphic: crew.graphics!,
              if (crew.translators != null)
                PersonRoleDto.translator: crew.translators!,
            },
      images: images,
      audioFiles: audioFiles,
    );
  }

  final int? id;
  final String? name;
  final String? summary;
  final DateTime? createDate;
  final DateTime? updateDate;
  final Set<TaleTag>? tags;
  final TextReadinessInput? text;
  final AudioReadinessInput? audio;
  final Map<PersonRoleDto, List<int>>? crew;
  final List<IndexedImageEvidence> images;
  final MediaPairEvidence audioFiles;
}
