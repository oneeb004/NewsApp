import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_category_model.dart';
import 'package:news_app/models/news_channel_healines_model.dart';

class NewsRespository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String newsChannel) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$newsChannel&apiKey=YOURAPIKEY";

    final response = await http.get(Uri.parse(url));
    // print(response.body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception("Error");
  }


  Future<CategoryModel> fetchCategoriesNewsApi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=YOURAPIKEY";

    final response = await http.get(Uri.parse(url));
    // print(response.body);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return CategoryModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
