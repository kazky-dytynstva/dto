import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dto/src/person/person_dto.dart';
import 'package:dto/src/tale/tale_dto.dart';

/// A utility class for compressing and decompressing DTOs using gzip compression.
class DTOCompression<T> {
  /// Creates a DTO compression instance.
  const DTOCompression();

  /// Compresses a list of objects into a gzip-compressed byte array.
  ///
  /// The items are first serialized to JSON using [toJson], then encoded to UTF-8,
  /// and finally compressed using gzip compression.
  ///
  /// [items] - The list of objects to compress.
  /// [toJson] - Function to convert each item to a JSON map.
  ///
  /// Returns a [Uint8List] containing the compressed data.
  Uint8List compress(List<T> items, Map<String, dynamic> Function(T) toJson) {
    final jsonString = jsonEncode(items.map(toJson).toList());
    final bytes = utf8.encode(jsonString);
    final compressed = gzip.encode(bytes);
    return compressed is Uint8List
        ? compressed
        : Uint8List.fromList(compressed);
  }

  /// Decompresses a gzip-compressed byte array into a list of objects.
  ///
  /// The compressed data is first decompressed using gzip, then decoded from UTF-8,
  /// parsed as JSON, and finally converted to objects using [fromJson].
  ///
  /// [compressedData] - The compressed byte array.
  /// [fromJson] - Function to convert each JSON map to an object of type [T].
  ///
  /// Returns a [List<T>] containing the decompressed objects.
  ///
  /// Throws [FormatException] if the compressed data is invalid or cannot be parsed.
  List<T> decompress(
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

  static final _taleCompression = DTOCompression<TaleDto>();
  static final _personCompression = DTOCompression<PersonDto>();

  /// Compresses a list of [TaleDto] objects into a gzip-compressed byte array.
  ///
  /// The tales are first serialized to JSON, then encoded to UTF-8, and finally
  /// compressed using gzip compression.
  ///
  /// Returns a [Uint8List] containing the compressed data.
  static Uint8List compressTales(List<TaleDto> tales) {
    return _taleCompression.compress(tales, (tale) => tale.toJson());
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
    return _taleCompression.decompress(compressedData, TaleDto.fromJson);
  }

  /// Compresses a list of [PersonDto] objects into a gzip-compressed byte array.
  ///
  /// The people are first serialized to JSON, then encoded to UTF-8, and finally
  /// compressed using gzip compression.
  ///
  /// Returns a [Uint8List] containing the compressed data.
  static Uint8List compressPeople(List<PersonDto> people) {
    return _personCompression.compress(people, (person) => person.toJson());
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
    return _personCompression.decompress(compressedData, PersonDto.fromJson);
  }
}
