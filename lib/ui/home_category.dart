import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:podsonly/core/services/podcast_service.dart';
import 'package:podsonly/ui/temp_api_ui.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({super.key, required this.title, this.genre = ''});

  final String title;
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TempAPIUI()));
              },
              child: const Text('See All'),
            ),
          ],
        ),
        FutureBuilder<SearchResult>(
          future: PodcastService().fetchPodcast(genre: genre),
          builder:
              (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.resultCount ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final items = snapshot.data?.items;
                    final item = items?[index];
                    return Image.network(
                      item?.artworkUrl600 ?? '',
                      fit: BoxFit.cover,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Opps! Something went wrong'));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
