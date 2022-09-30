import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter_audio_dto.g.dart';

@JsonSerializable()
class ChapterAudioDto extends Equatable {
  final int size;
  final int duration;

  ChapterAudioDto({
    required this.size,
    required this.duration,
  });

  factory ChapterAudioDto.fromJson(Map<String, dynamic> json) =>
      _$ChapterAudioDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterAudioDtoToJson(this);

  @override
  List<Object> get props => [
        size,
        duration,
      ];
}
