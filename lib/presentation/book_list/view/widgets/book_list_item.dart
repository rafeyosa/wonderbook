import 'package:flutter/material.dart';
import 'package:wonderbook/core/constants/constant.dart';
import 'package:wonderbook/core/extensions/string_extension.dart';
import 'package:wonderbook/core/themes/app_colors.dart';
import 'package:wonderbook/data/models/book.dart';
import 'package:wonderbook/presentation/book_list/view/widgets/rating_icon.dart';
import 'package:wonderbook/presentation/chapter_detail/view/chapter_detail_view.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    Key? key,
    required this.onTap,
    required this.book,
  }) : super(key: key);

  final Function() onTap;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 144,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  book.pictureUrl.orEmpty,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.insert_photo,
                        color: Colors.white24,
                        size: 100,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      book.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.author.orEmpty,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textGray,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RatingIcon(
                      icon: Icons.star,
                      size: 24,
                      iconColor: Colors.yellow.shade800,
                      rating: book.rating ?? 0,
                      maxRating: 5,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ChapterDetailView.routeName,
                                arguments: {
                                  Constant.title: book.name,
                                  Constant.chapter:
                                  book.chapters?.last,
                                },
                              );
                            },
                            child: Text(
                              'Read ${(book.chapters ?? []).last.name}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
