import 'package:flutter/cupertino.dart';
import 'package:wonderbook/core/extensions/string_extension.dart';
import 'package:wonderbook/core/themes/app_colors.dart';
import 'package:wonderbook/data/models/book.dart';

import 'book_item.dart';

class BookSection extends StatelessWidget {
  const BookSection({
    Key? key,
    required this.sectionName,
    required this.onTapSeeAll,
    required this.onTapBook,
    required this.books,
    this.isShowTag = false,
  }) : super(key: key);

  final String sectionName;
  final Function() onTapSeeAll;
  final Function(Book book) onTapBook;
  final List<Book> books;
  final bool isShowTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  sectionName,
                  style: const TextStyle(
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onTapSeeAll,
                child: const Text(
                  'See All',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 24, right: 24),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              var book = books.elementAt(index);
              return BookItem(
                onTap: () => onTapBook(book),
                name: book.name,
                imageUrl: book.pictureUrl.orEmpty,
                lastChapter: book.chapters?.last.name,
                isShowTag: isShowTag,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12),
          ),
        ),
      ],
    );
  }
}
