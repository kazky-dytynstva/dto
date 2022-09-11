import 'package:dto/dto.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

import '../../../../test_data/test_data.dart';

void main() {
  final chapterAudio = getChapterAudio();

  test('GIVEN instance THEN verify it is equatable', () {
    expect(chapterAudio, isA<Equatable>());
  });

  test('GIVEN instance THEN verify all props correct', () {
    const props = [
      chapterAudioSize,
      chapterAudioDuration,
    ];
    expect(chapterAudio.props, equals(props));
  });

  test('GIVEN same params and 2 instances THEN objects are equal', () {
    const size = 777;
    const duration = 333;
    final instanceOne = getChapterAudio(size: size, duration: duration);
    final instanceTwo = getChapterAudio(size: size, duration: duration);

    expect(instanceOne, equals(instanceTwo));
  });

  test('GIVEN json with min params THEN parsed correctly', () {
    final dto = ChapterAudioDto.fromJson(chapterAudioJson);
    expect(dto, equals(chapterAudio));
  });
}
