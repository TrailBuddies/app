import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:trail_buddies/hike_event.dart';
import 'package:trail_buddies/duration.dart';
import 'package:trail_buddies/widgets/common/custom_appbar.dart';

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

  Future<void> fetchHikeEvent() async {
    final hikeEvent = await HikeEvent.fetch(widget.id);
    await hikeEvent?.getUser();
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
      appBar: CustomAppBar(
        title: const Text('Hike'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchHikeEvent,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  if (loading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (hike == null)
                    const Center(
                      child: Text('No hike found'),
                    )
                  else
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/placeholder.png',
                                image: hike!.imageUrl,
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: FloatingActionButton(
                                child: const Icon(Icons.map_outlined),
                                backgroundColor: Colors.amber,
                                onPressed: () {
                                  MapsLauncher.launchCoordinates(
                                      hike!.lat, hike!.lng);
                                },
                                mini: true,
                              ),
                            )
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.all(16),
                            constraints: const BoxConstraints(minHeight: 150),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  hike!.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'by ',
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: hike!.user?.username ?? 'unknown',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 255, 60, 0),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(hike!.description),
                              ],
                            )),
                        Column(
                          children: [
                            ListTile(
                              title: const Text('Duration'),
                              subtitle: Text(
                                '${hike!.duration.map((d) => DateFormat.yMd().format(d)).join('...')} (${formatHikeDuration(hike!.duration)})',
                              ),
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
                            ListTile(
                              title: const Text('Start-point Latitude'),
                              subtitle: Text(hike!.lat.toString()),
                            ),
                            ListTile(
                              title: const Text('Start-point Longitude'),
                              subtitle: Text(hike!.lng.toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
