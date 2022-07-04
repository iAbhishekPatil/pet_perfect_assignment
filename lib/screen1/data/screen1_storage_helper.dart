import 'package:hive_flutter/hive_flutter.dart';

abstract class Screen1StorageHelper {
  static const boxName = 'screen1Box';
  static final _box = Hive.box(boxName);

  static void storeURL({required String url}) {
    _box.put('url', url);
  }

  static String? getURL() {
    return _box.get('url') as String?;
  }
}
