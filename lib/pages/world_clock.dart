import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'time_zone_selection_page.dart';

class WorldClockHomePage extends StatefulWidget {
  @override
  _WorldClockHomePageState createState() => _WorldClockHomePageState();
}

class _WorldClockHomePageState extends State<WorldClockHomePage> {
  String _currentTime = '';
  TimeZone? selectedTimeZone;

  @override
  void initState() {
    super.initState();
    // Start the clock update loop
    _updateTime();
  }

  @override
  void dispose() {
    // Stop the clock update loop
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      if (selectedTimeZone != null) {
        _currentTime = DateFormat('HH:mm:ss').format(
          DateTime.now().toUtc().add(selectedTimeZone!.offset),
        );
      } else {
        _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
      }
    });

  Future.delayed(Duration(seconds: 1), _updateTime);
}

void _openTimeZoneSelection() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return TimeZoneSelectionPage(
        onTimeZoneSelected: (timeZone) {
          setState(() {
            selectedTimeZone = timeZone;
          });
        },
      );
    }),
  );
}

void onTimeZoneSelected(TimeZone timeZone) {
  setState(() {
    selectedTimeZone = timeZone;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('World Clock'),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: _openTimeZoneSelection,
            child: Text(
              'Change Time Zone',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        ),
      body: Center(
        child: Text(
          _currentTime,
          style: TextStyle(fontSize: 48.0),
        ),
      ),
    );
  }
}
