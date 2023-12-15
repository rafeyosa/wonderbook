import 'package:flutter/material.dart';
import 'package:wonderbook/core/constants/constant.dart';
import 'package:wonderbook/core/themes/assets.dart';
import 'package:wonderbook/presentation/book_detail/view/book_detail_view.dart';
import 'package:wonderbook/presentation/book_list/view/book_list_view.dart';

import '../presenter/home_contract.dart';
import '../presenter/home_presenter.dart';
import 'widgets/book_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeContract {
  late HomePresenter _presenter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _presenter = HomePresenter(this);
    _presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          Assets.imgLogoAppbar,
          fit: BoxFit.fitHeight,
          height: AppBar().preferredSize.height - 10,
        ),
      ),
      body: _presenter.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BookSection(
                    sectionName: 'Daily Recommendation',
                    books: _presenter.books.sublist(0, 3),
                    onTapSeeAll: () {
                      Navigator.pushNamed(
                        context,
                        BookListView.routeName,
                        arguments: {
                          Constant.title: 'All Books',
                          Constant.books: _presenter.books
                        },
                      ).whenComplete(() {
                        _presenter.init();
                      });
                    },
                    onTapBook: (book) {
                      Navigator.pushNamed(
                        context,
                        BookDetailView.routeName,
                        arguments: book,
                      ).whenComplete(() {
                        _presenter.init();
                      });
                    },
                    isShowTag: true,
                  ),
                  if (_presenter.bookmarkBooks.isNotEmpty) ...[
                    BookSection(
                      sectionName: 'Bookmark by you',
                      books: _presenter.bookmarkBooks,
                      onTapSeeAll: () {
                        Navigator.pushNamed(
                          context,
                          BookListView.routeName,
                          arguments: {
                            Constant.title: 'Bookmark',
                            Constant.books: _presenter.bookmarkBooks
                          },
                        ).whenComplete(() {
                          _presenter.init();
                        });
                      },
                      onTapBook: (book) {
                        Navigator.pushNamed(
                          context,
                          BookDetailView.routeName,
                          arguments: book,
                        ).whenComplete(() {
                          _presenter.init();
                        });
                      },
                    ),
                  ],
                  BookSection(
                    sectionName: 'New Book',
                    books: _presenter.newBooks,
                    onTapSeeAll: () {
                      Navigator.pushNamed(
                        context,
                        BookListView.routeName,
                        arguments: {
                          Constant.title: 'New Book',
                          Constant.books: _presenter.newBooks
                        },
                      ).whenComplete(() {
                        _presenter.init();
                      });
                    },
                    onTapBook: (book) {
                      Navigator.pushNamed(
                        context,
                        BookDetailView.routeName,
                        arguments: book,
                      ).whenComplete(() {
                        _presenter.init();
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  @override
  void update() {
    setState(() {});
  }
}
