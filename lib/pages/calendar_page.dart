import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/theme_provider.dart';
import 'app_drawer.dart';
import 'schedule_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text('Calendar', style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(selectedDate: selectedDay),
                  ),
                );
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: isDark ? Colors.blue[700] : Colors.blue[400],
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: isDark ? Colors.blue[800] : Colors.blue,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(
                  color: isDark ? Colors.red[300] : Colors.red,
                ),
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: isDark ? Colors.white : Colors.black,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.poppins(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                weekendStyle: GoogleFonts.poppins(
                  color: isDark ? Colors.red[300] : Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SchedulePage(selectedDate: _selectedDay),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}