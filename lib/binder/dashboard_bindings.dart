import 'package:get/instance_manager.dart';
import 'package:sight_companion/controller/translate.dart';

class TranslateBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranslaterController>(() => TranslaterController(),
        fenix: true);
  }
}
