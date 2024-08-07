import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sight_companion/cores/cores.dart';

class LiveCoursesView extends StatelessWidget {
  static const String routeName = '/live-courses';

  const LiveCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Live Courses',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.subscriptions),
                      SizedBox(width: 8),
                      Icon(Icons.notifications),
                      SizedBox(width: 8),
                      Icon(Icons.cast),
                      SizedBox(width: 8),
                      Icon(Icons.settings),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildMenuCard(
                      onTap: () {
                        // Navigate to the respective page
                      },
                      icon: Icons.book,
                      text: 'Webinars',
                      color1: Colors.blue.withOpacity(0.5),
                      color2: Colors.pink.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildMenuCard(
                      onTap: () {
                        // Navigate to the respective page
                      },
                      icon: Icons.newspaper,
                      text: 'Articles',
                      color1: Colors.pink.withOpacity(0.5),
                      color2: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildMenuCard(
                      onTap: () {
                        // Navigate to the respective page
                      },
                      icon: Icons.trending_up,
                      text: 'Trending',
                      color1: Colors.blue.withOpacity(0.5),
                      color2: Colors.pink.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildMenuCard(
                      onTap: () {
                        // Navigate to the respective page
                      },
                      icon: Icons.camera_alt,
                      text: 'Live Session',
                      color1: Colors.pink.withOpacity(0.5),
                      color2: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildYoutubeVideo(
                YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(
                          'https://youtu.be/39OOCVxXpAI?feature=shared') ??
                      '',
                  flags: YoutubePlayerFlags(autoPlay: true),
                ),
              ),
              SizedBox(height: 10),
              _buildYoutubeVideo(
                YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(
                          'https://youtu.be/4v3uIJd3E8E?feature=shared') ??
                      '',
                  flags: YoutubePlayerFlags(autoPlay: true),
                ),
              ),
              SizedBox(height: 10),
              _buildYoutubeVideo(
                YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(
                          'https://youtu.be/gUWWt30oZ3w?feature=shared') ??
                      '',
                  flags: YoutubePlayerFlags(autoPlay: true),
                ),
              ),
              SizedBox(height: 10),
              _buildYoutubeVideo(
                YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(
                          'https://youtu.be/mIkVNWRcf1E?feature=shared') ??
                      '',
                  flags: YoutubePlayerFlags(autoPlay: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
    required Color color1,
    required Color color2,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYoutubeVideo(YoutubePlayerController controller) {
    return Column(
      children: [
        YoutubePlayer(
          controller: controller,
          liveUIColor: Colors.amber,
          showVideoProgressIndicator: true,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
