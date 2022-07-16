String formatHikeDuration(List<DateTime> list) {
  final dur = list[1].difference(list[0]);

  final days = dur.inDays;
  final hours = dur.inHours.remainder(24);
  final mins = dur.inMinutes.remainder(60);

<<<<<<< HEAD
  final daysString = days == 0 ? '' : '$days day${days == 1 ? '' : 's'}';
  final hoursString = hours == 0 ? '' : '$hours hour${hours == 1 ? '' : 's'}';
  final minsString = mins == 0 ? '' : '$mins minute${mins == 1 ? '' : 's'}';

  return '$daysString $hoursString $minsString'.trim();
=======
  final days_string = days == 0 ? '' : '$days day${days == 1 ? '' : 's'}';
  final hours_string = hours == 0 ? '' : '$hours hour${hours == 1 ? '' : 's'}';
  final mins_string = mins == 0 ? '' : '$mins minute${mins == 1 ? '' : 's'}';

  return '$days_string $hours_string $mins_string'.trim();
>>>>>>> 536c2b6 (format hike.duration into human readable (i.e. 2 days 4 hours))
}
