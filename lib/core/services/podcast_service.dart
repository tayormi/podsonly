import 'package:podcast_search/podcast_search.dart';

class PodcastService {
  Future<SearchResult> fetchPodcast() async {
    final search = Search();
    final results = await search.charts(country: Country.nigeria, limit: 10);
    return results;
  }
}
