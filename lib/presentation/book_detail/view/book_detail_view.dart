import 'package:flutter/material.dart';
import 'package:wonderbook/core/constants/constant.dart';
import 'package:wonderbook/core/extensions/string_extension.dart';
import 'package:wonderbook/core/themes/app_colors.dart';
import 'package:wonderbook/data/models/book.dart';
import 'package:wonderbook/presentation/book_list/view/widgets/rating_icon.dart';
import 'package:wonderbook/presentation/chapter_detail/view/chapter_detail_view.dart';

import '../presenter/book_detail_contract.dart';
import '../presenter/book_detail_presenter.dart';

class BookDetailView extends StatefulWidget {
  const BookDetailView({super.key});

  static const routeName = '/books/detail';

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView>
    implements BookDetailContract {
  late BookDetailPresenter _presenter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final book = ModalRoute.of(context)?.settings.arguments as Book;
    _presenter = BookDetailPresenter(this);
    _presenter.init(book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _presenter.scrollController,
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color.lerp(
                    Colors.white,
                    Colors.black,
                    _presenter.titleLerp,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: AppColors.surface,
              shadowColor: Colors.black87,
              elevation: 20.0,
              pinned: true,
              expandedHeight: _presenter.kExpandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  _presenter.book.pictureUrl ?? '',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
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
                title: Text(
                  _presenter.book.name,
                  overflow:
                      _presenter.titleLerp > 0 ? TextOverflow.ellipsis : null,
                  style: TextStyle(
                    color: Color.lerp(
                      Colors.white,
                      Colors.black,
                      _presenter.titleLerp,
                    ),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                titlePadding: EdgeInsetsDirectional.only(
                  start: _presenter.horizontalTitlePadding,
                  bottom: 16,
                  end: 15,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dirilis',
                              style: TextStyle(
                                color: AppColors.textGray,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _presenter.book.release.orEmpty,
                              style: const TextStyle(
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Author',
                              style: TextStyle(
                                color: AppColors.textGray,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _presenter.book.author.orEmpty,
                              style: const TextStyle(
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      RatingIcon(
                        icon: Icons.star,
                        size: 24,
                        iconColor: Colors.yellow.shade800,
                        rating: _presenter.book.rating ?? 0,
                        maxRating: 5,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_presenter.book.rating}',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sinopsis',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _presenter.book.description ?? '',
                    maxLines: _presenter.isShowMore ? null : 7,
                    overflow:
                        _presenter.isShowMore ? null : TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _presenter.onShowMore,
                    child: Text(
                      _presenter.isShowMore
                          ? 'Lihat lebih sedikit'
                          : 'Lihat lebih banyak',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 32,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _presenter.book.genre?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            _presenter.book.genre![index],
                            style: const TextStyle(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: _presenter.onBookmark,
                          icon: Icon(
                            _presenter.isBookmark
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                          label: const Text(
                            'Bookmark',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Baca ${_presenter.book.name}',
                    style: const TextStyle(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: List.generate(
                      _presenter.book.chapters?.length ?? 0,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ChapterDetailView.routeName,
                              arguments: {
                                Constant.title: _presenter.book.name,
                                Constant.chapter:
                                    _presenter.book.chapters?.elementAt(index),
                              },
                            ).whenComplete(() => _presenter.onRefresh());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _presenter.book.chapters![index].name,
                                    style: const TextStyle(
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _presenter
                                      .book.chapters![index].uploadDate.orEmpty,
                                  style: const TextStyle(
                                    color: AppColors.textGray,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
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
