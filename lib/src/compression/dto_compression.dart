import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dto/src/person/person_dto.dart';
import 'package:dto/src/tale/tale_dto.dart';

/// A utility class for compressing and decompressing DTOs using Brotli compression.
class DTOCompression {
  /// Compresses a list of [TaleDto] objects into a Brotli-compressed byte array.
  ///
  /// The tales are first serialized to JSON, then encoded to UTF-8, and finally
  /// compressed using Brotli compression.
  ///
  /// Returns a [Uint8List] containing the compressed data.
  static Uint8List compressTales(List<TaleDto> tales) {
    final jsonList = tales.map((tale) => tale.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    final bytes = utf8.encode(jsonString);
    return Uint8List.fromList(gzip.encode(bytes));
  }

  /// Decompresses a Brotli-compressed byte array into a list of [TaleDto] objects.
  ///
  /// The compressed data is first decompressed using Brotli, then decoded from UTF-8,
  /// parsed as JSON, and finally converted to [TaleDto] objects.
  ///
  /// Returns a [List<TaleDto>] containing the decompressed tales.
  ///
  /// Throws [FormatException] if the compressed data is invalid or cannot be parsed.
  static List<TaleDto> decompressTales(Uint8List compressedData) {
    final decompressedBytes = gzip.decode(compressedData);
    final jsonString = utf8.decode(decompressedBytes);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => TaleDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Compresses a list of [PersonDto] objects into a Brotli-compressed byte array.
  ///
  /// The people are first serialized to JSON, then encoded to UTF-8, and finally
  /// compressed using Brotli compression.
  ///
  /// Returns a [Uint8List] containing the compressed data.
  static Uint8List compressPeople(List<PersonDto> people) {
    final jsonList = people.map((person) => person.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    final bytes = utf8.encode(jsonString);
    return Uint8List.fromList(gzip.encode(bytes));
  }

  /// Decompresses a Brotli-compressed byte array into a list of [PersonDto] objects.
  ///
  /// The compressed data is first decompressed using Brotli, then decoded from UTF-8,
  /// parsed as JSON, and finally converted to [PersonDto] objects.
  ///
  /// Returns a [List<PersonDto>] containing the decompressed people.
  ///
  /// Throws [FormatException] if the compressed data is invalid or cannot be parsed.
  static List<PersonDto> decompressPeople(Uint8List compressedData) {
    final decompressedBytes = gzip.decode(compressedData);
    final jsonString = utf8.decode(decompressedBytes);
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => PersonDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
