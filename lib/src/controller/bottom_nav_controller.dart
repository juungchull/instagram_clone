import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/pages/upload.dart';

enum PageName {
  HOME,
  SEARCH,
  UPLOAD,
  ACTIVITY,
  MYPAGE,
}

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    // if (bottomHistory.last != value) {

    // }
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
    // print(bottomHistory);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                title: '시스템',
                message: '종료하시겠습니까?',
                okCallback: () {
                  exit(0);
                },
                cancelCallback: Get.back,
              ));
      // print('exit!');
      return true;
    } else {
      print("go to page before!");
      var index = bottomHistory.removeLast();
      changeBottomNav(index, hasGesture: false);
      // print(bottomHistory);
      return false;
    }
  }
}
