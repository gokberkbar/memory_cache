import 'package:memory_cache/memory_cache.dart';
import 'package:test/test.dart';

void main() {
  group('CRUD Operations', () {
    final key = 'key0';
    final value = 'value0';

    setUpAll(() {
      MemoryCache.instance.invalidate();
      MemoryCache.instance.create(key, value);
    });

    test('is item created', () {
      expect(MemoryCache.instance.contains(key), true);
    });

    test('read item', () {
      final cachedValue = MemoryCache.instance.read<String>(key);
      expect(cachedValue, value);
    });

    test('create if item is absent', () {
      final newValue = 'key1';
      final newKey = 'value1';
      final isCreated = MemoryCache.instance.createIfAbsent(key, newValue);
      expect(isCreated, false);
      final isNewValueCreated =
          MemoryCache.instance.createIfAbsent(newKey, newValue);
      expect(isNewValueCreated, true);
    });

    test('update item', () {
      final newValue = 'updatedValue';
      final isUpdated = MemoryCache.instance.update<String>(key, newValue);
      expect(isUpdated, true);
      final cachedValue = MemoryCache.instance.read<String>(key);
      expect(cachedValue, newValue);
    });

    test('delete item', () {
      MemoryCache.instance.delete(key);
      expect(MemoryCache.instance.contains(key), false);
    });

    test('expire item', () async {
      MemoryCache.instance
          .create<String>(key, value, expiry: Duration(seconds: 1));
      await Future.delayed(Duration(seconds: 2));
      final isValueExist = MemoryCache.instance.contains(key);
      expect(isValueExist, false);
    });

    test('createIfAbsent test on expired item', () async {
      MemoryCache.instance
          .create<String>(key, value, expiry: Duration(seconds: 1));
      await Future.delayed(Duration(seconds: 2));
      final isValueCreated =
          MemoryCache.instance.createIfAbsent('newKey', 'newItem');
      expect(isValueCreated, true);
    });

    test('re-create item with expiry', () async {
      final newKey = 'newKey';
      final item = 'item';
      final newItem = 'newItem';

      MemoryCache.instance
          .create<String>(newKey, item, expiry: Duration(seconds: 1));
      MemoryCache.instance
          .create<String>(newKey, newItem, expiry: Duration(seconds: 5));
      await Future.delayed(Duration(seconds: 2));
      final value = MemoryCache.instance.read<String>(newKey);
      expect(value, newItem);
    });

    test('update expired item', () async {
      final newKey = 'newKey';
      final item = 'item';
      final newItem = 'newItem';

      MemoryCache.instance
          .create<String>(newKey, item, expiry: Duration(seconds: 1));
      await Future.delayed(Duration(seconds: 2));
      final isUpdated = MemoryCache.instance.update<String>(newKey, newItem);
      expect(isUpdated, false);
    });

    test('check if cache is empty', () async {
      MemoryCache.instance.invalidate();
      final isEmpty = MemoryCache.instance.isEmpty;
      expect(isEmpty, true);
    });
  });
}
