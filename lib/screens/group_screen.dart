import 'dart:io';
import 'package:clipboard/clipboard.dart';
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


class ConversationScreen extends StatefulWidget {
  final Group group;

  const ConversationScreen({required this.group});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}


class _ConversationScreenState extends State<ConversationScreen> {
  final FocusNode _messageFocusNode = FocusNode();
  List<Message> messages = [];
  TextEditingController _messageController = TextEditingController();
  bool isRecording = false;
  File? selectedFile;
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    // Load initial messages (This is just an example, you can load messages from your own data source)
    messages = [
      Message(
        sender: 'John Doe',
        text: 'Hey, how\'s it going?',
        time: DateTime.now(),
      ),
      Message(
        sender: 'Jane Smith',
        text: 'I\'m good, thank you!',
        time: DateTime.now().add(Duration(minutes: 2)),
      ),
      // Add more initial messages as needed
    ];
  }


  void _sendMessage() {
    String text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        if (editingIndex != null) {
          // If we are editing a message, update the existing message
          messages[editingIndex!] = Message(
            sender: 'User',
            text: text,
            time: DateTime.now(),
          );
          editingIndex = null;
        } else {
          // Otherwise, add a new message
          messages.add(Message(
            sender: 'User',
            text: text,
            time: DateTime.now(),
          ));
        }
        _messageController.clear();
      });
    }
  }

  // Helper function to hide the keyboard when needed
  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }
  bool _isUserAdmin() {
    // TODO: Replace this with your own logic to determine if the user is an admin.
    // For now, we assume the user is an admin if their name is "Admin".
    return widget.group.groupName == "Admin";
  }

  bool _isUserMessage(Message message) {
    // Check if the message sender matches the user's name.
    // You can use your own authentication system or other means to determine this.
    return message.sender == "User";
  }

  bool _canEditMessage(Message message) {
    // The user can edit their own messages, and the admin can edit all messages.
    return _isUserMessage(message) || _isUserAdmin();
  }

  bool _canDeleteMessage(Message message) {
    // Only the user who sent the message and the admin can delete it.
    return _isUserMessage(message) || _isUserAdmin();
  }

  void _editMessage(Message message) {
    // The edit functionality should now be restricted to allowed users.
    if (_canEditMessage(message)) {
      // Implement the edit message functionality here.
      setState(() {
        _messageController.text = message.text;
        editingIndex = messages.indexOf(message);
      });
    }
  }

  void _deleteMessage(Message message) {
    // The delete functionality should now be restricted to allowed users.
    if (_canDeleteMessage(message)) {
      // Implement the delete message functionality here.
      setState(() {
        messages.remove(message);
      });
    }
  }

  void _viewMessageInfo(Message message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sender: ${message.sender}'),
              SizedBox(height: 4),
              Text('Time: ${DateFormat.yMd().add_jm().format(message.time)}'),
            ],
          ),
        );
      },
    );
  }

  void _copyMessage(Message message) {
    FlutterClipboard.copy(message.text)
        .then((value) => print('Copied to clipboard: ${message.text}'));
    // Show a snackbar or toast message indicating the message has been copied
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _replyToMessage(Message message) {
    // Set up the reply message UI
    setState(() {
      _messageController.text = ''; // Clear the text
      editingIndex = null;
      _messageController.text = ''; // Clear the text
      isRecording = false; // Close voice recording if open
      _messageController.text = 'Replied to ${message.sender}: ${message.text}\n';
      _messageFocusNode.requestFocus(); // Place the cursor at the end
      _messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: _messageController.text.length),
      ); // Place the cursor at the end
    });
  }

  void _toggleStarMessage(Message message) {
    setState(() {
      message.isStarred = !message.isStarred;
    });
  }

  void _forwardMessage(Message message) {
    // Set up the forward message UI
    setState(() {
      _messageController.text = ''; // Clear the text
      editingIndex = null;
      _messageController.text = ''; // Clear the text
      isRecording = false; // Close voice recording if open
      _messageController.text = 'Forwarded message:\n${message.text}\n';
      _messageFocusNode.requestFocus(); // Place the cursor at the end
      _messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: _messageController.text.length),
      ); // Place the cursor at the end
    });
  }

  void _showMessageOptions(Message message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_canEditMessage(message))
                ListTile(
                  leading: Icon(Icons.edit, color: Colors.indigo,),
                  title: Text('Edit Message'),
                  onTap: () {
                    Navigator.pop(context); // Close the pop-up
                    _editMessage(message);
                  },
                ),
              if (_canDeleteMessage(message))
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red,),
                  title: Text('Delete Message'),
                  onTap: () {
                    Navigator.pop(context); // Close the pop-up
                    _deleteMessage(message);
                  },
                ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.indigo,),
                title: Text('View Message Info'),
                onTap: () {
                  Navigator.pop(context); // Close the pop-up
                  _viewMessageInfo(message);
                },
              ),
              ListTile(
                leading: Icon(Icons.copy, color: Colors.indigo,),
                title: Text('Copy Message'),
                onTap: () {
                  Navigator.pop(context); // Close the pop-up
                  _copyMessage(message);
                },
              ),
              ListTile(
                leading: Icon(
                  message.isStarred ? Icons.star : Icons.star_border,
                  color: message.isStarred ? Colors.amber : Colors.indigo,
                ),
                title: Text(message.isStarred ? 'Unstar Message' : 'Star Message'),
                onTap: () {
                  Navigator.pop(context); // Close the pop-up
                  _toggleStarMessage(message);
                },
              ),
              ListTile(
                leading: Icon(Icons.reply, color: Colors.indigo,),
                title: Text('Reply to Message'),
                onTap: () {
                  Navigator.pop(context); // Close the pop-up
                  _replyToMessage(message);
                },
              ),
              ListTile(
                leading: Icon(Icons.forward, color: Colors.indigo,),
                title: Text('Forward Message'),
                onTap: () {
                  Navigator.pop(context); // Close the pop-up
                  _forwardMessage(message);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _initiateGroupCall() {
    // TODO: Implement the group call functionality here
    // This is just a placeholder, and you should replace it with your actual implementation
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Group Call'),
          content: Text('Initiating a group call...'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
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
        title: Text(widget.group.groupName),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: _initiateGroupCall,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (_messageFocusNode.hasFocus) {
            _hideKeyboard();
          }
        },
        child: Column(
          children: [
            Expanded( // Wrap the ListView.builder with Expanded to avoid RenderFlex overflow
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Message message = messages[index];
                  bool isUserMessage = _isUserMessage(message);
                  return GestureDetector(
                    onTap: () => _showMessageOptions(message),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  message.sender,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  DateFormat.jm().format(message.time),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            if (message.isReply && message.repliedMessage != null)
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Replied to ${message.repliedMessage!.sender}:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      message.repliedMessage!.text,
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: 4.0),
                            Text(message.text),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.grey[200],
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {
                      // TODO: Implement file attachment functionality
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _messageFocusNode,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final DateTime time;
  bool isStarred;
  bool isReply;
  Message? repliedMessage;

  Message({
    required this.sender,
    required this.text,
    required this.time,
    this.isStarred = false,
    this.isReply = false,
    this.repliedMessage,
  });
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
