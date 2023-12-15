import 'package:flutter/material.dart';
import 'package:wonderbook/core/extensions/string_extension.dart';
import 'package:wonderbook/core/themes/app_colors.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    Key? key,
    required this.onTap,
    required this.name,
    required this.imageUrl,
    required this.lastChapter,
    this.isShowTag = false,
  }) : super(key: key);

  final Function() onTap;
  final String name;
  final String imageUrl;
  final String? lastChapter;
  final bool isShowTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 216,
                width: 150,
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
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
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
              if (isShowTag && !lastChapter.isNullOrEmpty) ...[
                Container(
                  height: 30,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: AppColors.tertiary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      lastChapter.orEmpty,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 120,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
