import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:trail_buddies/hike_event.dart';

class HikePage extends StatefulWidget {
  final String id;

  const HikePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _HikePageState createState() => _HikePageState();
}

class _HikePageState extends State<HikePage> {
  HikeEvent? hike;
  bool loading = true;

  void fetchHikeEvent() async {
    final hikeEvent = await HikeEvent.fetch(widget.id);
    setState(() {
      hike = hikeEvent;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mounted && hike == null) {
      fetchHikeEvent();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hike'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : hike == null
              ? const Center(
                  child: Text('No hike found'),
                )
              : Column(
                  children: [
                    Image.network(
                      hike!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text(hike!.title),
                            subtitle: Text(hike!.description),
                          ),
                          ListTile(
                            title: const Text('Duration'),
                            subtitle: Text(
                              hike!.duration
                                  .map((d) => DateFormat.yMd().format(d))
                                  .join('...'),
                            ),
                          ),
                          ListTile(
                            title: const Text('Latitude'),
                            subtitle: Text(hike!.lat.toString()),
                          ),
                          ListTile(
                            title: const Text('Longitude'),
                            subtitle: Text(hike!.lng.toString()),
                          ),
                          ListTile(
                            title: const Text('Difficulty'),
                            subtitle: Text(hike!.difficulty.toString()),
                          ),
                          ListTile(
                            title: const Text('Created at'),
                            subtitle: Text(hike!.createdAt.toString()),
                          ),
                          ListTile(
                            title: const Text('Updated at'),
                            subtitle: Text(hike!.updatedAt.toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}