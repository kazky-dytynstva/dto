import 'package:dto/dto.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

import '../../../test_data/test_data.dart';

void main() {
  final chapter = getChapter();

  test('GIVEN instance THEN verify it is equatable', () {
    expect(chapter, isA<Equatable>());
  });

  test('GIVEN instance THEN verify all props correct', () {
    final props = [
      chapterTitle,
      chapterText,
      chapterAudio,
      chapterImageCount,
    ];
    expect(chapter.props, equals(props));
  });

  test('GIVEN same params and 2 instances THEN objects are equal', () {
    const title = 'custom title';
    const imageCount = 333;
    const text = ["this", "is", "custom", "text"];
    final audio = getChapterAudio(size: 100, duration: 333);
    final instanceOne = getChapter(
      title: title,
      text: text,
      imageCount: imageCount,
      audio: audio,
    );
    final instanceTwo = getChapter(
      title: title,
      text: text,
      imageCount: imageCount,
      audio: audio,
    );

    expect(instanceOne, equals(instanceTwo));
  });

  test('GIVEN json with min params THEN parsed correctly', () {
    final dto = ChapterDto.fromJson(chapterJson);
    expect(dto, equals(chapter));
  });

  test('GIVEN no text and no audio THEN throw exception', () {
    expect(
      () => ChapterDto(title: 'title', text: null, audio: null, imageCount: 1),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => ChapterDto.fromJson(chapterJsonInvalid),
      throwsA(isA<AssertionError>()),
    );
  });

  test('GIVEN text with no audio THEN DO NOT throw exception', () {
    final dto = ChapterDto(
      title: 'title',
      text: ["hi there"],
      audio: null,
      imageCount: null,
    );
    expect(dto, isA<ChapterDto>());
  });

  test('GIVEN audio with no text THEN DO NOT throw exception', () {
    final dto = ChapterDto(
      title: 'title',
      text: null,
      audio: getChapterAudio(),
      imageCount: null,
    );
    expect(dto, isA<ChapterDto>());
  });

  test('GIVEN model with all params THEN converted to json correctly', () {
    final model = chapter;
    expect(model.toJson(), equals(chapterJson));
  });
}
