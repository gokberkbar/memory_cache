import 'package:memory_cache/memory_cache.dart';

void main() {
  MemoryCache.instance.create(
    'myKey',
    'myValue',
    expiry: const Duration(seconds: 5),
  );
  String? myValue = MemoryCache.instance.read<String>('myKey');
  print(myValue);
  MemoryCache.instance.update('myKey', 'myUpdatedValue');
  myValue = MemoryCache.instance.read<String>('myKey');
  print(myValue);
  MemoryCache.instance.delete('myKey');
  myValue = MemoryCache.instance.read<String>('myKey');
  print(myValue);

  final MemoryCache localCache = MemoryCache();
  localCache.create(
    'myKey',
    'myValue',
    expiry: const Duration(seconds: 5),
  );
  String? localCacheValue = localCache.read<String>('myKey');
  print(localCacheValue);
  print(MemoryCache.instance.read<String>('myKey'));
}
