import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact {
  final String name;
  final String phoneNumber;

  Contact({
    required this.name,
    required this.phoneNumber,
  });
}

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contacts = [
    Contact(name: 'John Doe', phoneNumber: '+1234567890'),
    Contact(name: 'Jane Smith', phoneNumber: '+0987654321'),
    // Add more contacts here
  ];

  void createContact() {
    // Implement logic for creating a new contact
  }

  void inviteContact() {
    // Implement logic for inviting a new contact
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(contact.name.substring(0, 1)),
            ),
            title: Text(contact.name),
            subtitle: Text(contact.phoneNumber),
            onTap: () {
              // Implement logic for handling contact selection
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Create or Invite Contact'),
                content: Text('Choose an option to add a contact.'),
                actions: [
                  TextButton(
                    child: Text('Create Contact'),
                    onPressed: () {
                      Navigator.pop(context);
                      createContact();
                    },
                  ),
                  TextButton(
                    child: Text('Invite Contact'),
                    onPressed: () {
                      Navigator.pop(context);
                      inviteContact();
                    },
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add Contact'),
      ),
    );
  }
}
