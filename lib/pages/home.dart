import 'package:flutter/material.dart';
import 'package:trail_buddies/hike_event.dart';
import 'package:trail_buddies/widgets/common/hike_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<HikeEvent> hikes = [];
  bool hasFetchedHikes = false;
  bool loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
  }

  Future<void> fetchHikes() async {
    setState(() {
      loading = true;
      error = null;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    HikeEvent.all().then((hikes) {
      if (hasFetchedHikes) {
        hikes.removeWhere(
            (newHike) => this.hikes.any((hike) => hike.id == newHike.id));
      }

      setState(() {
        this.hikes.addAll(hikes);
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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchHikes,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text('Trail Buddies'),
                ),
                centerTitle: true,
                background: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 10),
                  if (error != null) Center(child: Text(error!)),
                  if (loading)
                    ...List.filled(5, null)
                        .map((e) => const HikeCardSkeleton()),
                  if (hikes.isEmpty && error == null && !loading)
                    const Center(child: Text('No hikes found')),
                  if (hikes.isNotEmpty)
                    ...hikes.map(
                      (hike) => HikeCard(
                          title: hike.title,
                          description: hike.description,
                          duration: hike.duration,
                          lat: hike.lat,
                          lng: hike.lng,
                          difficulty: hike.difficulty,
                          onTap: () => {}),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
