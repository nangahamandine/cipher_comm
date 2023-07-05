import 'package:flutter/material.dart';
import '../models/meeting_model.dart';

class MeetingItem extends StatelessWidget {
  final MeetingModel meeting;

  const MeetingItem({required this.meeting});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.event),
      title: Text(meeting.title),
      subtitle: Text(meeting.description),
      trailing: Text(meeting.startTime.toString()), // Display the start time
      onTap: () {
        // Handle meeting item tap
        // Navigate to meeting details screen or perform any other action
      },
    );
  }
}
