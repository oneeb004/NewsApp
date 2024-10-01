import 'package:news_app/models/news_category_model.dart';
import 'package:news_app/models/news_channel_healines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _api = NewsRespository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String newsChannel) async {
    final response = await _api.fetchNewsChannelHeadlinesApi(newsChannel);
   

    return response;
  }



   Future<CategoryModel> fetchCategoriesNewsApi(
      String category) async {
    final response = await _api.fetchCategoriesNewsApi(category);
    

    return response;
  }
}
