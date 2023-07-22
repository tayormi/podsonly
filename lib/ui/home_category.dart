import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:podsonly/ui/podcast_details.dart';
import 'package:podsonly/ui/providers/podcast_provider.dart';
import 'package:podsonly/ui/temp_api_ui.dart';

class HomeCategory extends ConsumerWidget {
  const HomeCategory({super.key, required this.title, this.genre = ''});

  final String title;
  final String genre;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastItems = ref.watch(podcastCategoryItemProvider(genre));
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
        podcastItems.when(data: (SearchResult data) {
          return SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.resultCount,
              itemBuilder: (BuildContext context, int index) {
                final items = data.items;
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PodcastDetails(
                          item: item,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    item.artworkUrl600 ?? '',
                    fit: BoxFit.cover,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 10,
                );
              },
            ),
          );
        }, error: (Object error, StackTrace stackTrace) {
          return const Center(child: Text('Opps! Something went wrong'));
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        })
      ],
    );
  }
}
