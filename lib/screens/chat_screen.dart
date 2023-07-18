import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Chat> chats =  [
    Chat(
      contactName: 'Friend 1',
      profilePhoto: 'assets/images/profile1.jpg',
      lastMessage: 'Hey, how are you?',
      lastMessageTime: '10:30 AM',
      messageCount: 3,
      isTyping: false,
      readStatus: ReadStatus.notReceived,

    ),
    Chat(
      contactName: 'Friend 2',
      profilePhoto: 'assets/images/profile2.jpg',
      lastMessage: 'See you later!',
      lastMessageTime: 'Yesterday',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
    // Add more chat entries as needed
    // Add more chat entries as needed
    Chat(
      contactName: 'Friend 3',
      profilePhoto: 'assets/images/profile3.jpg',
      lastMessage: 'How was your day?',
      lastMessageTime: '2:15 PM',
      messageCount: 2,
      isTyping: false,
      readStatus: ReadStatus.received,
    ),
    Chat(
      contactName: 'Friend 4',
      profilePhoto: 'assets/images/profile4.jpg',
      lastMessage: 'Are you free tomorrow?',
      lastMessageTime: '5:45 PM',
      messageCount: 0,
      isTyping: true,
      readStatus: ReadStatus.notReceived,
    ),
    Chat(
      contactName: 'Friend 5',
      profilePhoto: 'assets/images/profile5.jpg',
      lastMessage: 'Let\'s meet up for coffee.',
      lastMessageTime: 'Yesterday',
      messageCount: 1,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
    Chat(
      contactName: 'Friend 6',
      profilePhoto: 'assets/images/profile6.jpg',
      lastMessage: 'Good morning!',
      lastMessageTime: 'Today',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.received,
    ),
    Chat(
      contactName: 'Friend 7',
      profilePhoto: 'assets/images/profile7.jpg',
      lastMessage: 'See you later!',
      lastMessageTime: 'Yesterday',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.received,
    ),
    Chat(
      contactName: 'Friend 8',
      profilePhoto: 'assets/images/profile8.jpg',
      lastMessage: 'Hey, how\'s it going?',
      lastMessageTime: '10:30 AM',
      messageCount: 4,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
    Chat(
      contactName: 'Friend 9',
      profilePhoto: 'assets/images/profile9.jpg',
      lastMessage: 'See you at the party!',
      lastMessageTime: 'Yesterday',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.received,
    ),
    Chat(
      contactName: 'Friend 10',
      profilePhoto: 'assets/images/profile10.jpg',
      lastMessage: 'Let\'s go for a movie.',
      lastMessageTime: '1:30 PM',
      messageCount: 2,
      isTyping: false,
      readStatus: ReadStatus.read,
    ),
  ];

  List<Chat> filteredChats = [];

  @override
  void initState() {
    super.initState();
    filteredChats = chats;
  }

  void _filterChats(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredChats = chats;
      });
    } else {
      final lowerCaseQuery = query.toLowerCase();
      setState(() {
        filteredChats = chats.where((chat) {
          final contactNameLower = chat.contactName.toLowerCase();
          return contactNameLower.contains(lowerCaseQuery);
        }).toList();
      });
    }

    if (filteredChats.isEmpty && query.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Chat not found',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              'The chat you are searching for was not found.',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _addChatFromContact(Contact contact) {
    final chat = Chat(
      contactName: contact.displayName ?? '',
      profilePhoto: contact.avatar != null ? contact.avatar!.toString() : '',
      lastMessage: '',
      lastMessageTime: '',
      messageCount: 0,
      isTyping: false,
      readStatus: ReadStatus.notReceived,
    );

    setState(() {
      chats.add(chat);
      filteredChats.add(chat);
    });
  }

  Future<void> _selectContact() async {
    final contacts = await ContactsService.getContacts();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a contact'),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts.elementAt(index);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: contact.avatar != null
                        ? MemoryImage(contact.avatar!)
                        : null,
                  ),
                  title: Text(contact.displayName ?? ''),
                  onTap: () {
                    Navigator.pop(context);
                    _addChatFromContact(contact);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _openConversation(Chat chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationScreen(chat: chat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    filteredChats.sort((a, b) => a.lastMessageTime.compareTo(b.lastMessageTime));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
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
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterChats,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredChats.length,
              itemBuilder: (context, index) {
                final chat = filteredChats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(chat.profilePhoto),
                  ),
                  title: Text(chat.contactName),
                  subtitle: Row(
                    children: [
                      Icon(
                        chat.isTyping ? Icons.mode_edit : Icons.done_all,
                        size: 16,
                        color: Colors.indigo,
                      ),
                      SizedBox(width: 5),
                      Text(
                        chat.lastMessage,
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(chat.lastMessageTime),
                      SizedBox(height: 4),
                      if (chat.messageCount > 0)
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
                            '${chat.messageCount}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (chat.isTyping)
                        Text(
                          'Typing...',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                  onTap: () => _openConversation(chat),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _selectContact,
      ),
    );
  }
}


class ConversationScreen extends StatefulWidget {
  final Chat chat;

  const ConversationScreen({required this.chat});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}


class _ConversationScreenState extends State<ConversationScreen> {
  List<Message> messages = [];
  TextEditingController _messageController = TextEditingController();
  bool isRecording = false;
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    // Load initial messages
    messages = [
      Message(
        sender: 'Friend',
        text: 'Hey, how are you?',
        time: DateTime.now(),
      ),
      Message(
        sender: 'User',
        text: 'I\'m doing great. How about you?',
        time: DateTime.now().add(Duration(minutes: 2)),
      ),
      // Add more initial messages as needed
    ];
  }

  void _sendMessage() {
    String text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(Message(
          sender: 'User',
          text: text,
          time: DateTime.now(),
        ));
        _messageController.clear();
      });
    }
  }

  void _startRecording() {
    setState(() {
      isRecording = true;
      // TODO: Implement voice recording functionality
    });
  }

  void _stopRecording() {
    setState(() {
      isRecording = false;
      // TODO: Implement voice recording functionality
    });
  }

  void _selectFile() async {
    // TODO: Implement file selection logic (e.g., using file picker package)
    // You can update the `selectedFile` variable with the selected file
  }

  // Helper function to hide the keyboard when needed
  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.chat.profilePhoto),
            ),
            SizedBox(width: 8.0),
            Text(widget.chat.contactName),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // TODO: Implement audio call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              // TODO: Implement video call functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification> (
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  _hideKeyboard();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  bool isUserMessage = message.sender == 'User';

                  return Align(
                    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.indigo : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.sender,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isUserMessage ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            message.text,
                            style: TextStyle(
                              color: isUserMessage ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            DateFormat.jm().format(message.time),
                            style: TextStyle(
                              fontSize: 12,
                              color: isUserMessage ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _selectFile,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration.collapsed(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(isRecording ? Icons.stop : Icons.mic),
                  onPressed: isRecording ? _stopRecording : _startRecording,
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
    );
  }
}



class Message {
  final String sender;
  final String text;
  final DateTime time;

  Message({
    required this.sender,
    required this.text,
    required this.time,
  });
}

enum ReadStatus {
  notReceived,
  received,
  read,
}

class Chat {
  final String contactName;
  final String profilePhoto;
  final String lastMessage;
  final String lastMessageTime;
  final int messageCount;
  final bool isTyping;
  final ReadStatus readStatus;

  Chat({
    required this.contactName,
    required this.profilePhoto,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.messageCount,
    required this.isTyping,
    required this.readStatus,
  });
}
