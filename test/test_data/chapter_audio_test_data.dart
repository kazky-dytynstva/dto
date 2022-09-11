import 'package:dto/dto.dart';

const chapterAudioSize = 1024;
const chapterAudioDuration = 333555777;

const _keySize = "size";
const _keyDuration = "duration";

Map<String, dynamic> chapterAudioJson = {
  _keySize: chapterAudioSize,
  _keyDuration: chapterAudioDuration,
};

ChapterAudioDto getChapterAudio({
  int size = chapterAudioSize,
  int duration = chapterAudioDuration,
}) =>
    ChapterAudioDto(
      size: size,
      duration: duration,
    );
