import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/api_service.dart';
import 'package:photo_view/photo_view.dart';
import '../favorite_manager.dart';

class PersonDetailsScreen extends StatefulWidget {
  final Person person;
  const PersonDetailsScreen({Key? key, required this.person}) : super(key: key);

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  final ApiService _apiService = ApiService();
  Person? _personDetails;
  bool _isLoading = true;
  String? _error;

  bool get isFavorite => FavoriteManager.favoriteIds.contains(widget.person.id);

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        FavoriteManager.favoriteIds.remove(widget.person.id);
      } else {
        FavoriteManager.favoriteIds.add(widget.person.id);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPersonDetails();
  }

  Future<void> _loadPersonDetails() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final details = await _apiService.getPersonDetails(widget.person.id);
      setState(() {
        _personDetails = details;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          widget.person.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.cyan))
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading data',
                        style: TextStyle(color: Colors.red[700]),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadPersonDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _personDetails == null
                  ? const Center(child: Text('No data found'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (_personDetails!.profilePath != null)
                            Container(
                              width: double.infinity,
                              height: 400,
                              color: Colors.black12,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: PhotoView(
                                  imageProvider: NetworkImage('https://image.tmdb.org/t/p/w780${_personDetails!.profilePath}'),
                                  backgroundDecoration: const BoxDecoration(color: Colors.black12),
                                  minScale: PhotoViewComputedScale.contained * 0.5,
                                  maxScale: PhotoViewComputedScale.covered * 3,
                                  initialScale: PhotoViewComputedScale.contained,
                                  enableRotation: false,
                                ),
                              ),
                            ),
                          const SizedBox(height: 40),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyan.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _personDetails!.name,
                                        style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    IconButton(
                                      icon: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : Colors.white,
                                      ),
                                      onPressed: toggleFavorite,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (_personDetails!.biography != null && _personDetails!.biography!.isNotEmpty)
                                  Text(
                                    _personDetails!.biography!,
                                    style: const TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                const SizedBox(height: 16),
                                if (_personDetails!.birthday != null)
                                  Text('Birthday: ${_personDetails!.birthday!}', style: const TextStyle(color: Colors.white)),
                                if (_personDetails!.placeOfBirth != null)
                                  Text('Place of Birth: ${_personDetails!.placeOfBirth!}', style: const TextStyle(color: Colors.white)),
                                if (_personDetails!.knownForDepartment != null)
                                  Text('Known For: ${_personDetails!.knownForDepartment!}', style: const TextStyle(color: Colors.white)),
                                if (_personDetails!.alsoKnownAs != null && _personDetails!.alsoKnownAs!.isNotEmpty)
                                  Text('Also Known As: ${_personDetails!.alsoKnownAs!.join(", ")}', style: const TextStyle(color: Colors.white)),
                                if (_personDetails!.popularity != null)
                                  Text('Popularity: ${_personDetails!.popularity!.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                                if (_personDetails!.deathday != null)
                                  Text('Deathday: ${_personDetails!.deathday!}', style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
