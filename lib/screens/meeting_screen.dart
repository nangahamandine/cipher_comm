import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  List<String> upcomingMeetings = [
    'Meeting 1',
    'Meeting 2',
    'Meeting 3',
    'Meeting 4',
  ];

  List<String> filteredMeetings = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMeetings.addAll(upcomingMeetings);
  }

  void _showNewMeetingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Meeting'),
          content: Text('Create a new meeting and get a link to share.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Add logic to create a new meeting and get the link
              },
              child: Text('Create'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showScheduleMeetingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Schedule Meeting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add form fields to get meeting details like title, date, time, duration, etc.
              // For simplicity, I'll just add a text here.
              Text('Add form fields here'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Add logic to schedule a new meeting and get the link
              },
              child: Text('Schedule'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showJoinMeetingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Join Meeting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add form fields to get the meeting link from the user.
              // For simplicity, I'll just add a text here.
              Text('Enter meeting link here'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Add logic to join the meeting using the link
              },
              child: Text('Join'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showCalendarPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Calendar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add user's personalized calendar here.
              // For simplicity, I'll just add a text here.
              Text('Add user calendar here'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEditMeetingPopup(BuildContext context, String meetingTitle) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Meeting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add form fields to edit meeting details.
              // For simplicity, I'll just add a text here.
              Text('Edit meeting: $meetingTitle'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Add logic to update the meeting details
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteMeetingPopup(BuildContext context, String meetingTitle) {
    showDialog(
      context: context,
      builder: (context) {
        bool isDeleting = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Delete Meeting'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Are you sure you want to delete the meeting: $meetingTitle?'),
                  SizedBox(height: 16),
                  if (isDeleting)
                    CircularProgressIndicator()
                  else
                    Text('Tap twice to delete'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (isDeleting) return;
                    setState(() {
                      isDeleting = true;
                    });
                    // Add logic to delete the meeting
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Delete'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Ink(
              // decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   color: Colors.grey[100],
              // ),
              child: IconButton(
                icon: Icon(icon, size: 40),
                color: color,
                onPressed: onPressed,
              ),
            ),
            SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingMeetingsTable(BuildContext context) {
    return DataTableTheme(
        data: DataTableThemeData(
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.indigo,
          ),
        ),
        child: DataTable(
          columns: [
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Duration')),
            DataColumn(label: Text('Time Left')),
            DataColumn(label: Text('Action')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('Meeting with the computer unit department')),
                DataCell(Text('1 hour')),
                DataCell(Text('30 minutes')),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.indigo,),
                      onPressed: () => _showEditMeetingPopup(context, 'Meeting 1'),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => _showDeleteMeetingPopup(context, 'Meeting 1'),
                    ),
                  ],
                )),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Meeting 2')),
                DataCell(Text('2 hours')),
                DataCell(Text('1 hour')),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.indigo,),
                      onPressed: () => _showEditMeetingPopup(context, 'Meeting 2'),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => _showDeleteMeetingPopup(context, 'Meeting 2'),
                    ),
                  ],
                )),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Meeting 3')),
                DataCell(Text('4 hours')),
                DataCell(Text('30 minutes')),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.indigo,),
                      onPressed: () => _showEditMeetingPopup(context, 'Meeting 1'),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => _showDeleteMeetingPopup(context, 'Meeting 1'),
                    ),
                  ],
                )),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Meeting 4')),
                DataCell(Text('8 hours')),
                DataCell(Text('1 hour')),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.indigo,),
                      onPressed: () => _showEditMeetingPopup(context, 'Meeting 1'),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => _showDeleteMeetingPopup(context, 'Meeting 1'),
                    ),
                  ],
                )),
              ],
            ),
          ],
        )
    );

  }

  void _filterMeetings(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMeetings.clear();
        filteredMeetings.addAll(upcomingMeetings);
      } else {
        filteredMeetings = upcomingMeetings
            .where((meeting) => meeting.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    if (filteredMeetings.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No meetings found', style: TextStyle(color: Colors.red)),
            content: Text('There are no meetings matching your search criteria.', style: TextStyle(color: Colors.black)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings', style: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 24, // Set your desired font size
            fontWeight: FontWeight.bold, // Set the font weight to bold
          ),
        ),
        ),
        elevation: 0,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _MeetingSearchDelegate(
                  filteredMeetings: filteredMeetings,
                  filterMeetings: _filterMeetings,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(
                  icon: Icons.video_call,
                  label: 'New Meeting',
                  color: Colors.indigo,
                  onPressed: () => _showNewMeetingPopup(context),
                ),
                _buildIconButton(
                  icon: Icons.schedule,
                  label: 'Schedule',
                  color: Colors.indigo,
                  onPressed: () => _showScheduleMeetingPopup(context),
                ),
                _buildIconButton(
                  icon: Icons.meeting_room,
                  label: 'Join',
                  color: Colors.indigo,
                  onPressed: () => _showJoinMeetingPopup(context),
                ),
                _buildIconButton(
                  icon: Icons.calendar_today,
                  label: 'Calendar',
                  color: Colors.indigo,
                  onPressed: () => _showCalendarPopup(context),
                ),
              ],
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Upcoming Meetings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildUpcomingMeetingsTable(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeetingSearchDelegate extends SearchDelegate<String> {
  final List<String> filteredMeetings;
  final Function(String) filterMeetings;
  bool _isDialogShown = false;

  _MeetingSearchDelegate({
    required this.filteredMeetings,
    required this.filterMeetings,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Replace with your search results widget
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? filteredMeetings
        : filteredMeetings
        .where((meeting) => meeting.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestions.isEmpty && !_isDialogShown) {
      _isDialogShown = true;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('No meetings found', style: TextStyle(color: Colors.red)),
              content: Text('There are no meetings matching your search criteria.', style: TextStyle(color: Colors.black)),
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
        ).then((_) {
          _isDialogShown = false;
        });
      });
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Scrollbar(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final String suggestion = suggestions[index];
                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    close(context, suggestion);
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

