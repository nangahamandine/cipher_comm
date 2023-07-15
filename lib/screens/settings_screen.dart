import 'package:cipher_comm/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.indigo,),
            title: Text('Profile'),
            onTap: () {
              _navigateToProfile(context); // Navigate to the profile screen
            },
          ),
          ListTile(
            leading: Icon(Icons.chat, color: Colors.indigo,),
            title: Text('Chats'),
            onTap: () {
              // Navigate to the chat settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.indigo,),
            title: Text('Notifications'),
            onTap: () {
              // Navigate to the notification settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.indigo,),
            title: Text('Privacy'),
            onTap: () {
              // Navigate to the privacy settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.data_usage, color: Colors.indigo,),
            title: Text('Data and Storage'),
            onTap: () {
              // Navigate to the data and storage settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.indigo,),
            title: Text('Help'),
            onTap: () {
              // Navigate to the help screen
            },
          ),
          ListTile(
            leading: Icon(Icons.language, color: Colors.indigo,),
            title: Text('Language'),
            onTap: () {
              // Navigate to the language settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.indigo,),
            title: Text('Logout'),
            onTap: () {
              _logout(context); // Call the logout function
            },
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _profilePhoto;
  String? _username;
  String? _status;
  String? _account;
  String? _email;
  String? _department;

  void _editProfilePhoto() {
    // Implement logic for editing profile photo
    setState(() {
      // Update the profile photo
    });
  }

  void _deleteProfilePhoto() {
    // Implement logic for deleting profile photo
    setState(() {
      _profilePhoto = null;
    });
  }

  void _editUsername() {
    // Implement logic for editing username
    setState(() {
      // Update the username
    });
  }

  void _deleteUsername() {
    // Implement logic for deleting username
    setState(() {
      _username = null;
    });
  }

  void _editStatus() {
    // Implement logic for editing status
    setState(() {
      // Update the status
    });
  }

  void _deleteStatus() {
    // Implement logic for deleting status
    setState(() {
      _status = null;
    });
  }

  void _editAccount() {
    // Implement logic for editing account
    setState(() {
      // Update the account
    });
  }

  void _deleteAccount() {
    // Implement logic for deleting account
    setState(() {
      _account = null;
    });
  }

  void _editEmail() {
    // Implement logic for editing email
    setState(() {
      // Update the email
    });
  }

  void _deleteEmail() {
    // Implement logic for deleting email
    setState(() {
      _email = null;
    });
  }

  void _editDepartment() {
    // Implement logic for editing department
    setState(() {
      // Update the department
    });
  }

  void _deleteDepartment() {
    // Implement logic for deleting department
    setState(() {
      _department = null;
    });
  }

  void _showProfilePhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: Colors.indigo,),
                title: Text('Edit Profile Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _editProfilePhoto();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.indigo,),
                title: Text('Delete Profile Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteProfilePhoto();
                },
              ),
              ListTile(
                title: Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteProfilePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfilePhoto() {
    if (_profilePhoto != null) {
      return GestureDetector(
        onTap: () => _showProfilePhotoOptions(context),
        child: CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(_profilePhoto!),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => _showProfilePhotoOptions(context),
        child: CircleAvatar(
          radius: 60,
          child: Icon(Icons.person),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProfilePhoto(), // Display the profile photo
            SizedBox(height: 40),
            ListTile(
              leading: Icon(Icons.person, color: Colors.indigo,),
              title: Text('Username'),
              subtitle: _username != null ? Text(_username!) : null,
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: Colors.indigo,),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.indigo,),
                              title: Text('Edit'),
                              onTap: () {
                                Navigator.pop(context);
                                _editUsername();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.indigo,),
                              title: Text('Delete'),
                              onTap: () {
                                Navigator.pop(context);
                                _deleteUsername();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.post_add, color: Colors.indigo,),
              title: Text('Status'),
              subtitle: _status != null ? Text(_status!) : null,
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: Colors.indigo,),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.indigo,),
                              title: Text('Edit'),
                              onTap: () {
                                Navigator.pop(context);
                                _editStatus();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.indigo,),
                              title: Text('Delete'),
                              onTap: () {
                                Navigator.pop(context);
                                _deleteStatus();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.indigo,),
              title: Text('Account'),
              subtitle: _account != null ? Text(_account!) : null,
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: Colors.indigo,),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.indigo,),
                              title: Text('Edit'),
                              onTap: () {
                                Navigator.pop(context);
                                _editAccount();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.indigo,),
                              title: Text('Delete'),
                              onTap: () {
                                Navigator.pop(context);
                                _deleteAccount();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.indigo,),
              title: Text('Email'),
              subtitle: _email != null ? Text(_email!) : null,
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: Colors.indigo,),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.indigo,),
                              title: Text('Edit'),
                              onTap: () {
                                Navigator.pop(context);
                                _editEmail();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.indigo,),
                              title: Text('Delete'),
                              onTap: () {
                                Navigator.pop(context);
                                _deleteEmail();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.indigo,),
              title: Text('Department'),
              subtitle: _department != null ? Text(_department!) : null,
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.indigo,),
                              title: Text('Edit'),
                              onTap: () {
                                Navigator.pop(context);
                                _editDepartment();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.indigo,),
                              title: Text('Delete'),
                              onTap: () {
                                Navigator.pop(context);
                                _deleteDepartment();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
