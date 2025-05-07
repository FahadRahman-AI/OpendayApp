import 'package:flutter/material.dart';
import 'about_us.dart';
import 'contact_us.dart';
import 'intro_screen.dart';
import 'pages_layout.dart';

// Schedule Data and Classes
class ScheduleItem {
  final String  subject, time, room, professor;
  final Color color;

  ScheduleItem({

    required this.subject,
    required this.time,
    required this.room,
    required this.professor,
    required this.color,
  });
}

class ScheduleCard extends StatelessWidget {
  final ScheduleItem item;

  const ScheduleCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.color,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.subject,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(item.time),
            Text(item.room),
            Text(item.professor),
          ],
        ),
      ),
    );
  }
}

class SubjectColor extends StatelessWidget {
  final String subject;
  final Color color;

  const SubjectColor(this.subject, this.color);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      label: Text(subject),
    );
  }
}

// Main Page
class WhatToDo extends StatelessWidget {
  final List<ScheduleItem> schedule = [
    ScheduleItem(
      subject: "Computer Science Intro",
      time: "09:00 - 10:30",
      room: "Room MX-101",
      professor: "Alix Bergeret",
      color: Colors.green.shade100,
    ),

    ScheduleItem(
      subject: "Video Game Design Demonstration",
      time: "15:30 - 17:00",
      room: "Room MX-220",
      professor: "Dr. Paul Hampton",
      color: Colors.pink.shade100,
    ),
    ScheduleItem(
      subject: "Library and Lecture Hall Tours",
      time: "13:00 - 14:30",
      room: "Harrison Library",
      professor: "J. Avery",
      color: Colors.lightBlue.shade100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final timeSlots = ["9am-11am", "12pm-2pm", "3pm-5pm"];

    return BaseScaffold(
      title: 'What To Do',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Text(
              'Things to Do Around Campus',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Your OpenDay Schedule',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            // Display the schedule for each time slot
            Expanded(
              child: ListView(
                children: timeSlots.map((timeSlot) {
                  final timeSlotSchedule = schedule
                      .where((s) {
                    if (timeSlot == "9am-11am") {
                      return s.time.startsWith("09") || s.time.startsWith("10");
                    } else if (timeSlot == "12pm-2pm") {
                      return s.time.startsWith("12") || s.time.startsWith("13");
                    } else if (timeSlot == "3pm-5pm") {
                      return s.time.startsWith("15");
                    }
                    return false;
                  })
                      .toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(timeSlot,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      ...timeSlotSchedule.map((item) => ScheduleCard(item: item)),
                      SizedBox(height: 12),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Divider for the color guide
            Divider(),
            Text("Subject Color Guide",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: [
                SubjectColor("Tours", Colors.lightBlue.shade100),
                SubjectColor("Talks", Colors.green.shade100),
                SubjectColor("Activities", Colors.purple.shade100),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Custom widget for activity cards
class ActivityCard extends StatelessWidget {
  final String title;
  final String description;

  ActivityCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
