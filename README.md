# Memory Cache

Memory Cache is simple, fast and global in-memory cache.

## Features

- Create, read, update, delete and invalidate cache.
- Expirable Cache

## Getting started

### Use this package as a Library
---
Depend On it

Run this command

with Dart: 
```
$ dart pub add memory_cache
```
with Flutter: 
```
$ flutter pub add memory_cache
```
This will add a line like this to your package's pubspec.yaml (and run an implicit `dart pub get` or `flutter pub get`):
```
dependencies:
  memory_cache: ^1.0.0
```

## Usage

### Create New Value
```dart
MemoryCache.instance.create('myKey', 'myValue');
```
with Expiry:
```dart
MemoryCache.instance.create(
    'myKey',
    'myValue',
    expiry: const Duration(seconds: 5),
  );
```

### Read Value
```dart
final myValue = MemoryCache.instance.read<String>('myKey');
```

### Update Value
```dart
MemoryCache.instance.update('myKey', 'myUpdatedValue');
```

### Delete Value
```dart
MemoryCache.instance.delete('myKey');
```
