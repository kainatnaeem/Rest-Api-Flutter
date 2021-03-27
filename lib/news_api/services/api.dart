import 'dart:convert';

import 'package:RestApiFirstExample/news_api/constants.dart';
import 'package:RestApiFirstExample/news_api/model/newsModel.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Strings.newsUrl);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
