import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:rich_readmore/rich_readmore.dart';

class PodcastDetailsBody extends StatefulWidget {
  const PodcastDetailsBody({
    super.key,
    required this.podcast,
    required this.item,
  });

  final Podcast podcast;
  final Item item;

  @override
  State<PodcastDetailsBody> createState() => _PodcastDetailsBodyState();
}

class _PodcastDetailsBodyState extends State<PodcastDetailsBody> {
  late AudioPlayer _player;
  int currentEpisodeIndex = -1;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(children: [
            Image.network(
              widget.podcast.image ?? '',
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              },
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.trackName ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.item.artistName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          RichReadMoreText.fromString(
            text: widget.podcast.description ?? '',
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            settings: LengthModeSettings(
              trimLength: 200,
              trimCollapsedText: 'Read more',
              trimExpandedText: ' Read less ',
              lessStyle: const TextStyle(color: Colors.orangeAccent),
              moreStyle: const TextStyle(color: Colors.orangeAccent),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Text(
                'All Episodes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.podcast.episodes.length,
              itemBuilder: (BuildContext context, int index) {
                final episode = widget.podcast.episodes[index];
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.network(
                        episode.imageUrl ??
                            widget.podcast.image ??
                            'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      ),
                      title: Text(
                        episode.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        episode.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          if (episode.contentUrl == null) return;
                          setState(() {
                            currentEpisodeIndex = index;
                          });
                          if (currentEpisodeIndex == index && _player.playing) {
                            _player.pause();
                            currentEpisodeIndex = -1;
                            return;
                          }
                          _player.setUrl(episode.contentUrl!);
                          _player.play();
                        },
                        icon: currentEpisodeIndex == index
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(
                              episode.publicationDate ?? DateTime.now()),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
