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
  HikeEvent? _hikeEvent;
  bool loading = true;

  void fetchHikeEvent() async {
    final hikeEvent = await HikeEvent.fetch(widget.id);
    print(hikeEvent);
    setState(() {
      _hikeEvent = hikeEvent;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    {if}
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hike'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _hikeEvent == null
              ? const Center(
                  child: Text('No hike found'),
                )
              : Column(
                  children: [
                    Text(_hikeEvent!.title),
                    Text(_hikeEvent!.description),
                    Text('${_hikeEvent!.lat}, ${_hikeEvent!.lng}'),
                  ],
                ),
    );
  }
}
