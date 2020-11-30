import 'package:flutter/material.dart';
import 'package:rest_api_app/network/post_api_calls.dart';

import 'model/post_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final post = new PostApiCalls();
  Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = post.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: futurePosts,
          builder: (context, postSnapshot) {
            if (postSnapshot.hasData) {
              return ListView.builder(
                  itemCount: postSnapshot.data.length,
                  itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: Text(postSnapshot.data[index].id.toString()),
                          title: Text(postSnapshot.data[index].title),
                          subtitle: Text(postSnapshot.data[index].body),
                        ),
                      ));
            } else if (postSnapshot.hasError) {
              return Center(child: Text(postSnapshot.error.toString()));
            }
            return Center(
                child: GestureDetector(
                    onTap: () {
                      post.fetchPosts();
                    },
                    child: CircularProgressIndicator()));
          }),
    );
  }
}
