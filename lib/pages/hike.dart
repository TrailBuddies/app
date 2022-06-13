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
              : Center(
                  child: Column(
                    children: [
                      Text(hike!.title),
                      Text(hike!.description),
                      Text('${hike!.lat}, ${hike!.lng}'),
                    ],
                  ),
                ),
    );
  }
}
