// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart'; // Add fl_chart to your pubspec.yaml
import 'package:flutter/material.dart';
import 'package:team_31_health_app/data/database/journalRepo.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key, required this.journalRepo});
  JournalRepo journalRepo;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  String _nickname = "User";

  // Method to allow teh user to select image from photo gallery
  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_picture', pickedImage.path);
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_picture');
    final savedNickname = prefs.getString('nickname');
    setState(() {
      if (path != null) {
        _profileImage = File(path);
      }
      if (savedNickname != null) {
        _nickname = savedNickname;
      }
    });
  }

  // An alert box appears on the screen when the "Change Nickname" button is pressed
  void _changeNickname() async {
    final controller = TextEditingController(text: _nickname);
    final prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Nickname"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter new nickname here"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _nickname = controller.text;
              });
              prefs.setString('nickname', _nickname);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  late Future<List<Map<String, Object>>> activityData;
  @override
  void initState() {
    super.initState();
    activityData = getActivityData();
    _loadProfileData(); // Load the saved profile picture and nickname
  }

  void _showEnlargedProfileImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black,
              child: Center(child: _profileImage != null ? Image.file(_profileImage!) : Image.asset('assets/images/example_profile_picture.jpg')),
            ),
          ),
        ),
      ),
    );
  }

  // Get 5 Ways to WEllbeing data from the journalRepo
  Future<List<Map<String, Object>>> getActivityData() async {
    try {
      int give = await widget.journalRepo.count(0);
      int takeNotice = await widget.journalRepo.count(1);
      int keepLearning = await widget.journalRepo.count(2);
      int connect = await widget.journalRepo.count(3);
      int beActive = await widget.journalRepo.count(4);

      List<Map<String, Object>> activityData = [
        {
          'label': 'Give',
          'value': give.toDouble(),
          'colour': Colors.orange
        },
        {
          'label': 'Take Notice',
          'value': takeNotice.toDouble(),
          'colour': Colors.yellow
        },
        {
          'label': 'Keep Learning',
          'value': keepLearning.toDouble(),
          'colour': Colors.blue
        },
        {
          'label': 'Connect',
          'value': connect.toDouble(),
          'colour': Colors.purple
        },
        {
          'label': 'Be Active',
          'value': beActive.toDouble(),
          'colour': Colors.pinkAccent
        },
      ];
      return activityData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // For some reason I get a warning if I leave this in, despite the fact it's used
    // Getting rid of this results in an error
    // ignore: unused_local_variable
    ImageProvider backgroundImage;

    return FutureBuilder(
        future: activityData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Text("Loading");
          } else if (snapshot.hasError || !snapshot.hasData) {
            print(snapshot.hasError);
            return TextButton(
                onPressed: () {
                  setState(() {
                    activityData = getActivityData();
                  });
                },
                child: Text("Retry"));
          } else {
            // Calculate total to be used in percentage calculation of pie chart segments
            double total = 0.0;
            for (var item in snapshot.data!) {
              total += item['value'] as double;
            }

            return Scaffold(
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 32, top: 32),
                        child: Text(
                          "Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Profile picture
                              GestureDetector(
                                onTap: () => _showEnlargedProfileImage(context), // shows enlarged image when pressed
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _profileImage != null ? backgroundImage = backgroundImage = FileImage(_profileImage!) : backgroundImage = AssetImage('assets/images/example_profile_picture.jpg'),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Button to change profile picture
                              ElevatedButton.icon(
                                onPressed: _pickImage,
                                icon: const Icon(Icons.photo_library, color: Colors.white),
                                label: const Text("Change Profile Picture", style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),

                              const SizedBox(height: 16),

                              Text(
                                "Hello $_nickname",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 24),
                              const Text("Activity Breakdown", style: TextStyle(fontSize: 18)),
                              const SizedBox(height: 16),

                              _buildActivityPieChart(total),

                              const SizedBox(height: 32),
                              _buildActionButton(context, "Change Nickname", Icons.edit, _changeNickname, color: Colors.green),
                              // For the sake of the demo, the buttons below are placeholders
                              _buildActionButton(context, "Change Password", Icons.lock, () {}, color: Colors.green),
                              _buildActionButton(context, "Delete Account", Icons.delete_forever, () {}, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget _buildActivityPieChart(double total) {
    return FutureBuilder(
        future: activityData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Text("Loading");
          }
          if (snapshot.hasError || !snapshot.hasData) {
            setState(() {
              activityData = getActivityData();
            });
            return Text("Retrying");
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                          color: Colors.grey,
                        ),
                      ),
                      PieChart(
                        PieChartData(
                          // Mapping the activities to the pie chart
                          sections: snapshot.data!.map((d) {
                            return PieChartSectionData(
                              value: d['value'] as double,
                              color: d['colour'] as Color,
                              radius: 100,
                              showTitle: false,
                            );
                          }).toList(),
                          centerSpaceRadius: 0,
                          sectionsSpace: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Lists pie chart percentages next to the chart
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!.asMap().entries.map((entry) {
                    final data = entry.value;
                    final value = data['value'] as double;
                    String percentage = ((value / total) * 100).toStringAsFixed(1); // Calculate percentage to 1 d.p.

                    // Error correct in case of no journal entries
                    if (percentage == "NaN") {
                      percentage = '0';
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: data['colour'] as Color,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Print out percentage for the given segment
                          Text(
                            "${data['label']}: $percentage%",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }
        });
  }

  // Button with press animation
  Widget _buildActionButton(BuildContext context, String label, IconData icon, VoidCallback onPressed, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
