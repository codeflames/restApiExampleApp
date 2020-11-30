import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_api_app/model/post_model.dart';

class PostApiCalls {
  List<Post> parsePost(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future<List<Post>> fetchPosts() async {
    final String url = 'https://jsonplaceholder.typicode.com/posts';

    try {
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return parsePost(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
