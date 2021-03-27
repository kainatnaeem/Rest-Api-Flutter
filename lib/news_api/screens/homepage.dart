import 'package:RestApiFirstExample/news_api/model/newsModel.dart';
import 'package:RestApiFirstExample/news_api/services/api.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = NewsApi().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.articles[index];
                   var formattedTime = DateFormat('dd MMM - HH:mm')
                        .format(article.publishedAt);
                    return Column(
                      children: [
                        Column(children:[Card(
                                                  child: Image.network(
                                        article.urlToImage,
                                        fit: BoxFit.cover,

                                      ),
                        )]),
                        Container(
                          height: 100,
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[
                          
                             
                              SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(formattedTime),
                                    Text(
                                      article.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      article.description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                             
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}