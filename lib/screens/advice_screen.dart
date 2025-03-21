import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  AdviceScreenState createState() => AdviceScreenState();
}

class AdviceScreenState extends State<AdviceScreen> {
  final String apiKey = "AIzaSyBj5DMfg4vMmjV0-nQC7Dk--FzzU4oXi-U";
  final String searchQuery = "cuidado de la piel y cáncer de piel";
  List<Map<String, String>> _videos = [];
  Set<String> _watchedVideos = {}; // Videos vistos
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWatchedVideos();
    _fetchVideos();
  }

  Future<void> _loadWatchedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _watchedVideos = prefs.getStringList("watchedVideos")?.toSet() ?? {};
    });
  }

  Future<void> _saveWatchedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("watchedVideos", _watchedVideos.toList());
  }

  Future<void> _fetchVideos() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          "https://www.googleapis.com/youtube/v3/search"
          "?part=snippet"
          "&maxResults=15"
          "&q=$searchQuery"
          "&type=video"
          "&key=$apiKey"
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data["items"];

        setState(() {
          _videos = items.map((video) => {
                'title': video["snippet"]["title"].toString(),
                'thumbnail': video["snippet"]["thumbnails"]["high"]["url"].toString(),
                'videoId': video["id"]["videoId"].toString(),
              }).toList();
        });
      } else {
        debugPrint("Error en la API de YouTube: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error al obtener videos: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _markAsWatched(String videoId) {
    setState(() {
      _watchedVideos.add(videoId);
    });
    _saveWatchedVideos();
  }

  void _openVideoPlayer(String videoId) {
    _markAsWatched(videoId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoId: videoId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // ✅ Estilo tipo Netflix
      appBar: AppBar(
        title: const Text("Cuidado de la Piel", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : ListView(
              children: [
                _buildVideoSection("Videos Recomendados", _videos.sublist(0, _videos.length ~/ 2)),
                _buildVideoSection("Videos Más Vistos", _videos.sublist(_videos.length ~/ 2)),
              ],
            ),
    );
  }

  Widget _buildVideoSection(String title, List<Map<String, String>> videos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 200, // ✅ Carrusel horizontal
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return _buildVideoCard(videos[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    bool isWatched = _watchedVideos.contains(video['videoId']);

    return GestureDetector(
      onTap: () => _openVideoPlayer(video['videoId']!),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isWatched ? Colors.grey[800] : Colors.grey[900],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                video['thumbnail']!,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                video['title']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Reproductor de Video')),
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                player,
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
