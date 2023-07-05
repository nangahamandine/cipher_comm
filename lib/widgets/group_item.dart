import 'package:flutter/material.dart';
import '../models/group_model.dart';

class GroupItem extends StatelessWidget {
  final GroupModel group;

  const GroupItem({required this.group});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(group.groupImage),
      ),
      title: Text(group.groupName),
      subtitle: Text('${group.membersCount} members'),
      onTap: () {
        // Handle group item tap
        // Navigate to group chat screen or perform any other action
      },
    );
  }
}
