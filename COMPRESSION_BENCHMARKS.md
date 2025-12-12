# Compression Benchmarks

## Test Data
- **File**: `/Users/andrii.antonov/dev/kazky/content/data/4/tales/list.json`
- **Tales Count**: 242
- **Original Size**: 1.67 MB (1,748,656 bytes)
- **Lines**: 17,409
- **Compressed Size**: 0.42 MB (438,975 bytes)
- **Compression Ratio**: 3.98x
- **Size Reduction**: 74.9%

## Benchmark History

### 2025-12-12: Optimized with Generic Methods + map()

**Implementation**: Using generic `_compress<T>()` and `_decompress<T>()` methods with `map().toList()`

#### Run 1
- Average compression time: 47.7ms
- Average decompression time: 10.1ms
- Min compression time: 46ms
- Max compression time: 50ms
- Min decompression time: 9ms
- Max decompression time: 12ms

#### Run 2
- Average compression time: 48.1ms
- Average decompression time: 10.0ms
- Min compression time: 47ms
- Max compression time: 50ms
- Min decompression time: 9ms
- Max decompression time: 12ms

#### Run 3
- Average compression time: 48.2ms
- Average decompression time: 10.0ms
- Min compression time: 47ms
- Max compression time: 50ms
- Min decompression time: 9ms
- Max decompression time: 11ms

#### Run 4
- Average compression time: 48.2ms
- Average decompression time: 9.9ms
- Min compression time: 46ms
- Max compression time: 50ms
- Min decompression time: 9ms
- Max decompression time: 11ms

#### Run 5
- Average compression time: 48.4ms
- Average decompression time: 9.9ms
- Min compression time: 47ms
- Max compression time: 50ms
- Min decompression time: 8ms
- Max decompression time: 11ms

**Summary Stats**:
- **Avg Compression**: 47.7 - 48.4ms (mean: ~48.1ms)
- **Avg Decompression**: 9.9 - 10.1ms (mean: ~10.0ms)
- **Compression Speed**: ~16 MB/s
- **Decompression Speed**: ~104 MB/s
- **Total Round-trip**: ~58ms

---

### Experiment: for-loop vs map()

Tested replacing `map().toList()` with explicit for-loops.

#### Run 1
- Average compression time: 47.9ms
- Average decompression time: 9.8ms
- Min compression time: 46ms
- Max compression time: 51ms
- Min decompression time: 9ms
- Max decompression time: 11ms

#### Run 2 (outlier)
- Average compression time: 52.9ms
- Average decompression time: 10.7ms
- Min compression time: 47ms
- Max compression time: 70ms
- Min decompression time: 9ms
- Max decompression time: 15ms

#### Run 3
- Average compression time: 47.7ms
- Average decompression time: 9.9ms
- Min compression time: 46ms
- Max compression time: 49ms
- Min decompression time: 8ms
- Max decompression time: 12ms

#### Run 4
- Average compression time: 48.0ms
- Average decompression time: 9.8ms
- Min compression time: 47ms
- Max compression time: 49ms
- Min decompression time: 9ms
- Max decompression time: 11ms

#### Run 5
- Average compression time: 47.9ms
- Average decompression time: 9.9ms
- Min compression time: 47ms
- Max compression time: 49ms
- Min decompression time: 9ms
- Max decompression time: 11ms

**Conclusion**: No meaningful performance difference. Reverted to `map()` for better readability.

---

## Notes

- All benchmarks run on macOS using `fvm dart` with `--enable-experiment=null-aware-elements`
- Each benchmark performs 10 compression/decompression cycles and reports statistics
- Minor variance (±0.5ms) is normal and attributed to system noise
- Decompression is consistently ~5x faster than compression
- The gzip compression achieves excellent results for JSON data with repetitive structure
