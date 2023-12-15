import 'package:flutter/material.dart';
import 'package:wonderbook/core/constants/constant.dart';
import 'package:wonderbook/core/themes/app_colors.dart';
import 'package:wonderbook/data/models/book.dart';
import 'package:wonderbook/presentation/book_detail/view/book_detail_view.dart';
import 'package:wonderbook/presentation/book_list/view/widgets/book_list_item.dart';

class BookListView extends StatelessWidget {
  const BookListView({super.key});

  static const routeName = '/books';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final String title = arguments[Constant.title];
    final List<Book> books = arguments[Constant.books];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.surface,
        shadowColor: Colors.black87,
        elevation: 5.0,
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 40),
          child: Column(
            children: List.generate(
              books.length,
              (index) {
                return BookListItem(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      BookDetailView.routeName,
                      arguments: books.elementAt(index),
                    );
                  },
                  book: books.elementAt(index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
