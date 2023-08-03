import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:clipboard/clipboard.dart';
import 'package:image_picker/image_picker.dart';
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

  void _viewProfilePhoto(BuildContext context, String profilePhoto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePhotoScreen(profilePhoto: profilePhoto),
      ),
    );
  }

  Widget _buildAvatar(String profilePhoto) {
    return GestureDetector(
      onTap: () => _viewProfilePhoto(context, profilePhoto),
      child: Hero(
        tag: 'profile_photo_$profilePhoto',
        child: CircleAvatar(
          backgroundImage: AssetImage(profilePhoto),
        ),
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
            child: Flexible(
              child: ListView.builder(
                itemCount: filteredChats.length,
                itemBuilder: (context, index) {
                  final chat = filteredChats[index];
                  return ListTile(
                    leading: _buildAvatar(chat.profilePhoto),
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


class ProfilePhotoScreen extends StatelessWidget {
  final String profilePhoto;

  const ProfilePhotoScreen({required this.profilePhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color for the screen
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // When the user taps on the screen, pop the screen to go back
          },
          child: Hero(
            tag: 'profile_photo_${profilePhoto}',
            child: Image.asset(profilePhoto),
          ),
        ),
      ),
    );
  }
}


class ProfileInfoScreen extends StatelessWidget {
  final String contactName;
  final String profilePhoto;
  final String status;
  final String phoneNumber;
  final String email;
  final String department;

  const ProfileInfoScreen({
    required this.contactName,
    required this.profilePhoto,
    required this.phoneNumber,
    required this.email,
    required this.status,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(profilePhoto),
              radius: 60,
            ),
            SizedBox(height: 16),
            Text(
              contactName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Phone Number: $phoneNumber',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Department: $department',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Status: $status',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
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

  void _viewProfilePhoto(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePhotoScreen(profilePhoto: widget.chat.profilePhoto),
      ),
    );
  }

  void _openProfileInfo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileInfoScreen(
          contactName: widget.chat.contactName,
          profilePhoto: widget.chat.profilePhoto,
          phoneNumber: '+1 123 456 7890',
          email: 'user@example.com',
          status: 'Active',
          department: 'Department A',
        ),
      ),
    );
  }

  void _initiateAudioCall() {
    // TODO: Replace this function with your actual implementation to initiate an audio call
    print('Initiating audio call with ${widget.chat.contactName}');
  }

  void _initiateVideoCall() {
    // TODO: Replace this function with your actual implementation to initiate a video call
    print('Initiating video call with ${widget.chat.contactName}');
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

  void _editMessage(Message message) {
    // When edit button is pressed, fill the message controller with the current message text
    setState(() {
      _messageController.text = message.text;
      editingIndex = messages.indexOf(message);
    });
  }

  void _deleteMessage(Message message) {
    setState(() {
      messages.remove(message);
    });
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
    _messageController.text = 'Reply to ${message.sender}: ${message.text}\n';
    _messageController.selection =
        TextSelection.fromPosition(TextPosition(offset: _messageController.text.length));
    FocusScope.of(context).requestFocus(_messageFocusNode);
  }

  void _forwardMessage(Message message) {
    _messageController.text = 'Forwarded Message:\n${message.text}\n';
    _messageController.selection =
        TextSelection.fromPosition(TextPosition(offset: _messageController.text.length));
    FocusScope.of(context).requestFocus(_messageFocusNode);
  }

  void _starMessage(Message message) {
    // You can update the message to mark it as starred in your data model.
    // For this example, I'm updating the UI only (changing the color of the message bubble).
    setState(() {
      message.isStarred = !message.isStarred;
    });
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

  Future<void> _selectFile() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.attach_file, color: Colors.indigo,),
                title: Text('Attach Document'),
                onTap: () {
                  Navigator.pop(context);
                  _pickDocument();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.indigo,),
                title: Text('Attach Photo or Video'),
                onTap: () {
                  Navigator.pop(context);
                  _pickPhotoOrVideo();
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_mail, color: Colors.indigo,),
                title: Text('Attach Contact'),
                onTap: () {
                  Navigator.pop(context);
                  _pickContact();
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.indigo,),
                title: Text('Send Live Location'),
                onTap: () {
                  Navigator.pop(context);
                  _sendLiveLocation();
                },
              ),
              ListTile(
                leading: Icon(Icons.poll, color: Colors.indigo,),
                title: Text('Create Poll'),
                onTap: () {
                  Navigator.pop(context);
                  _openPollDialog;
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.indigo,),
                title: Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper functions for each attachment option

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'], // Add other supported extensions if needed
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.single.path!);
      // Do something with the selected document file
    }
  }

  Future<void> _pickPhotoOrVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov'], // Add other supported extensions if needed
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.single.path!);
      // Do something with the selected photo or video file
    }
  }

  Future<void> _pickContact() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    // Display the contacts in a dialog or any other way you prefer
    // When the user selects a contact, addChatFromContact(contact) can be called similar to what you have done before
  }


  Future<void> _sendLiveLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    // Use the 'position' object to get the latitude and longitude and send it as the live location
    // You can use this information to display the location on the map or send it as a text message
  }

  Future<void> _showPollDialog(BuildContext context) async {
    String question = '';
    List<String> options = ['', '']; // Initialize with two empty options

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Create a Poll'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Question'),
                    onChanged: (value) {
                      setState(() {
                        question = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ...List.generate(
                    options.length,
                        (index) => TextField(
                      decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                      onChanged: (value) {
                        setState(() {
                          options[index] = value;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        options.add(''); // Add a new empty option
                      });
                    },
                    child: Text('Add Option'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate the inputs before submitting the poll
                    if (question.trim().isEmpty || options.any((option) => option.trim().isEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in the question and all options.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Create the poll object and do something with it
                    Poll poll = Poll(question: question, options: options);
                    _handlePollSubmission(poll);

                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: Text('Send'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to handle poll submission
  void _handlePollSubmission(Poll poll) {
    // You can send the poll to the recipient or store it in the conversation as needed
    // For this example, let's just print the poll data
    print('Poll Question: ${poll.question}');
    print('Poll Options: ${poll.options}');
  }

  void _openPollDialog() {
    _showPollDialog(context);
  }

  Future<void> _takePhoto() async {
    final imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      // Do something with the captured photo
    }
  }

  // Helper function to hide the keyboard when needed
  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
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
              ListTile(
                leading: Icon(Icons.edit, color: Colors.indigo,),
                title: Text('Edit Message'),
                onTap: () {
                  Navigator.pop(context); // Close the pop-up
                  _editMessage(message);
                },
              ),
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
              ListTile(
                leading: Icon(Icons.star, color: Colors.yellow),
                title: Text('Star Message'),
                onTap: () {
                  Navigator.pop(context); // Close the pop-up
                  _starMessage(message);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: () => _viewProfilePhoto(context),
      child: Hero(
        tag: 'profile_photo_${widget.chat.contactName}',
        child: CircleAvatar(
          backgroundImage: AssetImage(widget.chat.profilePhoto),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isUserMessage = message.sender == 'User';

    return GestureDetector(
      onLongPress: () {
        if (isUserMessage) {
          _showMessageOptions(message); // Show the pop-up menu
        }
      },
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
            if (message.isStarred)
              Icon(
                Icons.star,
                size: 16,
                color: Colors.yellow,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _openProfileInfo,
          child: Row(
            children: [
              _buildAvatar(),
              SizedBox(width: 8.0),
              Text(widget.chat.contactName),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: _initiateAudioCall,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _initiateVideoCall,
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
                  return Align(
                    alignment: message.sender == 'User'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: _buildMessageBubble(message),
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
                  child: Focus(
                    // Use Focus widget to handle focus behavior
                    onFocusChange: (hasFocus) {
                      // Handle focus changes if needed
                    },
                    child: TextField(
                      controller: _messageController,
                      focusNode: _messageFocusNode,
                      decoration: InputDecoration.collapsed(hintText: 'Type a message'),
                    ),
                  ),
                ),
                Container(
                  height: 48.0, // Set the height of the send button container
                  child: IconButton(
                    icon: Icon(isRecording ? Icons.stop : Icons.mic),
                    onPressed: isRecording ? _stopRecording : _startRecording,
                  ),
                ),
                Container(
                  height: 48.0, // Set the height of the send button container
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
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
  bool isStarred;

  Message({
    required this.sender,
    required this.text,
    required this.time,
    this.isStarred = false,
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

class Poll {
  String question;
  List<String> options;

  Poll({required this.question, required this.options});
}
