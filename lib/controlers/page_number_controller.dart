import 'package:get/get.dart';
import 'package:shirikisho_drivers/module/page_number.dart';

class PageNumberController extends GetxController {
  var pageindexSelected = PageNumberModule(selectedPageNum: 0).obs;

  void changeSelectedIndex({required int newselectedIndex}) {
    pageindexSelected.update((val) {
      val!.selectedPageNum = newselectedIndex;
    });
  }
}

class PageOnViewController extends GetxController {
  var pageOnView = PageonViewModule(pageName: 'home').obs;

  void changePageonView({required String currentOnView}) {
    pageOnView.update((val) {
      val!.pageName = currentOnView;
    });
  }
}
