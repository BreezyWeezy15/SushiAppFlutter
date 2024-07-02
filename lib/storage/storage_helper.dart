

import 'package:get_storage/get_storage.dart';

class StorageHelper {

  static final _box = GetStorage();

  static bool isStarted(){
    return _box.read('isStarted') ?? false;
  }
  static void setStarted(){
    _box.write('isStarted', true);
  }
}