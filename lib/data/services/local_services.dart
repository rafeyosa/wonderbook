import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import '../models/book.dart';

class LocalServices {
  Future<List<Book>?> getBooks() async {
    try {
      final String response =
          await rootBundle.loadString('assets/local_book.json');
      List<Book> model = _parseBooks(response);
      return model;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  List<Book> _parseBooks(String? json) {
    if (json == null) {
      return [];
    }
    final data = jsonDecode(json);
    return List<Book>.from(data["books"].map((x) => Book.fromJson(x)));
  }
}
