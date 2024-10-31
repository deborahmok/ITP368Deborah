import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testtrial/NewsItem.dart';
import 'dart:convert';

class NewsItemPage extends StatelessWidget{
  final int id;
  NewsItemPage(this.id, {super.key});

  @override
  Widget build(BuildContext context)
  {
    Future<NewsItem> ni = fetch(id);
    return Scaffold(
      appBar: AppBar(title: Text("news item page")),
      body: FutureBuilder
        (future: ni,
          builder: (context, snapshot)
          { if(snapshot.hasData)
            {return Text( snapshot.data!.text);}
            else
            { return Text("loading item");}
          }
        )
    );
  }
}

Future<NewsItem> fetch (int id) async
{
  String root = "https://hacker-news.firebaseio.com/v0/";
  final url = Uri.parse('${root}item/${id}.json');
  final response = await http.get(url);
  Map<String,dynamic> theItem = jsonDecode(response.body);
  NewsItem ni = NewsItem.fromJson( theItem );
  return ni;
}