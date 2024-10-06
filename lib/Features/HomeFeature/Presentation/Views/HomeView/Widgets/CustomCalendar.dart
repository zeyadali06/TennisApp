import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key, required this.onDaySelected});

  final void Function(DateTime dateTime) onDaySelected;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  Map<int, String> weekdays = {1: 'Mon', 2: 'Tus', 3: 'Wed', 4: 'Thu', 5: 'Fri', 6: 'Sat', 7: 'Sun'};

  @override
  void initState() {
    _focusedDay = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TableCalendar(
        rowHeight: 60,
        headerVisible: false,
        focusedDay: _focusedDay,
        daysOfWeekVisible: false,
        firstDay: DateTime(2000, 1, 1),
        lastDay: DateTime(9999, 12, 31),
        calendarFormat: CalendarFormat.week,
        availableGestures: AvailableGestures.none,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        selectedDayPredicate: (day) {
          return isSameDay(_focusedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            widget.onDaySelected.call(_selectedDay!);
            setState(() {});
          }
        },
        calendarBuilders: CalendarBuilders(
          todayBuilder: todayBuilder,
          outsideBuilder: defaultBuilder,
          defaultBuilder: defaultBuilder,
          selectedBuilder: selectedBuilder,
        ),
      ),
    );
  }

  Widget? todayBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          children: [
            const Expanded(flex: 2, child: SizedBox(height: 5)),
            FittedWidget(
              child: Text(
                weekdays[day.weekday].toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 8),
              ),
            ),
            const Expanded(flex: 2, child: SizedBox(height: 5)),
            FittedWidget(
              child: Text(
                day.day.toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const Expanded(flex: 2, child: SizedBox(height: 5)),
          ],
        ),
      ),
    );
  }

  Widget? defaultBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    return Center(
      child: Column(
        children: [
          const Expanded(flex: 2, child: SizedBox(height: 5)),
          FittedWidget(
            child: Text(
              weekdays[day.weekday].toString(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 8),
            ),
          ),
          const Expanded(child: SizedBox(height: 5)),
          FittedWidget(
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox(height: 5)),
        ],
      ),
    );
  }

  Widget? selectedBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          children: [
            const Expanded(flex: 2, child: SizedBox(height: 5)),
            FittedWidget(
              child: Text(
                weekdays[day.weekday].toString(),
                style: const TextStyle(color: Color(0xff014aa8), fontSize: 8),
              ),
            ),
            const Expanded(child: SizedBox(height: 5)),
            FittedWidget(
              child: Text(
                day.day.toString(),
                style: const TextStyle(color: Color(0xff014aa8), fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const Expanded(flex: 2, child: SizedBox(height: 5)),
          ],
        ),
      ),
    );
  }
}
