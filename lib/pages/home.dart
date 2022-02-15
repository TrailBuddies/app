import 'package:flutter/material.dart';
import 'package:trail_buddies/hike_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<HikeEvent> hikes = [];
  bool loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
  }

  Future<void> refreshHikes() async {
    setState(() {
      loading = true;
      error = null;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    HikeEvent.all().then((hikes) {
      this.hikes.addAll(hikes);
      setState(() {
        loading = false;
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
        onRefresh: refreshHikes,
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
                  if (loading) const Center(child: Text('Loading...')),
                  if (hikes.isEmpty && error == null && !loading)
                    const Center(child: Text('No hikes found')),
                  if (hikes.isNotEmpty) ...hikes.map((hike) => Card()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
