import 'package:dto/dto.dart';

import 'chapter_audio_test_data.dart';

const chapterTitle = 'Title';
const chapterText = ["hello", "world"];
final chapterAudio = getChapterAudio();
const chapterImageCount = 2;

const _keyTitle = "title";
const _keyText = "text";
const _keyAudio = "audio";
const _keyImageCount = "imageCount";

Map<String, dynamic> chapterJson = {
  _keyTitle: chapterTitle,
  _keyText: chapterText,
  _keyAudio: chapterAudioJson,
  _keyImageCount: chapterImageCount,
};
Map<String, dynamic> chapterJsonInvalid = {
  _keyTitle: chapterTitle,
  _keyText: null,
  _keyAudio: null,
  _keyImageCount: chapterImageCount,
};

ChapterDto getChapter({
  String? title = chapterTitle,
  List<String>? text = chapterText,
  ChapterAudioDto? audio,
  int? imageCount = chapterImageCount,
}) =>
    ChapterDto(
      title: title,
      text: text,
      audio: audio ?? chapterAudio,
      imageCount: imageCount,
    );
