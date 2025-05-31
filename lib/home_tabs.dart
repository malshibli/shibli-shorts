import 'package:flutter/material.dart';
import 'video_feed.dart';
import 'upload.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shibli Shorts"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.play_circle_fill), text: "Feed"),
              Tab(icon: Icon(Icons.upload), text: "Upload"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ShortsFeedTab(),
            UploadShort(),
          ],
        ),
      ),
    );
  }
}

class ShortsFeedTab extends StatelessWidget {
  const ShortsFeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: buildFeed());
  }
}
