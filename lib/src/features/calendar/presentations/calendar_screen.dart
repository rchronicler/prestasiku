import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// provider today
final todayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class CalendarScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(todayProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TableCalendar(
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) {
            return isSameDay(day, today);
          },
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: today,
          onDaySelected: (selectedDay, focusedDay) {
            ref.read(todayProvider.notifier).state = selectedDay;
          },
        ),
        const SizedBox(height: 20),
        Text("Lomba yang akan datang"),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Event $index'),
                subtitle: Text(DateFormat('dd MMMM yyyy').format(today)),
              );
            },
          ),
        ),
      ]),
    );
  }
}
