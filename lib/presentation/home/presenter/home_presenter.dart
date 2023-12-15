import 'package:wonderbook/core/base/base_presenter.dart';
import 'package:wonderbook/core/constants/storage_constant.dart';
import 'package:wonderbook/core/extensions/string_extension.dart';
import 'package:wonderbook/data/models/book.dart';
import 'package:wonderbook/data/services/local_services.dart';
import 'package:wonderbook/data/services/storage_services.dart';

import 'home_contract.dart';

class HomePresenter extends BasePresenter<HomeContract> {
  HomePresenter(super.contract);

  bool isLoading = false;
  List<Book> books = [];
  List<Book> bookmarkBooks = [];
  List<Book> newBooks = [];

  void init() async {
    isLoading = true;
    contract.update();

    await _getBooks();
    await _getBookmarkBooks();
    await _getNewBooks();

    isLoading = false;
    contract.update();
  }

  Future<void> _getBooks() async {
    books = await LocalServices().getBooks() ?? [];
  }

  Future<void> _getBookmarkBooks()async {
    var bookmarkList = await StorageServices().getStringList(StorageConstant.bookmark) ?? [];
    List<Book> bookmarkBooks = [];

    for (Book book in books) {
      for (String bookmark in bookmarkList) {
        if (book.id == bookmark) {
          bookmarkBooks.add(book);
          break;
        }
      }
    }
    this.bookmarkBooks = bookmarkBooks;
  }

  Future<void> _getNewBooks() async {
    List<Book> newBooks = [];
    int currentYear = DateTime.now().year;

    for (Book book in books) {
      var release = int.tryParse(book.release.orEmpty);
      if (release == currentYear) {
        newBooks.add(book);
      }
    }
    this.newBooks = newBooks;
  }
}