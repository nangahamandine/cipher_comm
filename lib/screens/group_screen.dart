import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum ReadStatus { notReceived, received, read }

class Group {
  final String groupName;
  final String groupPhoto;
  final String lastMessage;
  final String lastMessageTime;
  final int messageCount;
  final bool isTyping;
  final ReadStatus readStatus;

  Group({
    required this.groupName,
    required this.groupPhoto,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.messageCount,
    required this.isTyping,
    required this.readStatus,
  });
}

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<Group> groups = [
    Group(
      groupName: 'Work Group 1',
      groupPhoto: 'assets/images/group1.jpg',
      lastMessage: 'Meeting today at 3 PM',
      lastMessageTime: '10:30 AM',
      messageCount: 3,
      isTyping: false,
      readStatus: ReadStatus.notReceived,
    ),
    Group(
      groupName: 'Work Group 2',
      groupPhoto: 'assets/images/group2.jpg',
      lastMessage: 'Don\'t forget to submit your reports',
      lastMessageTime: 'Yesterday',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
    Group(
      groupName: 'Work Group 3',
      groupPhoto: 'assets/images/group3.jpg',
      lastMessage: 'Reminder: Team lunch tomorrow',
      lastMessageTime: '2:15 PM',
      messageCount: 2,
      isTyping: false,
      readStatus: ReadStatus.received,
    ),
    Group(
      groupName: 'Work Group 4',
      groupPhoto: 'assets/images/group4.jpg',
      lastMessage: 'Project deadline extended',
      lastMessageTime: '5:45 PM',
      messageCount: 0,
      isTyping: true,
      readStatus: ReadStatus.notReceived,
    ),
    Group(
      groupName: 'Work Group 5',
      groupPhoto: 'assets/images/group5.jpg',
      lastMessage: 'New feature proposal',
      lastMessageTime: 'Yesterday',
      messageCount: 1,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
    Group(
      groupName: 'Work Group 6',
      groupPhoto: 'assets/images/group6.jpg',
      lastMessage: 'Good morning, team!',
      lastMessageTime: 'Today',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.received,
    ),
    Group(
      groupName: 'Work Group 7',
      groupPhoto: 'assets/images/group7.jpg',
      lastMessage: 'Meeting minutes attached',
      lastMessageTime: 'Yesterday',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.received,
    ),
    Group(
      groupName: 'Work Group 8',
      groupPhoto: 'assets/images/group8.jpg',
      lastMessage: 'Discussion on upcoming project',
      lastMessageTime: '10:30 AM',
      messageCount: 4,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
    Group(
      groupName: 'Work Group 9',
      groupPhoto: 'assets/images/group9.jpg',
      lastMessage: 'New team member introduction',
      lastMessageTime: 'Yesterday',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.notReceived,
    ),
    Group(
      groupName: 'Work Group 10',
      groupPhoto: 'assets/images/group10.jpg',
      lastMessage: 'Reminder: Client meeting at 2 PM',
      lastMessageTime: '9:45 AM',
      messageCount: 1,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
  ];

  List<Group> filteredGroups = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredGroups = groups;
    searchController.addListener(filterGroups);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterGroups() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredGroups = groups;
      });
    } else {
      setState(() {
        filteredGroups = groups
            .where((group) =>
        group.groupName.toLowerCase().contains(query) ||
            group.lastMessage.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  void openConversation(Group group) {
    if (filteredGroups.contains(group)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(group: group),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Group Not Found'),
          content: Text('The group you are searching for is not available.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  void createNewGroup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Group'),
          content: Text('Do you want to create a new group?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () {
                // Implement create group functionality
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Chats',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: createNewGroup, // Updated onPressed callback
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Implement more options functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredGroups.length,
              itemBuilder: (context, index) {
                Group group = filteredGroups[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(group.groupPhoto),
                  ),
                  title: Text(group.groupName),
                  subtitle: Row(
                    children: [
                      Icon(
                        group.isTyping ? Icons.mode_edit : Icons.done_all,
                        size: 16,
                        color: Colors.indigo,
                      ),
                      SizedBox(width: 5),
                      Text(
                        group.lastMessage,
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        group.lastMessageTime,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      if (group.messageCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${group.messageCount}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    openConversation(group);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationScreen extends StatelessWidget {
  final Group group;

  const ConversationScreen({required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.groupName),
      ),
      body: Center(
        child: Text('Conversation Screen'),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Chats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GroupScreen(),
    );
  }
}
