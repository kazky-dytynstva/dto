import 'package:dto/src/tale/chapter/audio/chapter_audio_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter_dto.g.dart';

@JsonSerializable()
class ChapterDto extends Equatable {
  ChapterDto({
    required this.title,
    required this.text,
    required this.audio,
    required this.imageCount,
  }) : assert(
          (text != null && text.isNotEmpty) || audio != null,
          'Chapter should contain at least text or audio',
        );
        
  final String? title;

  /// text might contain image references as a number
  /// 1 number per list item - mean this is the image reference
  ///
  /// for example
  ///
  /// 3 - mean that here should be inserted photo #3
  final List<String>? text;

  final ChapterAudioDto? audio;

  /// amount of images per chapter,
  /// if its equal null - its mean there is 1 main image
  final int? imageCount;

  factory ChapterDto.fromJson(Map<String, dynamic> json) =>
      _$ChapterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDtoToJson(this);

  @override
  List<Object?> get props => [
        title,
        text,
        audio,
        imageCount,
      ];
}
