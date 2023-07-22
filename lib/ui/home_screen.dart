import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podsonly/ui/home_category.dart';
import 'package:podsonly/ui/providers/hello_world_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloWorld = ref.watch(helloWorldProvider);
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'What do you want to listen to today?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        helloWorld,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    SizedBox(
                      height: 20,
                    ),
                    HomeCategory(title: 'Top Trending Podcasts', genre: ''),
                    SizedBox(
                      height: 20,
                    ),
                    HomeCategory(title: 'Tech Podcasts', genre: 'Technology'),
                    SizedBox(
                      height: 20,
                    ),
                    HomeCategory(title: 'Politics', genre: 'Politics'),
                    SizedBox(
                      height: 20,
                    ),
                    HomeCategory(title: 'Business', genre: 'Business'),
                    SizedBox(
                      height: 20,
                    ),
                    HomeCategory(
                        title: 'Relationships', genre: 'Relationships'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
