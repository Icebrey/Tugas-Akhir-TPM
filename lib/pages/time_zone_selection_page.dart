import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TimeZoneSelectionPage extends StatelessWidget {
  final Function(TimeZone) onTimeZoneSelected;

  TimeZoneSelectionPage({required this.onTimeZoneSelected});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(); // Initialize date formatting for the current locale

    return Scaffold(
      appBar: AppBar(title: Text('Select Time Zone')),  
      body: ListView.builder(
        itemCount: timeZones.length,
        itemBuilder: (context, index) {
          final timeZone = timeZones[index];
          final currentTime = DateFormat('HH:mm:ss').format(
            DateTime.now().toUtc().add(timeZone.offset),
          );

          return ListTile(
            title: Text(timeZone.name),
            subtitle: Text(currentTime),
            onTap: () {
              onTimeZoneSelected(timeZone);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

class TimeZone {
  final String name;
  final Duration offset;

  TimeZone(this.name, this.offset);
}

// List of example time zones
List<TimeZone> timeZones = [
  TimeZone('WIB', Duration(hours: 7)),
  TimeZone('WITA', Duration(hours: 8)),
  TimeZone('WIT', Duration(hours: 9)),
  TimeZone('London', Duration(hours: 1)),
];
