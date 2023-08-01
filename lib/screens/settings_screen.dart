import 'dart:io';
import 'package:cipher_comm/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _showConfirmationDialog(String itemName, VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $itemName?'),
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
                Navigator.pop(context);
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  void _editProfilePhoto() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.indigo,),
                title: Text('Select from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _profilePhoto = image.path;
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.indigo,),
                title: Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _profilePhoto = image.path;
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red,),
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
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteProfilePhoto() {
    // Implement logic for deleting profile photo
    setState(() {
      _profilePhoto = null;
    });
  }

  void _editUsername() async {
    String? newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? updatedName;
        return AlertDialog(
          title: Text('Edit Username'),
          content: TextField(
            onChanged: (value) {
              updatedName = value;
            },
            decoration: InputDecoration(hintText: 'Enter your new username'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _username = updatedName;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    if (newName != null) {
      setState(() {
        _username = newName;
      });
    }
  }

  void _editStatus() async {
    String? newStatus = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? updatedStatus;
        return AlertDialog(
          title: Text('Edit Status'),
          content: TextField(
            onChanged: (value) {
              updatedStatus = value;
            },
            decoration: InputDecoration(hintText: 'Enter your new status'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _status = updatedStatus;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    if (newStatus != null) {
      setState(() {
        _status = newStatus;
      });
    }
  }

  void _deleteStatus() {
    // Implement logic for deleting status
    _showConfirmationDialog('status', () {
      setState(() {
        _status = null;
      });
    });
  }

  void _viewAllAccountDetails() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Account: ${_account ?? 'Not specified'}'),
              SizedBox(height: 8),
              Text('Email: ${_email ?? 'Not specified'}'),
              SizedBox(height: 8),
              Text('Department: ${_department ?? 'Not specified'}'),
            ],
          ),
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

  void _viewAccount() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Options'),
          content: Column(
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
                leading: Icon(Icons.delete, color: Colors.red,),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteAccount();
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.indigo,),
                title: Text('View Information'),
                onTap: () {
                  Navigator.pop(context);
                  _viewAllAccountDetails();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editAccount() async {
    String? newAccount = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? updatedAccount = _account;
        return AlertDialog(
          title: Text('Edit Account'),
          content: TextField(
            onChanged: (value) {
              updatedAccount = value;
            },
            decoration: InputDecoration(hintText: 'Enter account information'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _account = updatedAccount;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    if (newAccount != null) {
      setState(() {
        _account = newAccount;
      });
    }
  }

  void _deleteAccount() {
    // Implement logic for deleting account
    _showConfirmationDialog('account', () {
      setState(() {
        _account = null;
      });
    });
  }

  void _editEmail() async {
    String? newEmail = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? updatedEmail;
        return AlertDialog(
          title: Text('Edit Email'),
          content: TextField(
            onChanged: (value) {
              updatedEmail = value;
            },
            decoration: InputDecoration(hintText: 'Enter your new email'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _email = updatedEmail;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    if (newEmail != null) {
      setState(() {
        _email = newEmail;
      });
    }
  }

  void _deleteEmail() {
    // Implement logic for deleting email
    _showConfirmationDialog('email', () {
      setState(() {
        _email = null;
      });
    });
  }

  void _editDepartment() async {
    String? newDepartment = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? updatedDepartment = _department;
        return AlertDialog(
          title: Text('Edit Department'),
          content: SizedBox(
            height: 200, // Set the height for the dropdown list
            child: SingleChildScrollView(
              child: DropdownButtonFormField<String>(
                value: updatedDepartment,
                onChanged: (value) {
                  updatedDepartment = value;
                },
                items: [
                  'Department 1',
                  'Department 2',
                  'Department 3',
                  'Department 4',
                  'Department 5',
                  'Department 6',
                  'Department 7',
                  'Department 8',
                  'Department 9',
                  'Department 10',
                ]
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _department = updatedDepartment;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    if (newDepartment != null) {
      setState(() {
        _department = newDepartment;
      });
    }
  }


  void _deleteDepartment() {
    // Implement logic for deleting department
    _showConfirmationDialog('department', () {
      setState(() {
        _department = null;
      });
    });
  }

  Widget _buildProfilePhoto() {
    if (_profilePhoto != null) {
      return GestureDetector(
        onTap: _editProfilePhoto,
        child: CircleAvatar(
          radius: 60,
          backgroundImage: FileImage(File(_profilePhoto!)),
        ),
      );
    } else {
      return GestureDetector(
        onTap: _editProfilePhoto,
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
          children: [
            Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 40,),
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
                                      leading: Icon(Icons.delete, color: Colors.red,),
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
                                      leading: Icon(Icons.info, color: Colors.indigo,),
                                      title: Text('View Information'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _viewAccount();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.edit, color: Colors.indigo,),
                                      title: Text('Edit'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _editAccount();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.delete, color: Colors.red,),
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
                                      leading: Icon(Icons.delete, color: Colors.red,),
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
                                        _editDepartment();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.delete, color: Colors.red,),
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
                ))
          ]
        ),
      ),
    );
  }
}
