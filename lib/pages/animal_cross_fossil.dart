import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FossilsList extends StatefulWidget {
  @override
  _FossilsListState createState() => _FossilsListState();
}

class _FossilsListState extends State<FossilsList> {
  List<dynamic> fossils = [];
  List<dynamic> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchFossils();
  }

  Future<void> fetchFossils() async {
    final response = await http.get(Uri.parse('https://acnhapi.com/v1/fossils'));
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      setState(() {
        fossils = decodedResponse.values.toList();
      });
    } else {
      print('Failed to fetch fossils');
    }
  }

  void navigateToDetailPage(dynamic fossil) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FossilDetailPage(fossil: fossil),
      ),
    );
    if (result != null) {
      setState(() {
        favorites.add(result);
      });
    }
  }

  void navigateToFavoritesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(favorites: favorites),
      ),
    );
  }

  bool isFossilFavorite(dynamic fossil) {
    return favorites.contains(fossil);
  }

  void toggleFavorite(dynamic fossil) {
    setState(() {
      if (isFossilFavorite(fossil)) {
        favorites.remove(fossil);
      } else {
        favorites.add(fossil);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ACNH Fossils'),
      ),
      body: ListView.builder(
        itemCount: fossils.length,
        itemBuilder: (BuildContext context, int index) {
          final fossil = fossils[index];
          return Card(
            elevation: 2.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(
                fossil['name']['name-USen'],
                style: TextStyle(fontSize: 18.0),
              ),
              trailing: IconButton(
                icon: Icon(
                  isFossilFavorite(fossil) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  toggleFavorite(fossil);
                },
              ),
              onTap: () {
                navigateToDetailPage(fossil);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToFavoritesPage();
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}

class FossilDetailPage extends StatelessWidget {
  final dynamic fossil;

  const FossilDetailPage({required this.fossil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fossil['name']['name-USen']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Image.network(
              fossil['image_uri'],
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Price: ${fossil['price']}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Museum phrase:',
              style: TextStyle(fontSize: 20.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                fossil['museum-phrase'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, fossil);
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<dynamic> favorites;

  const FavoritesPage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (BuildContext context, int index) {
          final fossil = favorites[index];
          return ListTile(
            title: Text(fossil['name']['name-USen']),
          );
        },
      ),
    );
  }
}
