import 'package:dto/dto.dart';

const crewAuthors = [1];
const crewReaders = [2, 3];
const crewMusicians = [0];
const crewTranslators = [123, 2];
const crewGraphics = [2];

const _keyAuthors = "authors";
const _keyReaders = "readers";
const _keyMusicians = "musicians";
const _keyTranslators = "translators";
const _keyGraphics = "graphics";

Map<String, dynamic> crewJson = {
  _keyAuthors: crewAuthors,
  _keyReaders: crewReaders,
  _keyMusicians: crewMusicians,
  _keyTranslators: crewTranslators,
  _keyGraphics: crewGraphics,
};

Map<String, dynamic> crewJsonInvalid = {};

CrewDto getCrew({
  List<int> authors = crewAuthors,
  List<int> readers = crewReaders,
  List<int> musicians = crewMusicians,
  List<int> translators = crewTranslators,
  List<int> graphics = crewGraphics,
}) =>
    CrewDto(
      authors: authors,
      readers: readers,
      musicians: musicians,
      translators: translators,
      graphics: graphics,
    );

CrewDto getCrewEmpty({
  List<int>? authors,
  List<int>? readers,
  List<int>? musicians,
  List<int>? translators,
  List<int>? graphics,
}) =>
    CrewDto(
      authors: authors,
      readers: readers,
      musicians: musicians,
      translators: translators,
      graphics: graphics,
    );
