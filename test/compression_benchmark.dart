import 'dart:convert';
import 'dart:io';
import 'package:dto/src/compression/dto_compression.dart';
import 'package:dto/src/tale/tale_dto.dart';

void main() async {
  final file = File(
    '/Users/andrii.antonov/dev/kazky/content/data/4/tales/list.json',
  );

  print('Reading JSON file...');
  final jsonString = await file.readAsString();
  final originalBytes = utf8.encode(jsonString);

  print('\n=== Original Data ===');
  print(
    'File size: ${(file.lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB',
  );
  print('Lines: 17,409');
  print(
    'Bytes: ${originalBytes.length} (${(originalBytes.length / 1024 / 1024).toStringAsFixed(2)} MB)',
  );

  print('\nParsing JSON into DTOs...');
  final stopwatchParse = Stopwatch()..start();
  final List<dynamic> jsonList = jsonDecode(jsonString);
  final tales = jsonList
      .map((json) => TaleDto.fromJson(json as Map<String, dynamic>))
      .toList();
  stopwatchParse.stop();

  print('Tales count: ${tales.length}');
  print('Parse time: ${stopwatchParse.elapsedMilliseconds}ms');

  // Test compression
  print('\n=== Compression Test ===');
  final stopwatchCompress = Stopwatch()..start();
  final compressed = DTOCompression.compressTales(tales);
  stopwatchCompress.stop();

  print(
    'Compressed size: ${compressed.length} bytes (${(compressed.length / 1024 / 1024).toStringAsFixed(2)} MB)',
  );
  print('Compression time: ${stopwatchCompress.elapsedMilliseconds}ms');
  print(
    'Compression ratio: ${(originalBytes.length / compressed.length).toStringAsFixed(2)}x',
  );
  print(
    'Size reduction: ${((1 - compressed.length / originalBytes.length) * 100).toStringAsFixed(1)}%',
  );

  // Test decompression
  print('\n=== Decompression Test ===');
  final stopwatchDecompress = Stopwatch()..start();
  final decompressed = DTOCompression.decompressTales(compressed);
  stopwatchDecompress.stop();

  print('Decompressed tales: ${decompressed.length}');
  print('Decompression time: ${stopwatchDecompress.elapsedMilliseconds}ms');
  print(
    'Data integrity: ${decompressed.length == tales.length ? "✓ OK" : "✗ FAILED"}',
  );

  // Performance summary
  print('\n=== Performance Summary ===');
  print(
    'Total round-trip time: ${stopwatchCompress.elapsedMilliseconds + stopwatchDecompress.elapsedMilliseconds}ms',
  );
  print(
    'Compression speed: ${(originalBytes.length / 1024 / 1024 / (stopwatchCompress.elapsedMilliseconds / 1000)).toStringAsFixed(2)} MB/s',
  );
  print(
    'Decompression speed: ${(originalBytes.length / 1024 / 1024 / (stopwatchDecompress.elapsedMilliseconds / 1000)).toStringAsFixed(2)} MB/s',
  );

  // Test with multiple runs for average
  print('\n=== Average Performance (10 runs) ===');
  final compressTimes = <int>[];
  final decompressTimes = <int>[];

  for (var i = 0; i < 10; i++) {
    final sw1 = Stopwatch()..start();
    final comp = DTOCompression.compressTales(tales);
    sw1.stop();
    compressTimes.add(sw1.elapsedMilliseconds);

    final sw2 = Stopwatch()..start();
    DTOCompression.decompressTales(comp);
    sw2.stop();
    decompressTimes.add(sw2.elapsedMilliseconds);
  }

  final avgCompress =
      compressTimes.reduce((a, b) => a + b) / compressTimes.length;
  final avgDecompress =
      decompressTimes.reduce((a, b) => a + b) / decompressTimes.length;

  print('Average compression time: ${avgCompress.toStringAsFixed(1)}ms');
  print('Average decompression time: ${avgDecompress.toStringAsFixed(1)}ms');
  print(
    'Min compression time: ${compressTimes.reduce((a, b) => a < b ? a : b)}ms',
  );
  print(
    'Max compression time: ${compressTimes.reduce((a, b) => a > b ? a : b)}ms',
  );
  print(
    'Min decompression time: ${decompressTimes.reduce((a, b) => a < b ? a : b)}ms',
  );
  print(
    'Max decompression time: ${decompressTimes.reduce((a, b) => a > b ? a : b)}ms',
  );
}
