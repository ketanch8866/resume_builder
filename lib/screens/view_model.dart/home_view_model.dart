import 'package:get/get.dart';
import 'package:resume_builder/res/app_const.dart';

class HomeController extends GetxController {
  Rx<Status> _status = Status.loading.obs;
  Rx<Status> get status => _status;
  RxInt _selectedIndex = 0.obs;
  RxInt get selectedIndex => _selectedIndex;
  @override
  void onInit() {
    super.onInit();
  }

  setStatus(Status sta) {
    _status.value = sta;
  }
}