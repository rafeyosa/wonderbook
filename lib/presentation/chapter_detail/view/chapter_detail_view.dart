import 'package:flutter/material.dart';
import 'package:wonderbook/core/constants/constant.dart';
import 'package:wonderbook/core/extensions/string_extension.dart';
import 'package:wonderbook/core/themes/app_colors.dart';
import 'package:wonderbook/data/models/chapter.dart';

class ChapterDetailView extends StatelessWidget {
  const ChapterDetailView({super.key});

  static const routeName = '/books/chapter';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final String title = arguments[Constant.title];
    final Chapter? chapter = arguments[Constant.chapter];

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
        title: Column(
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              (chapter?.name).orEmpty,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          child: Text(
            (chapter?.content).orEmpty,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: AppColors.textBlack,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
