import 'package:flutter/material.dart';
import 'package:wonderbook/presentation/book_detail/view/book_detail_view.dart';
import 'package:wonderbook/presentation/book_list/view/book_list_view.dart';
import 'package:wonderbook/presentation/chapter_detail/view/chapter_detail_view.dart';
import 'package:wonderbook/presentation/home/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wonderbook',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surfaceTint: Colors.white
        ),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      initialRoute: HomeView.routeName,
      routes: {
        HomeView.routeName: (context) => const HomeView(),
        BookListView.routeName: (context) => const BookListView(),
        BookDetailView.routeName: (context) => const BookDetailView(),
        ChapterDetailView.routeName: (context) => const ChapterDetailView(),
      },
    );
  }
}
