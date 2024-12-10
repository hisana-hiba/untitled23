import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../Models/Article model.dart';

import '../Views/Api-key.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getAllNews(String countryCode) async {
    try {
      String url = 'https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=$countryCode&max=10&apikey=$apiKey2';
      var parsedUrl = await Uri.parse(url);
      var response = await http.get(parsedUrl);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        jsonData['articles'].forEach((element) {
          if (element['image'] != null &&
              element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['image'],
              content: element['content'],
            );
            news.add(articleModel);
          }
        });
      } else {
        print('Error: Failed to load data');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getCategoryNews(String category, String countryCode) async {
    try {
      String url =
          'https://gnews.io/api/v4/top-headlines?category=$category&lang=en&country=$countryCode&max=10&apikey=$apiKey2';

      var parsedUrl = Uri.parse(url);
      var response = await http.get(parsedUrl);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        jsonData['articles'].forEach((element) {
          if (element['image'] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['image'],
              content: element['content'],
            );
            news.add(articleModel);
          }
        });

      } else {
        // Handle different error codes
        switch (response.statusCode) {
          case 400:
            print('Bad Request: Invalid API request.');
            break;
          case 401:
            print('Unauthorized: Invalid API key.');
            break;
          case 403:
            print('Forbidden: API quota exceeded.');
            break;
          case 429:
            print('Too Many Requests: Rate limit exceeded.');
            break;
          case 500:
            print('Internal Server Error: Try again later.');
            break;
          case 503:
            print('Service Unavailable: API temporarily down.');
            break;
          default:
            print('Error: Failed to load data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

}