import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:podsonly/core/services/podcast_service.dart';
import 'package:podsonly/ui/providers/hello_world_provider.dart';
import 'package:podsonly/ui/widgets/podcast_details_body.dart';

class PodcastDetails extends ConsumerWidget {
  const PodcastDetails({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastService = ref.read(podcastServiceProvider);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(helloWorldProvider.notifier).state =
                'You liked ${item.trackName}';
          },
          child: const Icon(Icons.favorite),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            item.trackName ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder<Podcast>(
          future: podcastService.getPodcastDetails(item.feedUrl ?? ''),
          builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
            if (snapshot.hasData) {
              final podcast = snapshot.data;
              if (podcast == null) {
                return const Center(
                    child: Text('This podcast is not available.'));
              }
              return PodcastDetailsBody(podcast: podcast, item: item);
            }
            if (snapshot.hasError) {
              return const Center(
                  child: Text('An error occurred. Please try again later.'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
