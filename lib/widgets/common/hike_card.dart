import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HikeCard extends StatefulWidget {
  final String title;
  final String description;
  final List<DateTime> duration;
  final double lat;
  final double lng;
  final int difficulty;
  final void Function() onTap;

  const HikeCard({
    Key? key,
    required this.title,
    required this.description,
    required this.duration,
    required this.lat,
    required this.lng,
    required this.difficulty,
    required this.onTap,
  }) : super(key: key);

  @override
  _HikeCardState createState() => _HikeCardState();
}

class _HikeCardState extends State<HikeCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(widget.title),
              subtitle: Text(widget.description),
            ),
          ],
        ),
      ),
    );
  }
}

class HikeCardSkeleton extends StatelessWidget {
  const HikeCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SkeletonLoader(
        builder: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        items: 10,
        period: const Duration(seconds: 1),
        highlightColor: Colors.grey.shade300,
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
