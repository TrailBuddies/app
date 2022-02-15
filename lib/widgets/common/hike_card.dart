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
      child: Card(
        child: SkeletonLoader(
          builder: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(
                    top: 10, left: 10, bottom: 10, right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Column(
                children: [
                  Container(
                      height: 20,
                      width: 130,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.white),
                  Container(
                    height: 15,
                    width: 200,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                  )
                ],
              ),
            ],
          ),
          items: 1,
          period: const Duration(seconds: 1),
          highlightColor: Colors.grey.shade400,
          direction: SkeletonDirection.ltr,
        ),
      ),
    );
  }
}
