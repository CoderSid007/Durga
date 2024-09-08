import 'package:durga/screens/ArticleDetailScreen.dart';
import 'package:durga/screens/anotherNewsScreen.dart';
import 'package:durga/screens/eventsPage.dart';
import 'package:durga/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List articles = [];

  Future<void> fetchNews() async {
    final url =
        'https://newsapi.org/v2/everything?q="Durga Puja"&apiKey=651a1dfc2ca345df91b92471cce8f6de';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = data['articles'];
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
    fetchNews();
  }

  Future<bool> _onWillPop() async {
    // Return false to prevent the back button from working
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

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
      currentIndex: 0,
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: const Color.fromARGB(255, 143, 141, 141),
      onTap: (index) {
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




















// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List articles = [];

//   Future<void> fetchNews() async {
//     final url =
//         'https://newsapi.org/v2/everything?q="Durga Puja"&apiKey=651a1dfc2ca345df91b92471cce8f6de';

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           articles = data['articles'];
//         });
//       } else {
//         throw Exception('Failed to load news');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }

//   Future<bool> _onWillPop() async {
//     // Return false to prevent the back button from working
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 fontFamily: 'DMSans',
//                 fontSize: 25.0,
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 fontWeight: FontWeight.bold,
//               ),
//               'Top News'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.logout),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LogIn()),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: articles.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             : ListView.builder(
//                 itemCount: articles.length,
//                 itemBuilder: (context, index) {
//                   final article = articles[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ArticleDetailScreen(article: article),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       elevation: 1,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (article['urlToImage'] != null)
//                             ClipRRect(
//                               borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(8.0)),
//                               child: Image.network(
//                                 article['urlToImage'],
//                                 width: double.infinity,
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   article['title'] ?? 'No Title',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   article['description'] ?? 'No Description',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.grey[600],
//                                   ),
//                                   maxLines: 3,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//         bottomNavigationBar: BottomNavBar(),
//       ),
//     );
//   }
// }

// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Color.fromARGB(255, 0, 0, 0),
//       type: BottomNavigationBarType.fixed,
//       items: [
//         BottomNavigationBarItem(
//             icon: Icon(Icons.newspaper), label: "Pujo abar'o asbe!"),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.newspaper), label: 'We want justice'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.event_available), label: 'Events'),
//       ],
//       currentIndex: 0,
//       selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
//       unselectedItemColor: const Color.fromARGB(255, 143, 141, 141),
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//             break;
//           case 1:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AnotherNewsScreen()),
//             );
//             break;
//           case 2:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => EventsScreen()),
//             );
//             break;
//         }
//       },
//     );
//   }
// }
