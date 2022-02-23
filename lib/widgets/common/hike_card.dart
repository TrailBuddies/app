import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HikeCard extends StatefulWidget {
  final String title;
  final String description;
  final List<DateTime> duration;
  final double lat;
  final double lng;
  final int difficulty;
  final String? imageUrl;
  final void Function() onTap;

  const HikeCard({
    Key? key,
    required this.title,
    required this.description,
    required this.duration,
    required this.lat,
    required this.lng,
    required this.difficulty,
    required this.imageUrl,
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
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.imageUrl == null
                  ? const Image(
                      image: AssetImage('assets/images/placeholder.png'),
                    )
                  : Image(
                      image: NetworkImage(widget.imageUrl as String),
                    ),
              ListTile(
                title: Text(widget.title),
                subtitle: Text(widget.description),
              ),
            ],
          ),
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
          builder: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          items: 1,
          period: const Duration(seconds: 2),
          highlightColor: Colors.grey.shade400,
          direction: SkeletonDirection.ltr,
        ),
      ),
    );
  }
}
