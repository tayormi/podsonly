import 'package:podcast_search/podcast_search.dart';

class PodcastService {
  Future<SearchResult> fetchPodcast({String genre = ''}) async {
    final search = Search();
    final results =
        await search.charts(country: Country.nigeria, limit: 10, genre: genre);
    return results;
  }
}
