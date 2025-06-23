import 'package:flutter/material.dart';
import '../models/person.dart';
import 'person_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Person> favoritePersons;
  const FavoritesScreen({Key? key, required this.favoritePersons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Favorite Persons',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: favoritePersons.isEmpty
          ? const Center(child: Text('No favorites yet!'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoritePersons.length,
              itemBuilder: (context, index) {
                final person = favoritePersons[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonDetailsScreen(person: person),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      person.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
