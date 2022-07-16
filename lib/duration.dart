String formatHikeDuration(List<DateTime> list) {
  final dur = list[1].difference(list[0]);

  final days = dur.inDays;
  final hours = dur.inHours.remainder(24);
  final mins = dur.inMinutes.remainder(60);

  final daysString = days == 0 ? '' : '$days day${days == 1 ? '' : 's'}';
  final hoursString = hours == 0 ? '' : '$hours hour${hours == 1 ? '' : 's'}';
  final minsString = mins == 0 ? '' : '$mins minute${mins == 1 ? '' : 's'}';

  return '$daysString $hoursString $minsString'.trim();
}
