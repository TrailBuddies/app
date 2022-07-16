String formatHikeDuration(List<DateTime> list) {
  final dur = list[1].difference(list[0]);

  final days = dur.inDays;
  final hours = dur.inHours.remainder(24);
  final mins = dur.inMinutes.remainder(60);

  final days_string = days == 0 ? '' : '$days day${days == 1 ? '' : 's'}';
  final hours_string = hours == 0 ? '' : '$hours hour${hours == 1 ? '' : 's'}';
  final mins_string = mins == 0 ? '' : '$mins minute${mins == 1 ? '' : 's'}';

  return '$days_string $hours_string $mins_string'.trim();
}
