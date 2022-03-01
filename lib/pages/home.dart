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
    fetchHikes();
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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchHikes,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              backgroundColor: Colors.orange.shade900,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
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
                  if (loading && hikes.isEmpty && !hasFetchedHikes)
                    ...List.filled(5, 0).map((_) => const HikeCardSkeleton()),
                  if (hikes.isEmpty && error == null && !loading)
                    Center(
                        child: Column(
                      children: const [
                        Center(
                          child: Text(
                            'No Hikes',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Image(
                            image: AssetImage('assets/images/no-results.png'),
                            alignment: Alignment.center,
                            repeat: ImageRepeat.noRepeat,
                            height: 64,
                          ),
                        )
                      ],
                    )),
                  if (hikes.isNotEmpty)
                    ...hikes.map(
                      (hike) => HikeCard(
                        title: hike.title,
                        description: hike.description,
                        duration: hike.duration,
                        lat: hike.lat,
                        lng: hike.lng,
                        difficulty: hike.difficulty,
                        imageUrl: hike.imageUrl,
                        onTap: () => {},
                      ),
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
