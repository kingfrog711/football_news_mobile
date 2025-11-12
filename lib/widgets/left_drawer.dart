import 'package:flutter/material.dart';
import 'package:football_news/screens/menu.dart';
import 'package:football_news/screens/news_entry_list.dart';
import 'package:football_news/screens/newslist_form.dart';


class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'Football News',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "All the latest football updates here!",
                  // TODO: Add text style with center alignment, font size 15, white color, and normal weight
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Redirect to MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Add News'),
            // Redirect to NewsFormPage
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('See News'),
            onTap: () {
              // Route to news list page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsEntryListPage()),
              );
            },
          ),
          
        ],
      ),
    );
  }
}
