import 'package:flutter/material.dart';
import 'package:football_news/models/news_entry.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/screens/news_detail.dart';
import 'package:football_news/widgets/news_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_news/screens/news_detail.dart';


class NewsEntryListPage extends StatefulWidget {
  const NewsEntryListPage({super.key});

  @override
  State<NewsEntryListPage> createState() => _NewsEntryListPageState();
}

class _NewsEntryListPageState extends State<NewsEntryListPage> {
  Future<List<NewsEntry>> fetchNews(CookieRequest request) async {
    // TODO: Replace the URL with your app's URL and don't forget to add a trailing slash (/)!
    // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
    // If you using chrome,  use URL http://localhost:8000
    
    final response = await request.get('http://localhost:8000/news/json/');
    
    // Decode response to json format
    var data = response;
    
    // Convert json data to NewsEntry objects
    List<NewsEntry> listNews = [];
    for (var d in data) {
      if (d != null) {
        listNews.add(NewsEntry.fromJson(d));
      }
    }
    return listNews;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<NewsEntry>>(
        future: fetchNews(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Failed to load news: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            );
          }

          final newsList = snapshot.data;

          if (newsList == null || newsList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.newspaper, size: 48, color: Color(0xff59A5D8)),
                  SizedBox(height: 12),
                  Text(
                    'There are no news in football news yet.',
                    style: TextStyle(fontSize: 18, color: Color(0xff59A5D8)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: newsList.length,
              itemBuilder: (_, index) => NewsEntryCard(
                news: newsList[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(
                        news: newsList[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}