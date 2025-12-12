import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dto/src/person/person_dto.dart';
import 'package:dto/src/tale/tale_dto.dart';

/// A utility class for compressing and decompressing DTOs using gzip compression.
class DTOCompression {
  /// Compresses a list of [TaleDto] objects into a gzip-compressed byte array.
  ///
  /// The tales are first serialized to JSON, then encoded to UTF-8, and finally
  /// compressed using gzip compression.
  ///
  /// Returns a [Uint8List] containing the compressed data.
  static Uint8List compressTales(List<TaleDto> tales) {
    return _compress(tales, (tale) => tale.toJson());
  }

  /// Decompresses a gzip-compressed byte array into a list of [TaleDto] objects.
  ///
  /// The compressed data is first decompressed using gzip, then decoded from UTF-8,
  /// parsed as JSON, and finally converted to [TaleDto] objects.
  ///
  /// Returns a [List<TaleDto>] containing the decompressed tales.
  ///
  /// Throws [FormatException] if the compressed data is invalid or cannot be parsed.
  static List<TaleDto> decompressTales(Uint8List compressedData) {
    return _decompress(compressedData, (json) => TaleDto.fromJson(json));
  }

  /// Compresses a list of [PersonDto] objects into a gzip-compressed byte array.
  ///
  /// The people are first serialized to JSON, then encoded to UTF-8, and finally
  /// compressed using gzip compression.
  ///
  /// Returns a [Uint8List] containing the compressed data.
  static Uint8List compressPeople(List<PersonDto> people) {
    return _compress(people, (person) => person.toJson());
  }

  /// Decompresses a gzip-compressed byte array into a list of [PersonDto] objects.
  ///
  /// The compressed data is first decompressed using gzip, then decoded from UTF-8,
  /// parsed as JSON, and finally converted to [PersonDto] objects.
  ///
  /// Returns a [List<PersonDto>] containing the decompressed people.
  ///
  /// Throws [FormatException] if the compressed data is invalid or cannot be parsed.
  static List<PersonDto> decompressPeople(Uint8List compressedData) {
    return _decompress(compressedData, (json) => PersonDto.fromJson(json));
  }

  /// Generic compression method to avoid code duplication.
  static Uint8List _compress<T>(
    List<T> items,
    Map<String, dynamic> Function(T) toJson,
  ) {
    final jsonString = jsonEncode(items.map(toJson).toList());
    final bytes = utf8.encode(jsonString);
    final compressed = gzip.encode(bytes);
    return compressed is Uint8List
        ? compressed
        : Uint8List.fromList(compressed);
  }

  /// Generic decompression method to avoid code duplication.
  static List<T> _decompress<T>(
    Uint8List compressedData,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final decompressedBytes = gzip.decode(compressedData);
    final jsonString = utf8.decode(decompressedBytes);
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
