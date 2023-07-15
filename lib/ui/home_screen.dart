import 'package:flutter/material.dart';
import 'package:podsonly/ui/home_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'What do you want to listen to today?',
                        style: TextStyle(
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
