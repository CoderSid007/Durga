import 'package:durga/screens/ArticleDetailScreen.dart';
import 'package:durga/screens/eventsPage.dart';
import 'package:durga/screens/homeScreen.dart';
import 'package:durga/screens/loginScreen.dart';
import 'package:durga/utils/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// For JSON decoding

class AnotherNewsScreen extends StatefulWidget {
  @override
  _AnotherNewsScreenState createState() => _AnotherNewsScreenState();
}

class _AnotherNewsScreenState extends State<AnotherNewsScreen> {
  List articles = [];

  // Function to fetch news from an API
  Future<void> fetchNews() async {
    final url =
        'https://newsapi.org/v2/everything?q="RG Kar Medical"&apiKey=651a1dfc2ca345df91b92471cce8f6de';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Parse JSON response
        setState(() {
          articles = data['articles']; // Assign the articles from response
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews(); // Fetch news on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 25.0,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
            'Top News'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );
            },
          ),
        ],
      ),
      body: articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to ArticleDetailScreen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleDetailScreen(article: article),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image at the top
                        if (article['urlToImage'] != null)
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8.0)),
                            child: Image.network(
                              article['urlToImage'],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title below the image
                              Text(
                                article['title'] ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              // Description below the title
                              Text(
                                article['description'] ?? 'No Description',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.newspaper), label: "Pujo abar'o asbe!"),
        BottomNavigationBarItem(
            icon: Icon(Icons.newspaper), label: 'We want justice'),
        BottomNavigationBarItem(
            icon: Icon(Icons.event_available), label: 'Events'),
      ],
      currentIndex: 1,
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: const Color.fromARGB(255, 143, 141, 141),
      onTap: (index) {
        // Handle navigation
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnotherNewsScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventsScreen()),
            );
            break;
        }
      },
    );
  }
}
