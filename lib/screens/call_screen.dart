import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String callType = '';
  bool isInCall = false;
  bool isMuted = false;
  bool isVideoEnabled = true;
  List<String> participants = ['Friend 1'];

  void _startCall(String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start Call'),
          content: Text('Are you sure you want to start the $type?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  callType = type;
                  isInCall = true;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _endCall() {
    setState(() {
      isInCall = false;
    });
    Navigator.pop(context); // Route back to the call screen
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  void _toggleVideo() {
    setState(() {
      isVideoEnabled = !isVideoEnabled;
    });
  }

  Future<void> _selectContact() async {
    if (await Permission.contacts.request().isGranted) {
      final contacts = await ContactsService.getContacts();
      final selectedContact = await showDialog<Contact>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select a Contact'),
            content: Container(
              width: double.maxFinite,
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
                      Navigator.pop(context, contact);
                    },
                  );
                },
              ),
            ),
          );
        },
      );

      if (selectedContact != null) {
        _addParticipant(selectedContact.displayName ?? '');
      }
    } else {
      // Permission denied
      // You can handle the permission denied case here
    }
  }

  void _addParticipant(String participant) {
    setState(() {
      participants.add(participant);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInCall
        ? Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('In $callType Call...'),
            SizedBox(height: 20),
            Text(
              'Participants:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/profile_$index.jpg'),
                  ),
                  title: Text(participants[index]),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleMute,
                  child: Icon(isMuted ? Icons.mic_off : Icons.mic),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _toggleVideo,
                  child: Icon(isVideoEnabled
                      ? Icons.videocam
                      : Icons.videocam_off),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _selectContact,
                  child: Icon(Icons.person_add),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _endCall,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set the button color to red
                  ),
                  child: Icon(Icons.call_end),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(
          'Calls',
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
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile1.jpg'),
            ),
            title: Text('Friend 1'),
            subtitle: Row(
              children: [
                Icon(Icons.videocam, size: 16),
                SizedBox(width: 5),
                Text('Video Call - July 4, 10:30 AM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('video call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile2.jpg'),
            ),
            title: Text('Friend 2'),
            subtitle: Row(
              children: [
                Icon(Icons.call, size: 16),
                SizedBox(width: 5),
                Text('Audio Call - July 3, 5:45 PM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('audio call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile3.jpg'),
            ),
            title: Text('Meeting 1'),
            subtitle: Row(
              children: [
                Icon(Icons.videocam, size: 16),
                SizedBox(width: 5),
                Text('Video Call - July 2, 2:15 PM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('video call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile4.jpg'),
            ),
            title: Text('Group Call 1'),
            subtitle: Row(
              children: [
                Icon(Icons.call, size: 16),
                SizedBox(width: 5),
                Text('Audio Call - July 1, 5:00 PM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('audio call'),
            ),
          ),
          // Add more call entries as needed
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile5.jpg'),
            ),
            title: Text('Friend 3'),
            subtitle: Row(
              children: [
                Icon(Icons.videocam, size: 16),
                SizedBox(width: 5),
                Text('Video Call - June 30, 3:30 PM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('video call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile6.jpg'),
            ),
            title: Text('Friend 4'),
            subtitle: Row(
              children: [
                Icon(Icons.call, size: 16),
                SizedBox(width: 5),
                Text('Audio Call - June 29, 9:15 AM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('audio call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile7.jpg'),
            ),
            title: Text('Meeting 2'),
            subtitle: Row(
              children: [
                Icon(Icons.videocam, size: 16),
                SizedBox(width: 5),
                Text('Video Call - June 28, 4:45 PM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('video call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile8.jpg'),
            ),
            title: Text('Group Call 2'),
            subtitle: Row(
              children: [
                Icon(Icons.call, size: 16),
                SizedBox(width: 5),
                Text('Audio Call - June 27, 1:30 PM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('audio call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile9.jpg'),
            ),
            title: Text('Friend 5'),
            subtitle: Row(
              children: [
                Icon(Icons.videocam, size: 16),
                SizedBox(width: 5),
                Text('Video Call - June 26, 10:00 AM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('video call'),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
              AssetImage('assets/images/profile10.jpg'),
            ),
            title: Text('Friend 6'),
            subtitle: Row(
              children: [
                Icon(Icons.call, size: 16),
                SizedBox(width: 5),
                Text('Audio Call - June 25, 6:30 PM'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () => _startCall('audio call'),
            ),
          ),
        ],
      ),
    );
  }
}
