import 'package:flutter/material.dart';

import 'package:trail_buddies/hike_event.dart';
import 'package:trail_buddies/widgets/common/hike_card.dart';
// TEMP
import '../global_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<HikeEvent> hikes = [];
  bool hasFetchedHikes = false;
  bool loading = false;
  int index = 0;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchHikes();
  }

  Future<void> fetchHikes() async {
    setState(() {
      loading = true;
      error = null;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    HikeEvent.all().then((hikes) {
      // if (hasFetchedHikes) {
      //   hikes.removeWhere(
      //       (newHike) => this.hikes.any((hike) => hike.id == newHike.id));
      // }

      setState(() {
        this.hikes = hikes;
        this.hikes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        loading = false;
        hasFetchedHikes = true;
      });
    }).catchError((e) {
      setState(() {
        loading = false;
        error = e.toString();
      });
      FlutterError.presentError(FlutterErrorDetails(
        exception: e,
        context: ErrorDescription(
          'Failed to fetch all hikes in _HomePage.initState()',
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      child: RefreshIndicator(
        onRefresh: fetchHikes,
        child: Column(
          children: [
            if (hikes.isNotEmpty)
              ...hikes.map(
                (h) => HikeCard(
                  title: h.title,
                  description: h.description,
                  duration: h.duration,
                  lat: h.lat,
                  lng: h.lng,
                  difficulty: h.difficulty,
                  imageUrl: h.imageUrl,
                  onTap: () {
                    Navigator.pushNamed(context, '/hike/${h.id}');
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
