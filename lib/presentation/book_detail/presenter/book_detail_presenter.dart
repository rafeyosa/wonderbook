import 'package:flutter/material.dart';
import 'package:wonderbook/core/base/base_presenter.dart';
import 'package:wonderbook/core/constants/storage_constant.dart';
import 'package:wonderbook/data/models/book.dart';
import 'package:wonderbook/data/services/storage_services.dart';

import 'book_detail_contract.dart';

class BookDetailPresenter extends BasePresenter<BookDetailContract> {
  BookDetailPresenter(super.contract);

  final kExpandedHeight = 250.0;
  double get horizontalTitlePadding {
    const kBasePadding = 25.0;
    const kMultiplier = 0.5;

    if (scrollController.hasClients) {
      if (scrollController.offset < (kExpandedHeight / 2)) {
        double fullExpanded = kBasePadding;
        return fullExpanded;
      }
      if (scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        double noExpanded =
            (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
                kBasePadding;
        return noExpanded;
      }
      double halfExpanded =
          (scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
              kBasePadding;
      return halfExpanded;
    }
    return kBasePadding;
  }
  double get titleLerp {
    if (scrollController.hasClients) {
      if (scrollController.offset < (kExpandedHeight / 2)) {
        return 0;
      }
      if (scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        return 1;
      }
      return 0.5;
    }
    return 0;
  }

  late ScrollController scrollController;
  late Book book;
  bool isShowMore = false;
  bool isBookmark = false;

  void init(Book book) async {
    scrollController = ScrollController()
      ..addListener(() {
        contract.update();
      });
    this.book = book;
    _checkBookmark(book.id);
  }

  void onRefresh() {
    _checkBookmark(book.id);
  }

  void _checkBookmark(String id) async {
    var bookmarkList = await StorageServices().getStringList(StorageConstant.bookmark) ?? [];
    isBookmark = bookmarkList.contains(id);
    contract.update();
  }

  void onShowMore() {
    isShowMore = !isShowMore;
    contract.update();
  }

  void onBookmark() async {
    isBookmark = !isBookmark;
    var bookmarkList = await StorageServices().getStringList(StorageConstant.bookmark) ?? [];
    if (isBookmark) {
      bookmarkList.add(book.id);
      StorageServices().setStringList(StorageConstant.bookmark, bookmarkList);
    } else {
      bookmarkList.remove(book.id);
      StorageServices().setStringList(StorageConstant.bookmark, bookmarkList);
    }
    contract.update();
  }
}
