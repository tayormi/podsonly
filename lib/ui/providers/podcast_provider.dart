import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podsonly/core/services/podcast_service.dart';

final podcastCategoryItemProvider = FutureProvider.family((ref, String genre) {
  final podcastService = ref.read(podcastServiceProvider);
  return podcastService.fetchPodcast(genre: genre);
});
